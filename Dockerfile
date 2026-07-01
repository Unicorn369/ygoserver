FROM node:lts-alpine3.20 AS builder
ARG SRVPRO_PATH
COPY ${SRVPRO_PATH} /srvpro 

WORKDIR /srvpro
RUN apk add --no-cache python3 make g++
RUN npm ci
RUN npm run build
RUN npm install --prefix /opt/local -g pm2
RUN mkdir -p app
COPY dist app/
COPY node_modules app/
COPY package*.json app/
COPY config.example.yaml app/config.yaml

###############
FROM node:lts-alpine3.20
ARG TARGETARCH
ARG SRVPRO_PATH
ARG YGOPRO_PATH
ARG INIT_FILE_PATH

RUN apk add --no-cache ca-certificates
COPY ${YGOPRO_PATH} /ygoserver 
COPY --from=builder /srvpro/app/* /ygoserver/*
COPY --from=builder /opt/local /usr/
COPY ${INIT_FILE_PATH} /run.sh

RUN chmod +x /ygoserver/ygopro/ygopro
RUN chmod +x /run.sh

WORKDIR /ygoserver

ENTRYPOINT [ "/run.sh" ]
#CMD [ "--version" ]
