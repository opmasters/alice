# aliceOS integration plan

This plan tracks the work required to connect the aliceOS desktop/userspace to the `nos` kernel. Checkboxes represent verified work only; a design note or prototype does not count as a boot-tested kernel feature.

## 1. Verify CPU privilege transitions

- [x] Inspect x86-64 GDT/TSS, IDT, per-CPU assumptions, task abstractions and search the kernel sources for syscall/user-mode paths.
- [x] Record the key finding: `src/cpp/arch/x86_64/percpu.h` explicitly says there is no user mode; `gdt.h` documents the TSS as using IST only and its `Rsp0` is not configured by the inspected setup code.
- [x] Record that the Rust VFS and shell are kernel-side, not a userspace syscall ABI.
- [ ] Design and implement ring-3 GDT descriptors, per-CPU kernel-entry stacks, a controlled user entry/return frame, and safe exception handling.
- [ ] Implement syscall entry/exit with validated user pointers and defined ABI semantics.
- [ ] Add emulator tests proving user code runs unprivileged and cannot access kernel memory.

**Status:** Source audit completed; implementation is blocked on the missing user-mode architecture. Do not boot arbitrary user code until the complete transition and isolation path exists.

## 2. Implement or complete process isolation

- [ ] Audit page-table APIs and kernel/user page permissions, including NX, supervisor-only mappings and address-space lifetime.
- [ ] Implement per-process address spaces and safe mapping/unmapping.
- [ ] Implement a bounded ELF64 loader that validates headers, segment ranges, alignment, overflow and entry point.
- [ ] Create isolated process state, user stack, argument/environment layout, process exit and wait semantics.
- [ ] Add tests for malformed ELF files, invalid pointers, cross-process memory access and cleanup.

**Status:** Not complete. Existing kernel task/page-table components do not by themselves prove isolated user processes.

## 3. Expose kernel services

- [ ] Define a versioned syscall ABI with fixed-width structures, error codes and feature discovery.
- [ ] Expose file operations over the existing VFS through validated user-facing handles (not direct kernel pointers).
- [ ] Add process, memory, clock/sleep, event, pipe and IPC interfaces.
- [ ] Add identity/permission enforcement in the kernel and authenticated IPC for privileged services.
- [ ] Add ABI conformance and negative/security tests.

**Status:** Not complete. The Rust VFS documents C ABI access for C++ and modules, which is a kernel-internal boundary, not an application syscall API.

## 4. Boot aliceOS init and shell

- [ ] Add a statically linked userspace init image built for the documented ABI.
- [ ] Load and launch init from the kernel through the process/ELF subsystem.
- [ ] Provide console or PTY-backed stdin/stdout/stderr and terminal control.
- [ ] Launch a simple command interpreter as an ordinary unprivileged process.
- [ ] Verify file read/write, command execution, process exit status and recovery from a crashed child.

**Status:** Not complete. The existing `nos` shell is registered inside kernel initialization and is not a userspace shell.

## 5. Start system services

- [ ] Add service supervision, networking APIs, device management and permissions.

## 6. Bring up the graphical desktop

- [ ] Implement display/input integration and a Qt platform backend, then launch Qt Quick.

## Current implementation artifacts

- `aliceos/ABI_AUDIT.md` — repository findings and integration gate.
- `aliceos/userspace/ABI.md` — proposed ABI design checklist; explicitly not an implemented syscall ABI.
- `aliceos/userspace/README.md` — userspace bootstrap sequence.
- `aliceos/Main.qml` — host-side desktop prototype; hardware/system controls remain placeholders until services and ABI exist.

## Safety gate

Do not mark steps 1–4 complete based on documentation alone. Completion requires implementation plus relevant tests, and step 4 requires a successful boot test. Do not wire QML or Qt directly to kernel-internal functions.
