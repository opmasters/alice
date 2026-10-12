# aliceOS userspace bootstrap

This directory is reserved for the first user-mode programs and their OS-specific integration layer.

## Why it is not yet a runnable init

The current repository inspection did not establish a documented userspace syscall ABI or prove that `nos` can transition to and load an unprivileged ELF process. The existing Rust filesystem implementation is kernel-internal and is not automatically callable from a user application. Guessing syscall numbers or calling kernel internals from a GUI would be unsafe.

## Bootstrap order

1. Document and test the actual syscall entry and user-mode transition.
2. Implement a minimal static `init` process and a basic command interpreter.
3. Provide file descriptors, process creation/wait, pipes, terminal/PTY and IPC.
4. Implement an aliceOS service manager and authenticated service endpoints.
5. Port/build Qt runtime dependencies and implement a Qt QPA backend only after graphics and input APIs are available.

The desktop under `../` remains a host-runnable prototype until these kernel/userland prerequisites are satisfied.
