
FROM golang:1.22-alpine AS builder

WORKDIR /usr/src/app

COPY go.mod ./
COPY main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o fullcycle .
FROM scratch

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/fullcycle .

CMD ["./fullcycle"]