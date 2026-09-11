FROM node:24-alpine

WORKDIR /app

COPY --chown=1000:1000 server.js healthcheck.js ./

ENV PORT=8080

EXPOSE 8080

USER 1000:1000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["node", "healthcheck.js"]

CMD ["node", "server.js"]
