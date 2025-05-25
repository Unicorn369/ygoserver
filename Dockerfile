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

COPY ${SRVPRO_PATH} /ygoserver
COPY ${YGOPRO_PATH}/ygopro-${TARGETARCH} /ygoserver/ygopro/ygopro

WORKDIR /ygoserver

RUN chmod +x /ygoserver/ygopro/ygopro
RUN chmod +x /ygoserver/windbot.sh

RUN npm install -g pm2

COPY --from=builder /ygoserver/node_modules ./node_modules

CMD [ "pm2-docker", "start", "/ygoserver/data/pm2-docker.json" ]
