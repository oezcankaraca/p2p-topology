# Verwenden Sie das Alpine-Image als Basis
FROM alpine:latest

# Aktualisieren Sie die Paketlisten und installieren Sie die benötigten Tools
RUN apk update && \
    apk add iproute2 iperf3 tcpdump netcat-openbsd iputils

# Setzen Sie einen Arbeitsverzeichnis (optional)
WORKDIR /workspace

# Standardbefehl, der ausgeführt wird, wenn der Container gestartet wird
CMD ["/bin/sh"]

