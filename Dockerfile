FROM golang:alpine AS build
WORKDIR /go/src/github.com/utilitywarehouse/mongolizer
COPY . /go/src/github.com/utilitywarehouse/mongolizer
ENV CGO_ENABLED 0
ENV GO111MODULE on
RUN apk --no-cache add git &&\
 go build -o /mongolizer .

FROM alpine:3.12
COPY --from=build /mongolizer /mongolizer
EXPOSE 8080
ENTRYPOINT ["/mongolizer"]
CMD ["scheduled-backup"]
