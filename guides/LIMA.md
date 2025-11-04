# Lima VM Management

Essential `limactl` commands for managing Linux VMs on macOS.

## Quick Start

```bash
# Create VM (VZ backend - faster, ARM-native)
limactl create --name vm-name --vm-type vz template://default

# Create VM (QEMU backend - flexible, cross-arch)
limactl create --name vm-name --vm-type qemu template://default

# Start VM
limactl start vm-name

# Shell into VM
limactl shell vm-name

# Exit with: exit

# Remove images caches
rm -rf ~/Library/Caches/lima/
```

## Available Templates

```bash
# List all templates
ll $(dirname $(dirname $(readlink -f $(which limactl))))/share/lima/templates/
```

Common templates: `default`, `ubuntu`, `debian`, `alpine`, `fedora`, `archlinux`, `docker`, `podman`, `k3s`

Use: `template://name` (e.g., `template://ubuntu` or `template://docker`)

## Lightweight C Development VM

Alpine is minimal (~130MB) and ideal for C compilation:

```bash
# Create with VZ (faster)
limactl create --name c-vz --vm-type vz template://alpine
limactl start c-vz

# Create with QEMU (for comparison)
limactl create --name c-qemu --vm-type qemu template://alpine
limactl start c-qemu

# Install C build tools inside VM
limactl shell c-vz
apk add build-base
```

## Management Commands

| Command                   | Action               |
|---------------------------|----------------------|
| `limactl list`            | List all VMs         |
| `limactl stop vm-name`    | Stop VM              |
| `limactl restart vm-name` | Restart VM           |
| `limactl delete vm-name`  | Delete VM            |
| `limactl info vm-name`    | View VM info         |

## Backend Comparison

**VZ (Virtualization.framework)**
- ARM-on-ARM, near-native speed
- Apple's hypervisor

**QEMU (HVF)**
- Can emulate x86 or run ARM
- Cross-architecture support

## x86 Emulation on ARM

```bash
limactl create --name vm-x86 --vm-type qemu
limactl edit vm-x86  # Set: arch: x86_64
limactl start vm-x86
```
