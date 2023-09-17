FROM alpine:latest
RUN apk update && \
    apk add iproute2 iperf3 tcpdump netcat-openbsd iputils
WORKDIR /workspace
CMD ["/bin/sh"]
