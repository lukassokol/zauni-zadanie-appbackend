# Stage 1: Build
FROM --platform=linux/amd64 golang:alpine as build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /build

# Stage 2
FROM --platform=linux/amd64 alpine:latest

WORKDIR /

COPY --from=build /build /app

EXPOSE 9080

ENTRYPOINT [ "/app" ]