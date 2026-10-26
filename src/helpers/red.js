// Direcciones IPv4 de esta computadora dentro de la red local (Wi-Fi / cable).
// Sirven para abrir la tienda desde el celular: http://<ip>:<puerto>
const os = require("os");

function ipsLocales() {
  return Object.values(os.networkInterfaces())
    .flat()
    .filter((i) => i && i.family === "IPv4" && !i.internal)
    .map((i) => i.address)
    // Primero las de casa/oficina (192.168.x.x, 10.x.x.x, 172.16-31.x.x)
    .sort((a, b) => Number(esRedPrivada(b)) - Number(esRedPrivada(a)));
}

function esRedPrivada(ip) {
  return /^(10\.|192\.168\.|172\.(1[6-9]|2\d|3[01])\.)/.test(ip);
}

module.exports = { ipsLocales };
