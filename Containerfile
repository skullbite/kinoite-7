# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY system_files /sys

#nvidia FROM ghcr.io/ublue-os/akmods-nvidia-open:main-45-7.2.13-300.fc45 AS akmods-nvidia-open

# Base Image
FROM ghcr.io/ublue-os/kinoite-main:beta

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
#
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### [IM]MUTABLE /opt
## Some bootable images, like Fedora, have /opt symlinked to /var/opt, in order to
## make it mutable/writable for users. However, some packages write files to this directory,
## thus its contents might be wiped out when bootc deploys an image, making it troublesome for
## some packages. Eg, google-chrome, docker-desktop.
##
## Uncomment the following line if one desires to make /opt immutable and be able to be used
## by the package manager.

# RUN rm /opt && mkdir /opt

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    #nvidia --mount=type=bind,from=akmods-nvidia-open,src=/rpms,dst=/tmp/rpms/nvidia \
    #nvidia --mount=type=bind,from=akmods-nvidia-open,src=/kernel-rpms,dst=/tmp/kernel-rpms \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

# RUN usermod -p "$(echo "debug" | mkpasswd -s)" root

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
