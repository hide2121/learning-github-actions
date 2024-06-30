FROM --platform=linux/amd64 golang:1.22.2 as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o learning-github-actions

FROM scratch
COPY --from=builder /app/learning-github-actions /app
ENTRYPOINT [ "/app" ]