// Arranca la tienda para probarla desde el celular en la misma red Wi-Fi:
//
//   npm run lan
//
// Hace lo mismo que `npm start`, y además:
//  · escucha en todas las interfaces (HOST=0.0.0.0)
//  · usa tu IP local en APP_URL (si el .env no tiene una dirección pública),
//    así Mercado Pago devuelve al comprador a una dirección que el celular alcanza.
require("dotenv").config();
const { ipsLocales } = require("../src/helpers/red");

process.env.HOST = process.env.HOST || "0.0.0.0";
const puerto = Number(process.env.PORT) || 3000;
const [ip] = ipsLocales();

const apuntaALocalhost = !process.env.APP_URL || /\/\/(localhost|127\.0\.0\.1)/.test(process.env.APP_URL);
if (ip && apuntaALocalhost) process.env.APP_URL = `http://${ip}:${puerto}`;

require("../src/app");
