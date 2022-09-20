FROM alpine:3.16

LABEL maintainer="Björn Busse <bj.rn@baerlin.eu>"
LABEL org.label-schema.description="mpv container"
LABEL org.label-schema.name="mpv"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.vcs-url="https://github.com/bbusse/mpv-container"

ENV ARCH="x86_64" \
    USER="mpv" \
    APK_ADD="ffmpeg mesa-demos mesa-dri-intel mpv pulseaudio ttf-dejavu" \
    APK_DEL=""

RUN apk add --no-cache ${APK_ADD} \
    && adduser -u 1000 -D ${USER} \
    && mkdir -p /home/${USER}/media \
    && mkdir -p /home/${USER}/.config/pulse \
    && echo "default-server = unix:/run/user/1000/pulse/native" > /home/mpv/.config/pulse/client.conf \
    && echo "autospawn = no" >> /home/mpv/.config/pulse/client.conf \
    && echo "daemon-binary = /bin/true" >> /home/mpv/.config/pulse/client.conf \
    && echo "enable-shm = false" >> /home/mpv/.config/pulse/client.conf \
    && mkdir -p /home/mpv/.config/mpv \
    && chown -R mpv:mpv /home/mpv \
    && rm -rf \
      /usr/share/man/* \
      /usr/includes/* \
      /var/cache/apk/* \
    && deluser --remove-home daemon \
    && deluser --remove-home adm \
    && deluser --remove-home lp \
    && deluser --remove-home sync \
    && deluser --remove-home shutdown \
    && deluser --remove-home halt \
    && deluser --remove-home postmaster \
    && deluser --remove-home cyrus \
    && deluser --remove-home mail \
    && deluser --remove-home news \
    && deluser --remove-home uucp \
    && deluser --remove-home operator \
    && deluser --remove-home man \
    && deluser --remove-home cron \
    && deluser --remove-home ftp \
    && deluser --remove-home sshd \
    && deluser --remove-home at \
    && deluser --remove-home squid \
    && deluser --remove-home xfs \
    && deluser --remove-home games \
    && deluser --remove-home vpopmail \
    && deluser --remove-home ntp \
    && deluser --remove-home smmsp \
    && deluser --remove-home guest

USER ${USER}
WORKDIR /home/${USER}/media

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
