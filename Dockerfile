FROM golang:latest
ENV NAME cloud-torrent
WORKDIR /go/src/github.com/jpillora/cloud-torrent/
COPY . .
RUN  go build -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags)" -o /usr/local/bin/$NAME


FROM alpine:latest
ENV NAME cloud-torrent
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/jpillora/cloud-torrent/$NAME .
CMD ["./cloud-torrent"]
