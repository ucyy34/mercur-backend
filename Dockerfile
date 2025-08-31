# ---- Base image
FROM node:20-alpine

# ---- App dir
WORKDIR /app

# ---- Install deps
COPY package.json yarn.lock ./
RUN corepack enable && yarn install --frozen-lockfile

# ---- Copy source
COPY . .

# ---- Build
RUN yarn build || true

# ---- Runtime
ENV NODE_ENV=production
EXPOSE 9000
CMD ["sh", "-c", "PORT=${PORT:-9000} yarn start"]
