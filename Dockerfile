FROM golang:1.25-alpine AS builder
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags='-s -w' -o /app/proxy .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/proxy ./proxy

EXPOSE 3333
CMD ["./proxy"]
