FROM alpine:latest as download

RUN apk add --no-cache wget

WORKDIR /download

RUN wget https://abda.nl/lumen/hexrays.crt

FROM alpine:latest

RUN apk add --no-cache socat

COPY --from=download /download/hexrays.crt /etc/ssl/certs/hexrays.crt

CMD [ "socat", "-s", "-dd",  "tcp-listen:1234,fork,reuseaddr", "openssl:lumen.abda.nl:1235,cafile=/etc/ssl/certs/hexrays.crt"]