# Synpse Image builder agent

Repository structure:

```
/hack/ - Manual scripts
/assets/ - All assets required to bootstrap
```

## Burn first Ubuntu RPI Synpse node

Copy `env.example` and update values based on what you want them be.

File should be named `env` and placed in the root project folder. It will be automatically sourced by `make` commands.

```
# Generate artifacts for image
make generate

# Download base ubuntu image
make download-base

# Prepare image for burning
make generate-image
```

Note: Once you start your device, bootstrapping happens in order:
1. Configure Wifi network
1. Configure Synpse agent bootstrap
1. Reboot
1. Bootstrap synpse
1. Install container runtime and unattended-upgrades
