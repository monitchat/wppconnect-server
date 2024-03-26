FROM node:lts-alpine3.18 as base
WORKDIR /usr/src/wpp-server
ENV NODE_ENV=production \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    SECRET_KEY=$SECRET_KEY \
    WEBHOOK_URL=$WEBHOOK_URL \
    SERVER_PORT=$SERVER_PORT \
    POWERED_BY=$POWERED_BY

COPY package.json ./
RUN yarn install --production --pure-lockfile && \
    yarn add sharp --ignore-engines && \
    yarn cache clean

FROM base as build
WORKDIR /usr/src/wpp-server
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
COPY package.json  ./
RUN yarn install --production=false --pure-lockfile && \
    yarn cache clean
COPY . .
RUN yarn build


FROM base
WORKDIR /usr/src/wpp-server/
RUN apk add --no-cache chromium
RUN yarn cache clean
COPY . .
COPY --from=build /usr/src/wpp-server/ /usr/src/wpp-server/
EXPOSE 21465
CMD ["node", "--max-old-space-size=4096" ,"dist/server.js"]
