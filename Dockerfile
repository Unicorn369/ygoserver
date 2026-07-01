FROM node:lts-alpine3.20 AS builder
ARG SRVPRO_PATH
COPY ${SRVPRO_PATH} /srvpro

WORKDIR /srvpro
RUN apk add --no-cache python3 make g++
RUN npm ci
RUN npm run build
RUN npm install --prefix /opt/local -g pm2
RUN mkdir -p app
RUN cp -rf dist app/
RUN cp -rf node_modules app/
RUN cp -rf package*.json app/
RUN cp -rf config.example.yaml app/config.yaml

###############
FROM node:lts-alpine3.20
ARG SRVPRO_PATH
ARG YGOPRO_PATH
ARG INIT_FILE_PATH

RUN apk add --no-cache ca-certificates
COPY --from=builder /srvpro/app /ygoserver
COPY --from=builder /opt/local /usr/
COPY ${YGOPRO_PATH}/ygopro /ygoserver/ygopro
COPY ${YGOPRO_PATH}/libocgcore.wasm /ygoserver/libocgcore.wasm
COPY ${INIT_FILE_PATH} /run.sh

RUN chmod +x /run.sh

WORKDIR /ygoserver

ENTRYPOINT [ "/run.sh" ]
#CMD [ "--version" ]
