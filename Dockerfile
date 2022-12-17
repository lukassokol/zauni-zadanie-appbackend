# Stage 1: Build
FROM golang:alpine as build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /build

# Stage 2
FROM alpine:latest

WORKDIR /

COPY --from=build /build /app

EXPOSE 8080

ENTRYPOINT [ "/app" ]