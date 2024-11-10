FROM golang:1.21-alpine AS caddy-builder
RUN apk add --no-cache git
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN xcaddy build \
    --with github.com/baldinof/caddy-supervisor \
    --with github.com/enum-gg/caddy-discord

# Install Bun app
FROM oven/bun:slim
WORKDIR /app
COPY --from=caddy-builder /go/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY index.ts .
CMD caddy run --config /etc/caddy/Caddyfile