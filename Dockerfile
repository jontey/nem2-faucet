<<<<<<< HEAD
FROM node:8-alpine
WORKDIR /app
RUN apk update && apk add yarn python g++ make && rm -rf /var/cache/apk/*
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
CMD [ "yarn", "start" ]
=======
FROM node:8-alpine AS builder
RUN apk update && apk upgrade && apk add --no-cache \
  make \
  g++ \
  python
WORKDIR /app
COPY . .
RUN npm install --prod && npm run build

FROM node:8-alpine AS runner
WORKDIR /app
COPY --from=builder /app /app
CMD ["npm", "start"]
>>>>>>> 22afc5089a20a08745b840b1498c795d11337c7e
