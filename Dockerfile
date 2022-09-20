FROM alpine:3.16

LABEL maintainer="Björn Busse <bj.rn@baerlin.eu>"
LABEL org.label-schema.description="mpv container"
LABEL org.label-schema.name="mpv"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.vcs-url="https://github.com/bbusse/mpv-container"

RUN apk add --no-cache \
    ffmpeg \
    mesa-demos \
    mesa-dri-intel \
    mpv \
    pulseaudio \
    ttf-dejavu \
  && adduser -u 1000 -D mpv \
  && mkdir -p /home/mpv/media \
  && mkdir -p /home/mpv/.config/pulse \
  && echo "default-server = unix:/run/user/1000/pulse/native" > /home/mpv/.config/pulse/client.conf \
  && echo "autospawn = no" >> /home/mpv/.config/pulse/client.conf \
  && echo "daemon-binary = /bin/true" >> /home/mpv/.config/pulse/client.conf \
  && echo "enable-shm = false" >> /home/mpv/.config/pulse/client.conf \
  && mkdir -p /home/mpv/.config/mpv \
  && chown -R mpv:mpv /home/mpv

USER mpv
WORKDIR /home/mpv/media

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
