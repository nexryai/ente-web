FROM ghcr.io/ente-io/web:latest as built

FROM alpine
COPY --from=built /out/photos /dist

CMD ["cp", "-r", "/dist", "/mnt"]
