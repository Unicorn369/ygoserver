FROM node:lts-alpine AS builder
ARG SRVPRO_PATH
RUN mkdir -p /srvpro
COPY ${SRVPRO_PATH}/package*.json /srvpro/

WORKDIR /srvpro
RUN apk add --no-cache python3 make g++
RUN npm install

###############
FROM node:lts-alpine
ARG TARGETARCH
ARG SRVPRO_PATH
ARG YGOPRO_PATH

COPY ${SRVPRO_PATH} /srvpro
COPY ${YGOPRO_PATH}/ygopro-${TARGETARCH} /srvpro/ygopro/ygopro

WORKDIR /srvpro

RUN chmod +x /srvpro/ygopro/ygopro
RUN chmod +x /srvpro/windbot.sh

RUN npm install -g pm2

COPY --from=builder /srvpro/node_modules ./node_modules

CMD [ "pm2-docker", "start", "/srvpro/data/pm2-docker.json" ]
