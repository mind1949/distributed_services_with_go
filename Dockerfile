FROM golang:1.17-alpine AS build
WORKDIR /go/src/proglog
COPY . .
RUN export GO111MODULE=on
RUN export GOPROXY=https://goproxy.cn
RUN CGO_ENABLED=0 go build -o /go/bin/proglog ./cmd/proglog
RUN GRPC_HEALTH_PROBE_VERSION=v0.3.2 && \
    wget -q0/go/bin/grpc_health_probe \
    https://github.com/grpc-ecosystem/grpc-health-probe/release/download/\
    ${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /go/bin/grpc_health_probe

FROM scratch
COPY --from=build /go/bin/proglog /bin/proglog
COPY --from=build /go/bin/grpc_health_probe /bin/grpc_health_probe
ENTRYPOINT ["/bin/proglog"]
