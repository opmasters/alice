# Proposed minimum userspace ABI (not implemented)

This is a design checklist only. Do not treat the names below as existing nos syscalls or use guessed syscall numbers.

## Process and memory
- `process_spawn(image, argv, env, stdio, flags)`
- `process_wait(pid, status)`
- `process_exit(status)`
- `vm_map(address, length, protection, flags, handle, offset)`
- `vm_unmap(address, length)`

## File and terminal
- `file_open(path, flags, mode)`, `file_close(handle)`
- `file_read(handle, buffer, length)`, `file_write(handle, buffer, length)`
- `file_stat(path, result)`, `file_readdir(handle, result)`
- `pipe_create(read_handle, write_handle)`
- `pty_create(master, slave)`, terminal resize and foreground-process-group controls

## IPC and event loop
- `channel_create(peer, flags)`, `channel_send`, `channel_receive`
- `event_wait(handles, deadline)`
- Explicit peer credentials and access-control checks for privileged service endpoints

## Identity and security
- Kernel-enforced user/group identity, object ownership and permission checks
- A privileged broker with an allowlist of operations and auditable decisions
- No general-purpose privileged syscall exposed to arbitrary desktop clients

## ABI requirements
- Fixed-width integer types and documented structure layout/alignment
- Versioning and feature discovery
- Copy/validate user pointers at the kernel boundary; never trust user-supplied lengths or nested pointers
- Stable error codes and defined interruption semantics
- Tests for invalid pointers, overflow, permission failures, stale handles and cross-process access
