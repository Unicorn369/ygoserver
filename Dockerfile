FROM node:lts-alpine3.20 AS builder
ARG SRVPRO_PATH
COPY ${SRVPRO_PATH} /ygoserver 

WORKDIR /ygoserver
RUN apk add --no-cache python3 make g++
RUN npm install
RUN npm install --prefix /opt/local -g pm2

###############
FROM node:lts-alpine3.20
ARG TARGETARCH
ARG SRVPRO_PATH
ARG YGOPRO_PATH
ARG INIT_FILE_PATH

RUN apk add --no-cache jq patch

COPY --from=builder /ygoserver /ygoserver
COPY --from=builder /opt/local /usr/
COPY ${YGOPRO_PATH}/ygopro-${TARGETARCH} /ygoserver/ygopro/ygopro
COPY ${INIT_FILE_PATH} /run.sh

RUN chmod +x /ygoserver/ygopro/ygopro
RUN chmod +x /run.sh

WORKDIR /ygoserver

ENTRYPOINT [ "/run.sh" ]
#CMD [ "--ygo-windbot=1" ]
