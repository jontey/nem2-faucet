FROM node:8-alpine
WORKDIR /app
RUN apk update && apk add yarn python g++ make && rm -rf /var/cache/apk/*
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
CMD [ "yarn", "start" ]