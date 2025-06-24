###############
FROM alpine:edge
ARG TARGETARCH
ARG DATA_PATH
ARG SERVER_PATH

COPY ${DATA_PATH} /ygoserver
COPY ${SERVER_PATH}/hornet-${TARGETARCH} /ygoserver/hornet
COPY ${SERVER_PATH}/multirole-${TARGETARCH} /ygoserver/multirole

WORKDIR /ygoserver

RUN chmod +x /ygoserver/hornet
RUN chmod +x /ygoserver/multirole
RUN chmod +x /ygoserver/init.sh

RUN apk add --no-cache jq

ENTRYPOINT [ "/ygoserver/init.sh" ]
CMD [ "--default" ]
