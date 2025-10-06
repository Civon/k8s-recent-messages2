FROM rust:1.88.0-alpine AS builder
WORKDIR /app
RUN apk add --no-cache musl-dev

COPY Cargo.toml Cargo.lock ./
RUN cargo fetch

COPY . .
RUN cargo build --release

FROM alpine:3.20
WORKDIR /app
RUN apk add --no-cache ca-certificates tzdata && \
    adduser -D -u 10001 appuser && \
    mkdir -p /app/messages && \
    chown -R appuser:appuser /app/messages

COPY --from=builder --chown=appuser:appuser /app/target/release/recent-messages2 .
COPY --chown=appuser:appuser config.toml .

USER appuser
CMD ["./recent-messages2"]
