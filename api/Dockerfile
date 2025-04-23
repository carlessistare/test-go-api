# Build stage
FROM golang:1.24.1 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./

# Compile for Linux amd64 (GKE expects this)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o hello-api .

# Final image (simplified)
FROM debian:bookworm-slim

COPY --from=builder /app/hello-api /hello-api

ENTRYPOINT ["/hello-api"]

