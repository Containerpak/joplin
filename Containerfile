FROM ubuntu:26.04 AS source

ADD --checksum=sha256:1b7f42d2ee978b1adf5cd95b8880b48769f42e3135076632392192022e300e7d https://github.com/laurent22/joplin/releases/download/v3.6.16/Joplin-3.6.16.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/joplin"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/joplin.png
COPY joplin.desktop /usr/share/applications/joplin.desktop
