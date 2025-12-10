FROM golang:1.25-alpine AS builder
WORKDIR /build
COPY . .
RUN go mod download
RUN go build -o ./gophers-api internal/main.go

FROM registry.redhat.io/ubi9/ubi-micro:latest AS final
COPY --from=builder /build/gophers-api .
EXPOSE 8080
CMD ["./gophers-api"]
