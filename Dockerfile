FROM alpine:latest
WORKDIR /app

COPY build/proxy *.html ./

EXPOSE 3333-3339
CMD ["./proxy"]