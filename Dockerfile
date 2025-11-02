###############
FROM alpine:edge
ARG TARGETARCH
ARG DATA_PATH
ARG SERVER_PATH

COPY ${DATA_PATH} /edoserver
COPY ${SERVER_PATH}/hornet-${TARGETARCH} /edoserver/hornet
COPY ${SERVER_PATH}/multirole-${TARGETARCH} /edoserver/multirole

WORKDIR /edoserver

RUN chmod +x /edoserver/hornet
RUN chmod +x /edoserver/multirole
RUN chmod +x /edoserver/init.sh

RUN apk add --no-cache jq

ENTRYPOINT [ "/edoserver/init.sh" ]
CMD [ "--default" ]
