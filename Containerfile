FROM ghcr.io/ublue-os/kinoite-main:latest as kinoite

FROM ghcr.io/ublue-os/bazzite-deck:stable

RUN --mount=type=bind,from=kinoite,source=/,target=/kinoite \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    rsync -rlvK /kinoite/usr/ /usr && \
    rsync -rlvK /kinoite/etc/ /etc || true

RUN bootc container lint
