FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/skullbite/kinoite-7:latest as kinoite

FROM ghcr.io/ublue-os/bazzite-deck:stable

RUN --mount=type=bind,from=kinoite,source=/,target=/kinoite \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    rsync --exclude '/lib/modules/' -rlvK /kinoite/usr/ /usr && \
    rsync -rlvK /kinoite/etc/ /etc || true && \
    /ctx/build_plymouthvista.sh

RUN ls /lib/modules/

RUN bootc container lint
