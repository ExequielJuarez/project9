# Probar la tienda desde el celular (en tu red local)

La compu y el celular tienen que estar **en la misma red Wi-Fi**.

## Pasos

1. En la carpeta del proyecto, arrancá la tienda en modo red:

   ```bash
   npm run lan
   ```

2. En la consola vas a ver algo así:

   ```
   🚀 Servidor Express corriendo en el puerto 3000
      En esta computadora:  http://localhost:3000
      Desde el celular:     http://192.168.1.20:3000  (misma red Wi-Fi)
   ```

3. Abrí en el navegador del celular la dirección de **"Desde el celular"**.

`npm start` hace lo mismo pero sin tocar `APP_URL`; `npm run lan` además
usa tu IP local en `APP_URL`, para que el retorno de Mercado Pago llegue
a una dirección que el celular alcanza.

## Si no abre

- **Firewall.** En Windows aparece un aviso al arrancar Node: marcá *Redes privadas*
  y permití el acceso. Si lo cerraste: Seguridad de Windows → Firewall →
  *Permitir una aplicación* → Node.js, en redes privadas. En macOS: Ajustes →
  Red → Firewall → permitir conexiones entrantes a Node.
- **Red de invitados / aislamiento.** Algunos routers y redes públicas bloquean
  la comunicación entre dispositivos ("aislamiento de clientes"). Probá con la
  red principal de tu casa.
- **VPN activa** en la compu: apagala mientras probás.
- **Más de una IP** en la consola: probá cada una (suele servir la que empieza con 192.168 o 10.).
- **Otro puerto.** Si el 3000 está ocupado, poné `PORT=3001` en el `.env`.

## Qué funciona y qué no en local

| Función | Desde el celular en la red local |
| --- | --- |
| Catálogo, carrito, favoritos, cuenta, pedidos | ✅ |
| Panel admin (`/admin`) | ✅ |
| Pagos en **modo demo** (sin `MP_ACCESS_TOKEN`) | ✅ |
| Mercado Pago con credenciales de prueba | ✅ el pago funciona; el aviso automático (webhook) **no** llega, porque necesita una dirección pública con https |
| Entrar con Google | ❌ Google solo acepta `localhost` o una dirección https pública como redirección |

## Si necesitás https o una dirección pública

Para probar el webhook de Mercado Pago o el login con Google desde el celular,
exponé tu servidor con un túnel (por ejemplo `cloudflared tunnel --url http://localhost:3000`
o `ngrok http 3000`), y poné la dirección https que te dé en `APP_URL` (y
`GOOGLE_CALLBACK_URL` + la lista de redirecciones autorizadas de Google).
