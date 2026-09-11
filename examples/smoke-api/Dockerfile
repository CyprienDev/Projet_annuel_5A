FROM node:26-alpine

# Mise à jour des paquets système et suppression des outils
# inutiles dans l'image d'exécution.
RUN apk upgrade --no-cache \
    && rm -rf \
      /usr/local/lib/node_modules/npm \
      /usr/local/lib/node_modules/corepack \
      /opt/yarn-v* \
    && rm -f \
      /usr/local/bin/npm \
      /usr/local/bin/npx \
      /usr/local/bin/corepack \
      /usr/local/bin/yarn \
      /usr/local/bin/yarnpkg

WORKDIR /app

COPY --chown=1000:1000 server.js healthcheck.js ./

ENV NODE_ENV=production \
    PORT=8080

EXPOSE 8080

USER 1000:1000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["node", "healthcheck.js"]

CMD ["node", "server.js"]
