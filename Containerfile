FROM ubuntu:26.04 AS source

ADD --checksum=sha256:f4ca6a58731fe8a4a645cdfd22b2e54abd6ffd877e4ec9aa8b7c65f6b71b521f https://github.com/laurent22/joplin/releases/download/v3.7.18/Joplin-3.7.18.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/joplin"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/joplin.png
COPY joplin.desktop /usr/share/applications/joplin.desktop
