# nos → aliceOS kernel/userspace ABI audit

**Status: first source inspection complete; user-mode ABI not established.** This is an integration gate, not a claim that missing features do not exist elsewhere in the repository.

## Confirmed from source

- `src/rust/kernel/src/lib.rs` is `#![no_std]`, builds as part of the kernel and exports `rust_init()`. That initializer registers in-kernel components and drivers.
- `src/rust/fs/src/lib.rs` is also `#![no_std]`. Its documentation describes a kernel VFS and notes that C++ and modules enter through a C ABI. It exposes `vfs_instance()` for other kernel crates and `kernel_file_*`-style interfaces for C++/modules. These are kernel-side interfaces, not a userspace syscall ABI.
- The filesystem crate registers shell commands through `fs::init()`; its shell is currently part of kernel initialization.
- `src/cpp/kernel/task.h` defines a kernel `Task` with a kernel callback signature (`void (*)(void*)`). This alone does not establish isolated user processes or an ELF userspace loader.
- `src/cpp/kernel/main.cpp` initializes low-level kernel subsystems and drivers.

## Required audit before modifying the kernel

For each item, record implementation path, API, privilege level, current test, and missing work.

| Capability | Needed for aliceOS | Audit result |
| --- | --- | --- |
| User-mode transition | Start ring-3 processes safely | Not established by inspected sources |
| Syscall entry/exit | Stable user/kernel boundary | Not established by inspected sources |
| Process creation and wait | Launch shell and applications | Kernel task abstraction exists; user-process API not established |
| ELF loader and dynamic linker | Launch native programs / Qt runtime | Not established by inspected sources |
| Address-space isolation | Separate user processes | Not established by inspected sources |
| File descriptors and VFS syscalls | Files, config, logs and pipes | Kernel VFS exists; user syscall API not established |
| Pipes, PTYs, terminal control | Interactive terminal | Not established by inspected sources |
| IPC | Desktop ↔ system services | Not established by inspected sources |
| Users/groups/credentials | Access control | Not established by inspected sources |
| Socket API | Network manager | Kernel networking crate exists; user API not established |
| Display/input API | Qt QPA backend | Kernel input/graphics support must be audited; user API not established |
| Timer/clock/sleep | Event loops and scheduling | Kernel timer/time components exist; user API not established |
| Entropy API | Secure identifiers and cryptography | Kernel random component exists; user API not established |
| Module/service lifecycle | Hardware and background services | Kernel modules exist; user-level service model not established |

## Safe integration rule

Do not wire the desktop directly to internal kernel C++/Rust functions. Kernel functions may run only in kernel context and may assume locks, memory mappings or interrupt state that user applications cannot safely provide. Introduce documented syscalls or a narrow authenticated IPC service API first.

## Next implementation sequence

1. Audit syscall entry, privilege transitions, task/address-space creation and ELF loading across the full source tree.
2. If absent, implement the minimum user ABI: `read`, `write`, `open`, `close`, `stat`, `mmap`, `spawn/exec`, `wait`, `exit`, clock/sleep, and an IPC primitive. These names are proposals, not existing ABI.
3. Boot a small statically linked userspace init and shell before adding a GUI.
4. Add PTY and process-launch APIs; verify terminal I/O.
5. Add authenticated IPC and service supervision.
6. Add display/input support and a Qt QPA platform plugin, then prove a minimal Qt Quick app can launch.
7. Add users/groups, enforced permissions and privileged-service mediation before enabling settings that modify system state.

## Acceptance tests

- User process cannot read/write kernel memory or another process's memory.
- Invalid syscall pointers and malformed IPC requests fail safely.
- A process can start, read/write a file, communicate over a pipe/IPC channel, and exit with a retrievable status.
- Permission-denied operations fail even if the client bypasses the GUI.
- The kernel and userspace ABI version are documented and tested.
