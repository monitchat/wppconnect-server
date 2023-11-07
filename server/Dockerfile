# Estágio de construção (build)
FROM node:lts-alpine3.18 as base
WORKDIR /usr/src

ENV NODE_ENV=production \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    SECRET_KEY=$SECRET_KEY \
    WEBHOOK_URL=$WEBHOOK_URL \
    SERVER_PORT=$SERVER_PORT

# Instale as dependências necessárias
RUN apk add --no-cache git

# Clone o repositório do GitHub
RUN git clone https://github.com/wppconnect-team/wppconnect-server.git /usr/src/wpp-server
WORKDIR /usr/src/wpp-server

# Instale as dependências e limpe o cache
RUN yarn install --production --pure-lockfile && yarn cache clean

# Estágio de compilação (build)
FROM base as build
WORKDIR /usr/src/wpp-server
COPY config.ts /usr/src/wpp-server/src

RUN yarn install --production=false --pure-lockfile && yarn cache clean
RUN yarn build

# Estágio final
FROM base
WORKDIR /usr/src/wpp-server

# Instale o Chromium (se necessário)
RUN apk add --no-cache chromium

# Limpe o cache do Yarn
RUN yarn cache clean

# Copie o código compilado do estágio de construção
COPY --from=build /usr/src/wpp-server/ /usr/src/wpp-server/

# Exponha a porta necessária
EXPOSE $SERVER_PORT

# Comando de entrada
ENTRYPOINT ["node", "dist/server.js"]
