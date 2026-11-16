FROM scratch AS ctx
COPY build_files /
COPY system_files /sys


FROM ghcr.io/ublue-os/kinoite-main:latest

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    export GAMER=0 && \
    /ctx/build.sh

# RUN usermod -p "$(echo "debug" | mkpasswd -s)" root

RUN bootc container lint
