const express = require("express");
const router = express.Router();

const catalogo = [
  { marca: "Toyota", nombre: "Hilux SRV 4x4", detalle: "Camioneta · 2022", estado: "Al día" },
  { marca: "Ford", nombre: "Ranger XLS", detalle: "Camioneta · 2021", estado: "Al día" },
  { marca: "Volkswagen", nombre: "Amarok V6", detalle: "Camioneta · 2023", estado: "Vence VTV" },
  { marca: "Renault", nombre: "Kangoo Express", detalle: "Utilitario · 2020", estado: "Al día" },
  { marca: "Fiat", nombre: "Fiorino Fire", detalle: "Utilitario · 2019", estado: "Vence seguro" },
  { marca: "Peugeot", nombre: "Partner Patagónica", detalle: "Utilitario · 2022", estado: "Al día" },
  { marca: "Mercedes-Benz", nombre: "Sprinter 415", detalle: "Furgón · 2021", estado: "Al día" },
  { marca: "Iveco", nombre: "Daily 55C", detalle: "Furgón · 2020", estado: "Vence VTV" },
];

router.get("/", (req, res) => {
  res.render("home", { titulo: "Vehículos", catalogo });
});

module.exports = router;
