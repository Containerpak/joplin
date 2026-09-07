FROM ubuntu:26.04 AS source

ADD --checksum=sha256:4c2f1853aa141ad7f5d8d78014b9534f73d6b229ec0dcbfaffcb7e40a54bc9ba https://github.com/laurent22/joplin/releases/download/v3.7.16/Joplin-3.7.16.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/joplin"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/joplin.png
COPY joplin.desktop /usr/share/applications/joplin.desktop
