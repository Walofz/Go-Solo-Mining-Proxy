# Builder Stage
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY main.go .
RUN go mod init soloproxy && \
    go get github.com/go-zeromq/zmq4 && \
    go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -o soloproxy main.go

# Run Stage
FROM alpine:latest
WORKDIR /root/
RUN apk --no-cache add tzdata
COPY --from=builder /app/soloproxy .
EXPOSE 3333 8080
CMD ["./soloproxy"]
