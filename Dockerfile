FROM alpine:edge as socks_proxy
RUN apk add --no-cache --update git build-base
RUN git clone https://github.com/Fuwn/socks_proxy.git && \
    cd socks_proxy && \
    make && \
    mv proxy /usr/local/bin/socks_proxy

FROM alpine:edge

EXPOSE 8080

RUN apk --update add openvpn runit

COPY --from=socks_proxy /usr/local/bin/socks_proxy /usr/local/bin/

COPY app /app

RUN find /app -name run | xargs chmod u+x

ENV OPENVPN_FILENAME=uk-london-aes128.ovpn \
    LOCAL_NETWORK=192.168.1.0/24 \
    ONLINECHECK_DELAY=900

CMD ["runsvdir", "/app"]
