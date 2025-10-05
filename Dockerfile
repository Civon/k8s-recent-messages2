# Chef stage to prepare dependency recipe
FROM rust:1.88.0-bookworm AS chef
WORKDIR /app
RUN cargo install cargo-chef
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# Builder stage to cook dependencies and build the project
FROM rust:1.88.0-bookworm AS builder
WORKDIR /app
RUN cargo install cargo-chef
# Copy recipe and cook dependencies
COPY --from=chef /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json

# Copy source and build the application
COPY src ./src
COPY migrations_main ./migrations_main
COPY migrations_shard ./migrations_shard
RUN cargo build --release

# Final stage - Alpine 3.20 (latest stable, better ARM64 QEMU support)
FROM alpine:3.20

WORKDIR /app

# Install runtime dependencies, create app user, and set permissions
RUN apk add --no-cache \
        libgcc \
        ca-certificates \
        tzdata && \
    adduser -D -u 10001 appuser && \
    mkdir /app/messages && \
    chown -R appuser:appuser /app

# Copy binary and config
COPY --from=builder /app/target/release/recent-messages2 .
COPY --chown=appuser:appuser config.toml .

# Switch to the new user
USER appuser

CMD ["./recent-messages2"]
