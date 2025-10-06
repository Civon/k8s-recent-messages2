# Minimal Dockerfile with efficient caching
FROM rust:1.88.0-alpine AS builder
WORKDIR /app
RUN apk add --no-cache musl-dev

# Cache dependencies
COPY Cargo.toml Cargo.lock ./
# Create dummy main to build dependencies
RUN mkdir -p src && \
    echo "fn main() {}" > src/main.rs && \
    cargo build --release && \
    rm -rf src

# Build actual code
COPY . .
RUN touch src/main.rs && cargo build --release

FROM alpine:3.20
WORKDIR /app
RUN apk add --no-cache ca-certificates tzdata && \
    adduser -D -u 10001 appuser && \
    mkdir -p /app/messages
COPY --from=builder /app/target/release/recent-messages2 .
COPY config.toml .
USER appuser
CMD ["./recent-messages2"]
