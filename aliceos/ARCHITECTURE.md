# aliceOS architecture and implementation plan

## Layers

1. **nos kernel core** — scheduling, memory protection, interrupt handling, drivers and the syscall ABI. Add missing primitives here only when justified by the documented kernel interfaces.
2. **aliceOS base userspace** — C/C++ runtime, process launcher, filesystem and device interfaces, IPC, user/group identity, capability/permission checks, logging and service supervision.
3. **System services** — network manager, Bluetooth manager, audio, power, device discovery, notification daemon, session manager and software/package service. Expose narrow authenticated IPC APIs.
4. **Graphics platform** — display server/compositor or supported framebuffer backend, input routing, window management, Qt QPA platform plugin, Qt Quick scene graph and GPU/software rendering support.
5. **Desktop and applications** — QML + Qt Quick + Kirigami shell, settings, terminal, file manager, system monitor and application center.

## Security requirements

- Default to unprivileged user sessions; reserve UID 0/root for maintenance and tightly controlled system services.
- Privileged actions must be mediated by a small broker with explicit operation allowlists, caller identity checks, audit records and re-authentication where appropriate.
- Enforce ownership, permissions and process isolation in the kernel/userspace security boundary, not in QML.
- SELinux requires kernel LSM-style hooks or an equivalent mandatory-access-control mechanism, policy loading, labeling, audit integration and a compatible userspace. Do not claim SELinux support until these exist and are tested.
- Use signed package metadata and artifacts, dependency verification, rollback-safe updates and an explicit trusted repository configuration.
- Services should run with least privilege, isolated filesystem/device access, resource limits and restart policies.
- Test privilege escalation boundaries, malformed IPC messages, package signature failures and policy-denial behavior.

## Feature status

| Area | Current status | Integration needed |
| --- | --- | --- |
| QML desktop shell | Prototype | Qt 6 runtime and platform plugin |
| Terminal UI | Prototype interaction | PTY/process execution and shell |
| Wi-Fi / Bluetooth | Not implemented | Device drivers, network and Bluetooth services |
| Accounts and permissions | Design only | Identity database, kernel enforcement, authentication and privilege broker |
| SELinux | Not implemented | MAC enforcement hooks, policy engine and audit |
| Software center | Design only | Package format, repositories, signatures and package daemon |
| Audio / power / notifications | Not implemented | Device and session services |

## Milestones

- **M1 — shell prototype:** responsive visual shell and component structure (this directory).
- **M2 — kernel ABI audit:** document existing syscalls, scheduling, process, VM, VFS and device capabilities; write a userspace compatibility test suite.
- **M3 — minimal userspace:** runtime, init/service manager, process execution, IPC, filesystem, user identity and logging.
- **M4 — graphics:** display/input backend and Qt platform integration; run a minimal Qt Quick app on target hardware/emulator.
- **M5 — system services:** networking, Bluetooth, audio, power, device discovery and terminal PTY support.
- **M6 — security:** enforce users/groups, permissions, privilege broker, service isolation and auditable policy decisions.
- **M7 — packages and apps:** signed package manager, updater, file manager, settings and software center.
- **M8 — reliability:** bootable image, installer/recovery, automated integration tests and threat-model review.
