# Synpse image tools

Repository will contain helpers, tools and other misc to help users to build
and maintain their device images. This is intende to be only helpers repo.

Repository structure:

```
/hack/ - Scripts
/assets/ - All assets required to bootstrap
```

## Burn first Ubuntu RPI Synpse node

! These scipts been tested on Linux based system. For other platforms - contributions are welcome !

Copy `env.example` and update values based on what you want them be.

File should be named `env` and placed in the root project folder. It will be automatically sourced by `make` commands.

```
# Generate artifacts for image
`make generate`

# Download base ubuntu image
`make download-base`

# Prepare image for burning
`make generate-image`
```

Note: Once you start your device, bootstrapping happens in order:
1. Configure Wifi network
1. Configure Synpse agent bootstrap
1. Reboot
1. Bootstrap synpse
1. Install container runtime and unattended-upgrades
