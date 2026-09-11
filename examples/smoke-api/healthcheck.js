const http = require("http");

const request = http.get("http://127.0.0.1:8080/health", (response) => {
  process.exit(response.statusCode === 200 ? 0 : 1);
});

request.on("error", () => {
  process.exit(1);
});

request.setTimeout(2000, () => {
  request.destroy();
  process.exit(1);
});
