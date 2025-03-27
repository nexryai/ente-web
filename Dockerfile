FROM ghcr.io/ente-io/web:latest as built

ENV ENTE_API_ORIGIN=https://ente-api.nexryai.me
ENV ENTE_ALBUMS_ORIGIN=https://localhost:3002

COPY <<EOF /docker-entrypoint.d/90-replace-ente-env.sh
find /out -name '*.js' |
    xargs sed -i'' "s#ENTE_API_ORIGIN_PLACEHOLDER#\$ENTE_API_ORIGIN#g"
find /out/photos -name '*.js' |
    xargs sed -i'' "s#ENTE_ALBUMS_ORIGIN_PLACEHOLDER#\$ENTE_ALBUMS_ORIGIN#g"
EOF

RUN chmod +x /docker-entrypoint.d/90-replace-ente-env.sh
RUN /docker-entrypoint.d/90-replace-ente-env.sh

FROM alpine
COPY --from=built /out/photos /dist

CMD ["cp", "-r", "/dist", "/mnt"]
