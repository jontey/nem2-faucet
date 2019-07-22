FROM node:10-alpine AS builder
WORKDIR /app
ENV NODE_ENV=production
RUN apk update && apk upgrade && apk add --no-cache \
  make \
  g++ \
  python
COPY package.json yarn.lock ./
RUN yarn
COPY . ./
RUN yarn build

FROM node:10-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY package.json ./
COPY nuxt.config.js ./
COPY --from=builder /app/server ./server/
COPY --from=builder /app/node_modules ./node_modules/
COPY --from=builder /app/.nuxt ./.nuxt/
COPY --from=builder /app/static ./static/
CMD ["yarn", "start"]
