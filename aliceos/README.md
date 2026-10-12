# aliceOS

aliceOS is a KDE Plasma-inspired desktop environment and userspace distribution layer intended to run on the `nos` kernel. The initial milestone provides a Qt 6 / QML / Qt Quick / Kirigami desktop shell prototype and defines the contracts needed to connect real OS services.

## Current milestone

- Responsive desktop shell with application launcher, bottom panel, task cards, status area, quick settings and terminal-style window.
- Kirigami application structure and Qt Quick Controls.
- Service-adapter boundary for future integration with the `nos` userspace ABI.
- Architecture notes for users, permissions, service supervision, networking and package management.

## Build the desktop prototype

Requirements: Qt 6, Qt Quick, Qt Quick Controls 2, Kirigami 6, and CMake 3.21+.

```sh
cmake -S aliceos -B aliceos/build
cmake --build aliceos/build
```

Run `aliceos/build/aliceos` from a graphical Qt 6 environment.

## Important status

This is a desktop-shell prototype, not yet a bootable OS distribution. The current `nos` kernel repository is a low-level kernel project; a full Qt desktop requires a userspace ABI/runtime, process and filesystem interfaces, a graphics backend, input stack, IPC, and service managers. Features shown in the UI are prototype interactions until a corresponding system service is implemented and connected. Security controls must be enforced by the kernel and privileged service boundaries, never by the QML UI alone.

See [ARCHITECTURE.md](ARCHITECTURE.md) for the staged implementation plan.
