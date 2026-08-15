FROM ubuntu:26.04 AS source

ADD --checksum=sha256:c9fc77c077f1c81c581324dfdd4cc785307ea3c5b5f19ceecf9ee20fa78ac792 https://github.com/laurent22/joplin/releases/download/v3.6.15/Joplin-3.6.15.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/joplin"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/joplin.png
COPY joplin.desktop /usr/share/applications/joplin.desktop
