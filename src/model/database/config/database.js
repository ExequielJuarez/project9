require("dotenv").config();

const base = {
  username: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || null,
  database: process.env.DB_NAME || "vehiculos_db",
  host: process.env.DB_HOST || "127.0.0.1",
  port: Number(process.env.DB_PORT) || 3306,
  dialect: "mysql",
};

module.exports = { development: base, test: base, production: base };
