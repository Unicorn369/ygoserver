FROM node:lts-alpine AS builder
ARG SRVPRO_PATH
RUN mkdir -p /ygoserver
COPY ${SRVPRO_PATH}/package*.json /ygoserver/

WORKDIR /ygoserver
RUN apk add --no-cache python3 make g++
RUN npm install

###############
FROM node:lts-alpine
ARG TARGETARCH
ARG SRVPRO_PATH
ARG YGOPRO_PATH
ARG INIT_FILE_PATH

COPY ${SRVPRO_PATH} /ygoserver
COPY ${YGOPRO_PATH}/ygopro-${TARGETARCH} /ygoserver/ygopro/ygopro
COPY ${INIT_FILE_PATH} /init

WORKDIR /ygoserver

RUN chmod +x /ygoserver/ygopro/ygopro
RUN chmod +x /init

RUN apk add --no-cache jq
RUN npm install -g pm2

COPY --from=builder /ygoserver/node_modules ./node_modules

ENTRYPOINT [ "/init" ]
CMD [ "--default" ]
