###############
FROM alpine:edge

ARG WINDBOT_PATH
COPY ${WINDBOT_PATH} /windbot

WORKDIR /windbot

#RUN apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/community mono
RUN apk add --no-cache mono

EXPOSE 2399
ENTRYPOINT [ "mono", "WindBot.exe" ]
CMD [ "ServerMode=true", "ServerPort=2399" ]
