const http = require("http");

const port = Number(process.env.PORT || 8080);

const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(
      JSON.stringify({
        status: "ok",
        service: "smoke-api"
      })
    );
    return;
  }

  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(
    JSON.stringify({
      message: "API de test du projet annuel"
    })
  );
});

server.listen(port, "0.0.0.0", () => {
  console.log(`API démarrée sur le port ${port}`);
});
