-- ==========================================================
-- TIENDA — Datos de prueba
--
-- Cargar DESPUÉS de schema.sql (borra y vuelve a cargar todo).
-- Las fechas de los pedidos son relativas al momento de la carga
-- (CURDATE() - INTERVAL n DAY / NOW() - INTERVAL n MINUTE), así el
-- panel siempre muestra ventas recientes sin importar cuándo se cargue.
--
-- Usuarios de prueba:
--   Cliente  demo@tienda.com   /  Demo1234
--   Admin    admin@tienda.com  /  Admin1234
--
-- Uso:  npm run db:instalar   (carga schema.sql + este archivo)
--   o:  mysql -u root -p tienda_db < database/datos-prueba.sql
-- ==========================================================

USE tienda_db;

-- Acentos bien guardados aunque el cliente de MySQL no esté en UTF-8
SET NAMES utf8mb4;
-- Misma zona horaria que usa la app (DB_TIMEZONE en el .env), para que
-- CURDATE() y las fechas de los pedidos coincidan con el panel
SET time_zone = '-03:00';

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE notificaciones;
TRUNCATE TABLE pedido_items;
TRUNCATE TABLE pedidos;
TRUNCATE TABLE favoritos;
TRUNCATE TABLE especificaciones;
TRUNCATE TABLE producto_imagenes;
TRUNCATE TABLE productos;
TRUNCATE TABLE colores;
TRUNCATE TABLE categorias;
TRUNCATE TABLE cupones;
TRUNCATE TABLE usuarios;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE pedidos AUTO_INCREMENT = 1001;

-- ── Usuarios ─────────────────────────────────────────────
INSERT INTO usuarios (id, nombre, apellido, email, telefono, password, google_id, rol, newsletter) VALUES
  (1, 'Cliente', 'Demo', 'demo@tienda.com', '11 5555 4444', '$2b$10$jX3V6AhKp.Par41X/kOWfelfguSzaU4z/IZkvYOv0UHGBQ/6Rl2Oy', NULL, 'cliente', 1),
  (2, 'Admin', 'Tienda', 'admin@tienda.com', NULL, '$2b$10$OUwf1N16MEgHBa5jhFt6K.cGjo4yUyiF/cOwUOBsyttSBQqgwMRYq', NULL, 'admin', 0),
  (3, 'Ana', 'Pérez', 'ana.perez@gmail.com', NULL, NULL, 'demo-ana.perez@gmail.com', 'cliente', 0);

-- ── Categorías y colores ────────────────────────────────
INSERT INTO categorias (id, nombre, orden) VALUES
  (1, 'Remeras', 1),
  (2, 'Polos', 2),
  (3, 'Camperas', 3),
  (4, 'Buzos', 4);

INSERT INTO colores (id, valor, nombre, hex, orden) VALUES
  (1, 'negro', 'Negro', '#111111', 1),
  (2, 'blanco', 'Blanco', '#ffffff', 2),
  (3, 'verde-agua', 'Verde agua', '#b8c9b9', 3),
  (4, 'marron', 'Marrón', '#5a392b', 4),
  (5, 'verde', 'Verde', '#1d5a3c', 5),
  (6, 'crudo', 'Crudo', '#e4dfd3', 6);

-- ── Productos ───────────────────────────────────────────
INSERT INTO productos (id, nombre, categoria_id, color_id, precio, costo, stock, etiqueta, resumen, descripcion, destacados) VALUES
  (1, 'Polo Essential', 2, 1, 34900, 17000, 24, 'Nuevo', 'Polo manga larga con cuello clásico y bordado en el pecho. Un básico con carácter.', 'Un polo pensado para usar todos los días: caída relajada, cuello firme y un bordado discreto en el pecho.

Combina con jean, cargo o sastrero. Se lava a máquina sin perder la forma.', 'Algodón peinado de primera calidad
Bordado en el pecho
Caída relajada
Cambios fáciles'),
  (2, 'Campera Gabardina Negra', 3, 1, 59900, 31000, 12, 'Exclusivo', 'Campera camisera de gabardina con botones metálicos y bolsillos de pecho.', 'Una campera liviana que funciona como abrigo y como camisa. Gabardina con cuerpo, botones metálicos y bolsillos frontales.

Para usar abierta sobre una remera blanca o cerrada en días frescos.', 'Gabardina de algodón
Botones metálicos
Bolsillos de pecho
Cambios fáciles'),
  (3, 'Remera Boxy Verde Agua', 1, 3, 27900, 13500, 30, 'Nuevo', 'Remera boxy de algodón grueso con estampa en la espalda.', 'Corte boxy, hombro caído y algodón con cuerpo. La estampa en la espalda es lo que la hace distinta.

Queda bien suelta con un cargo o ajustada con un pantalón recto.', 'Algodón grueso 220 g
Estampa en la espalda
Corte boxy
Cambios fáciles'),
  (4, 'Remera Boxy Marrón', 1, 4, 24900, 12000, 28, 'Más vendido', 'Remera oversize color chocolate con bordado frontal.', 'Un marrón profundo que va con todo. Algodón suave, cuello reforzado y bordado al frente.

La más pedida de la temporada.', 'Algodón suave
Bordado frontal
Cuello reforzado
Cambios fáciles'),
  (5, 'Remera Oversize Gráfica', 1, 1, 26900, 13000, 15, NULL, 'Remera negra oversize con gran estampa metalizada en la espalda.', 'Negra, oversize y con una estampa metalizada grande en la espalda. Al frente, solo un detalle chico.

Para quienes prefieren que el diseño se vea al darse vuelta.', 'Algodón grueso
Estampa metalizada
Corte oversize
Cambios fáciles'),
  (6, 'Buzo Canguro Verde', 4, 5, 44900, 22500, 3, 'Últimas unidades', 'Buzo canguro de friza con paneles en contraste y capucha.', 'Friza suave por dentro, paneles en contraste y capucha con cordón. Un buzo que se nota.

Quedan pocas unidades.', 'Friza suave
Paneles en contraste
Capucha con cordón
Cambios fáciles');

-- ── Fotos de cada producto (la de menor orden es la principal) ──
INSERT INTO producto_imagenes (producto_id, ruta, orden) VALUES
  (1, '/img/productos/polo-negro.jpg', 0),
  (2, '/img/productos/campera-negra.jpg', 0),
  (2, '/img/productos/campera-negra-2.jpg', 1),
  (3, '/img/productos/remera-verde-agua.jpg', 0),
  (3, '/img/productos/remera-verde-agua-2.jpg', 1),
  (4, '/img/productos/remera-marron.jpg', 0),
  (4, '/img/productos/remera-marron-2.jpg', 1),
  (5, '/img/productos/remera-negra.jpg', 0),
  (5, '/img/productos/remera-negra-2.jpg', 1),
  (6, '/img/productos/buzo-verde.jpg', 0);

-- ── Ficha técnica de cada producto ──────────────────────
INSERT INTO especificaciones (producto_id, clave, valor, orden) VALUES
  (1, 'Material', 'Algodón peinado', 1),
  (1, 'Calce', 'Regular', 2),
  (1, 'Cuidado', 'Lavar del revés, agua fría', 3),
  (1, 'Talles', 'S a XXL', 4),
  (1, 'Origen', 'Hecho en Argentina', 5),
  (2, 'Material', 'Gabardina de algodón', 1),
  (2, 'Calce', 'Regular', 2),
  (2, 'Cuidado', 'Lavar del revés, agua fría', 3),
  (2, 'Talles', 'S a XXL', 4),
  (2, 'Origen', 'Hecho en Argentina', 5),
  (3, 'Material', 'Algodón 100%', 1),
  (3, 'Calce', 'Boxy', 2),
  (3, 'Cuidado', 'Lavar del revés, agua fría', 3),
  (3, 'Talles', 'S a XL', 4),
  (3, 'Origen', 'Hecho en Argentina', 5),
  (4, 'Material', 'Algodón 100%', 1),
  (4, 'Calce', 'Oversize', 2),
  (4, 'Cuidado', 'Lavar del revés, agua fría', 3),
  (4, 'Talles', 'S a XL', 4),
  (4, 'Origen', 'Hecho en Argentina', 5),
  (5, 'Material', 'Algodón 100%', 1),
  (5, 'Calce', 'Oversize', 2),
  (5, 'Cuidado', 'Lavar del revés, agua fría', 3),
  (5, 'Talles', 'S a XL', 4),
  (5, 'Origen', 'Hecho en Argentina', 5),
  (6, 'Material', 'Friza de algodón', 1),
  (6, 'Calce', 'Regular', 2),
  (6, 'Cuidado', 'Lavar del revés, agua fría', 3),
  (6, 'Talles', 'M a XXL', 4),
  (6, 'Origen', 'Hecho en Argentina', 5);

-- ── Cupones ─────────────────────────────────────────────
INSERT INTO cupones (codigo, descripcion, porcentaje, activo, vence_en) VALUES
  ('BIENVENIDA', '10% off en tu primera compra', 0.1000, 1, NULL),
  ('MAQUETA5', '5% off de prueba', 0.0500, 1, NULL),
  ('VERANO20', '20% off de temporada (vencido)', 0.2000, 1, CURDATE() - INTERVAL 10 DAY);

-- ── Favoritos del cliente demo ──────────────────────────
INSERT INTO favoritos (usuario_id, producto_id) VALUES
  (1, 2),
  (1, 4),
  (1, 6);

-- ── Pedidos de los últimos 30 días (80) ─────────────────
INSERT INTO pedidos (id, usuario_id, cliente, email, telefono, entrega, calle, altura, piso, codigo_postal, ciudad, provincia, medio_pago, estado, subtotal, descuento, envio, total, costo, ganancia, creado_en) VALUES
  (1001, 1, 'Cliente Demo', 'demo@tienda.com', '11 45260181', 'domicilio', 'Av. Siempre Viva', '1876', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'transferencia', 'entregado', 26900, 2690, 6500, 30710, 13000, 11210, TIMESTAMP(CURDATE() - INTERVAL 29 DAY, '10:05:00')),
  (1002, NULL, 'Valentina López', 'valentina.lopez@mail.com', '11 41318609', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 59900, 5990, 0, 53910, 31000, 22910, TIMESTAMP(CURDATE() - INTERVAL 29 DAY, '16:03:00')),
  (1003, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 40824628', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 26900, 2690, 0, 24210, 13000, 11210, TIMESTAMP(CURDATE() - INTERVAL 29 DAY, '12:06:00')),
  (1004, NULL, 'Juan Pérez', 'juan.perez@mail.com', '11 49351819', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 26900, 0, 0, 26900, 13000, 13900, TIMESTAMP(CURDATE() - INTERVAL 28 DAY, '18:27:00')),
  (1005, 1, 'Cliente Demo', 'demo@tienda.com', '11 45797543', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 44900, 0, 0, 44900, 22500, 22400, TIMESTAMP(CURDATE() - INTERVAL 28 DAY, '14:33:00')),
  (1006, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '11 45749118', 'domicilio', 'Av. Siempre Viva', '3231', NULL, '2000', 'Rosario', 'Santa Fe', 'tarjeta', 'entregado', 115700, 0, 6500, 122200, 58000, 57700, TIMESTAMP(CURDATE() - INTERVAL 28 DAY, '20:04:00')),
  (1007, NULL, 'Martín Gómez', 'martin.gomez@mail.com', '11 49555979', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 124700, 12470, 0, 112230, 62000, 50230, TIMESTAMP(CURDATE() - INTERVAL 27 DAY, '11:03:00')),
  (1008, 1, 'Cliente Demo', 'demo@tienda.com', '11 44974650', 'domicilio', 'Av. Siempre Viva', '3124', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 147700, 0, 6500, 154200, 75500, 72200, TIMESTAMP(CURDATE() - INTERVAL 27 DAY, '14:08:00')),
  (1009, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 46671276', 'domicilio', 'Av. Siempre Viva', '3721', NULL, '5500', 'Mendoza', 'Mendoza', 'transferencia', 'entregado', 115700, 11570, 6500, 110630, 58000, 46130, TIMESTAMP(CURDATE() - INTERVAL 26 DAY, '15:43:00')),
  (1010, NULL, 'Valentina López', 'valentina.lopez@mail.com', '11 43212233', 'domicilio', 'Av. Siempre Viva', '1816', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 24900, 0, 6500, 31400, 12000, 12900, TIMESTAMP(CURDATE() - INTERVAL 26 DAY, '10:09:00')),
  (1011, NULL, 'Martín Gómez', 'martin.gomez@mail.com', '11 45995289', 'domicilio', 'Av. Siempre Viva', '1740', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 209400, 0, 0, 209400, 103000, 106400, TIMESTAMP(CURDATE() - INTERVAL 26 DAY, '17:40:00')),
  (1012, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '11 43137215', 'domicilio', 'Av. Siempre Viva', '204', NULL, '1900', 'La Plata', 'Buenos Aires', 'transferencia', 'entregado', 79800, 7980, 6500, 78320, 39500, 32320, TIMESTAMP(CURDATE() - INTERVAL 25 DAY, '15:39:00')),
  (1013, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '11 43962459', 'domicilio', 'Av. Siempre Viva', '2081', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'entregado', 24900, 0, 6500, 31400, 12000, 12900, TIMESTAMP(CURDATE() - INTERVAL 25 DAY, '17:30:00')),
  (1014, NULL, 'Nicolás Álvarez', 'nicolas.alvarez@mail.com', '11 41215472', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 94800, 9480, 0, 85320, 48000, 37320, TIMESTAMP(CURDATE() - INTERVAL 24 DAY, '10:48:00')),
  (1015, 1, 'Cliente Demo', 'demo@tienda.com', '11 48414852', 'domicilio', 'Av. Siempre Viva', '3329', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'transferencia', 'entregado', 59900, 5990, 6500, 60410, 31000, 22910, TIMESTAMP(CURDATE() - INTERVAL 24 DAY, '19:51:00')),
  (1016, 1, 'Cliente Demo', 'demo@tienda.com', '11 43363387', 'domicilio', 'Av. Siempre Viva', '893', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 44900, 0, 6500, 51400, 22500, 22400, TIMESTAMP(CURDATE() - INTERVAL 24 DAY, '17:16:00')),
  (1017, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '11 49575513', 'domicilio', 'Av. Siempre Viva', '2656', NULL, '2000', 'Rosario', 'Santa Fe', 'tarjeta', 'entregado', 119800, 0, 6500, 126300, 62000, 57800, TIMESTAMP(CURDATE() - INTERVAL 23 DAY, '13:30:00')),
  (1018, NULL, 'Juan Pérez', 'juan.perez@mail.com', '11 40751163', 'domicilio', 'Av. Siempre Viva', '3144', NULL, '2000', 'Rosario', 'Santa Fe', 'transferencia', 'entregado', 84800, 8480, 6500, 82820, 43000, 33320, TIMESTAMP(CURDATE() - INTERVAL 23 DAY, '17:25:00')),
  (1019, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '11 42220297', 'domicilio', 'Av. Siempre Viva', '520', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'entregado', 111700, 0, 6500, 118200, 56000, 55700, TIMESTAMP(CURDATE() - INTERVAL 22 DAY, '21:41:00')),
  (1020, NULL, 'Martín Gómez', 'martin.gomez@mail.com', '11 42633043', 'domicilio', 'Av. Siempre Viva', '1816', NULL, '5500', 'Mendoza', 'Mendoza', 'transferencia', 'entregado', 26900, 2690, 6500, 30710, 13000, 11210, TIMESTAMP(CURDATE() - INTERVAL 22 DAY, '14:34:00')),
  (1021, NULL, 'Agustina Torres', 'agustina.torres@mail.com', '11 40579868', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 26900, 2690, 0, 24210, 13000, 11210, TIMESTAMP(CURDATE() - INTERVAL 22 DAY, '10:55:00')),
  (1022, 1, 'Cliente Demo', 'demo@tienda.com', '11 47290222', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 61800, 6180, 0, 55620, 30000, 25620, TIMESTAMP(CURDATE() - INTERVAL 21 DAY, '18:35:00')),
  (1023, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '11 41803340', 'domicilio', 'Av. Siempre Viva', '1433', NULL, '2000', 'Rosario', 'Santa Fe', 'transferencia', 'entregado', 53800, 5380, 6500, 54920, 26000, 22420, TIMESTAMP(CURDATE() - INTERVAL 21 DAY, '11:28:00')),
  (1024, NULL, 'Juan Pérez', 'juan.perez@mail.com', '11 48983478', 'domicilio', 'Av. Siempre Viva', '1806', NULL, '2000', 'Rosario', 'Santa Fe', 'transferencia', 'entregado', 51800, 5180, 6500, 53120, 25000, 21620, TIMESTAMP(CURDATE() - INTERVAL 20 DAY, '17:08:00')),
  (1025, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '11 46751361', 'domicilio', 'Av. Siempre Viva', '2804', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'entregado', 44900, 0, 6500, 51400, 22500, 22400, TIMESTAMP(CURDATE() - INTERVAL 20 DAY, '21:41:00')),
  (1026, NULL, 'Sofía Rodríguez', 'sofia.rodriguez@mail.com', '11 42427316', 'domicilio', 'Av. Siempre Viva', '901', NULL, '5500', 'Mendoza', 'Mendoza', 'transferencia', 'entregado', 149700, 14970, 6500, 141230, 76000, 58730, TIMESTAMP(CURDATE() - INTERVAL 20 DAY, '15:26:00')),
  (1027, NULL, 'Sofía Rodríguez', 'sofia.rodriguez@mail.com', '11 45150587', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 124700, 12470, 0, 112230, 62000, 50230, TIMESTAMP(CURDATE() - INTERVAL 19 DAY, '14:32:00')),
  (1028, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '11 41311440', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 27900, 0, 0, 27900, 13500, 14400, TIMESTAMP(CURDATE() - INTERVAL 19 DAY, '14:25:00')),
  (1029, 1, 'Cliente Demo', 'demo@tienda.com', '11 42889751', 'domicilio', 'Av. Siempre Viva', '2698', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 34900, 0, 6500, 41400, 17000, 17900, TIMESTAMP(CURDATE() - INTERVAL 19 DAY, '14:01:00')),
  (1030, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '11 44193141', 'domicilio', 'Av. Siempre Viva', '3006', NULL, '5000', 'Córdoba', 'Córdoba', 'transferencia', 'entregado', 97700, 9770, 6500, 94430, 47500, 40430, TIMESTAMP(CURDATE() - INTERVAL 18 DAY, '10:33:00')),
  (1031, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 41240234', 'domicilio', 'Av. Siempre Viva', '251', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 141600, 0, 6500, 148100, 70500, 71100, TIMESTAMP(CURDATE() - INTERVAL 18 DAY, '10:16:00')),
  (1032, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '11 40883873', 'domicilio', 'Av. Siempre Viva', '1040', NULL, '1900', 'La Plata', 'Buenos Aires', 'transferencia', 'entregado', 119600, 11960, 6500, 114140, 58000, 49640, TIMESTAMP(CURDATE() - INTERVAL 17 DAY, '21:13:00')),
  (1033, NULL, 'Sofía Rodríguez', 'sofia.rodriguez@mail.com', '11 43265020', 'domicilio', 'Av. Siempre Viva', '2824', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 44900, 0, 6500, 51400, 22500, 22400, TIMESTAMP(CURDATE() - INTERVAL 17 DAY, '10:05:00')),
  (1034, NULL, 'Valentina López', 'valentina.lopez@mail.com', '11 48493407', 'domicilio', 'Av. Siempre Viva', '1447', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 59900, 0, 6500, 66400, 31000, 28900, TIMESTAMP(CURDATE() - INTERVAL 17 DAY, '14:23:00')),
  (1035, NULL, 'Martín Gómez', 'martin.gomez@mail.com', '11 45304352', 'domicilio', 'Av. Siempre Viva', '2787', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 55800, 0, 6500, 62300, 27000, 28800, TIMESTAMP(CURDATE() - INTERVAL 16 DAY, '14:32:00')),
  (1036, 1, 'Cliente Demo', 'demo@tienda.com', '11 43380141', 'domicilio', 'Av. Siempre Viva', '2679', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 24900, 0, 6500, 31400, 12000, 12900, TIMESTAMP(CURDATE() - INTERVAL 16 DAY, '14:19:00')),
  (1037, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 41982965', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 140600, 14060, 0, 126540, 70000, 56540, TIMESTAMP(CURDATE() - INTERVAL 15 DAY, '18:08:00')),
  (1038, NULL, 'Martín Gómez', 'martin.gomez@mail.com', '11 48909310', 'domicilio', 'Av. Siempre Viva', '307', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 59900, 0, 6500, 66400, 31000, 28900, TIMESTAMP(CURDATE() - INTERVAL 15 DAY, '17:35:00')),
  (1039, NULL, 'Lucía Fernández', 'lucia.fernandez@mail.com', '11 40837407', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 44900, 4490, 0, 40410, 22500, 17910, TIMESTAMP(CURDATE() - INTERVAL 15 DAY, '11:47:00')),
  (1040, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '11 47414333', 'domicilio', 'Av. Siempre Viva', '2691', NULL, '2000', 'Rosario', 'Santa Fe', 'transferencia', 'entregado', 168500, 16850, 0, 151650, 83000, 68650, TIMESTAMP(CURDATE() - INTERVAL 14 DAY, '10:39:00')),
  (1041, NULL, 'Lucía Fernández', 'lucia.fernandez@mail.com', '11 43192544', 'domicilio', 'Av. Siempre Viva', '507', NULL, '2000', 'Rosario', 'Santa Fe', 'tarjeta', 'entregado', 146700, 0, 6500, 153200, 75000, 71700, TIMESTAMP(CURDATE() - INTERVAL 14 DAY, '14:43:00')),
  (1042, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '11 43748477', 'domicilio', 'Av. Siempre Viva', '1979', NULL, '2000', 'Rosario', 'Santa Fe', 'tarjeta', 'entregado', 61800, 0, 6500, 68300, 30000, 31800, TIMESTAMP(CURDATE() - INTERVAL 13 DAY, '10:18:00')),
  (1043, 1, 'Cliente Demo', 'demo@tienda.com', '11 41874633', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 26900, 0, 0, 26900, 13000, 13900, TIMESTAMP(CURDATE() - INTERVAL 13 DAY, '18:16:00')),
  (1044, NULL, 'Sofía Rodríguez', 'sofia.rodriguez@mail.com', '11 42984153', 'domicilio', 'Av. Siempre Viva', '1760', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 69800, 0, 6500, 76300, 34500, 35300, TIMESTAMP(CURDATE() - INTERVAL 13 DAY, '20:28:00')),
  (1045, NULL, 'Nicolás Álvarez', 'nicolas.alvarez@mail.com', '11 42656515', 'domicilio', 'Av. Siempre Viva', '148', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 27900, 0, 6500, 34400, 13500, 14400, TIMESTAMP(CURDATE() - INTERVAL 12 DAY, '13:45:00')),
  (1046, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '11 44451669', 'domicilio', 'Av. Siempre Viva', '311', NULL, '2000', 'Rosario', 'Santa Fe', 'tarjeta', 'entregado', 55800, 0, 6500, 62300, 27000, 28800, TIMESTAMP(CURDATE() - INTERVAL 12 DAY, '14:06:00')),
  (1047, NULL, 'Lucía Fernández', 'lucia.fernandez@mail.com', '11 44234685', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 55800, 0, 0, 55800, 27000, 28800, TIMESTAMP(CURDATE() - INTERVAL 11 DAY, '16:58:00')),
  (1048, NULL, 'Martín Gómez', 'martin.gomez@mail.com', '11 48310679', 'domicilio', 'Av. Siempre Viva', '799', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 44900, 0, 6500, 51400, 22500, 22400, TIMESTAMP(CURDATE() - INTERVAL 11 DAY, '18:08:00')),
  (1049, NULL, 'Camila Martínez', 'camila.martinez@mail.com', '11 46544446', 'domicilio', 'Av. Siempre Viva', '2150', NULL, '2000', 'Rosario', 'Santa Fe', 'transferencia', 'entregado', 172600, 17260, 0, 155340, 87500, 67840, TIMESTAMP(CURDATE() - INTERVAL 11 DAY, '11:13:00')),
  (1050, 1, 'Cliente Demo', 'demo@tienda.com', '11 47837576', 'domicilio', 'Av. Siempre Viva', '2376', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 26900, 0, 6500, 33400, 13000, 13900, TIMESTAMP(CURDATE() - INTERVAL 10 DAY, '12:21:00')),
  (1051, NULL, 'Facundo Ruiz', 'facundo.ruiz@mail.com', '11 45354930', 'domicilio', 'Av. Siempre Viva', '2452', NULL, '5000', 'Córdoba', 'Córdoba', 'tarjeta', 'entregado', 141600, 0, 6500, 148100, 70000, 71600, TIMESTAMP(CURDATE() - INTERVAL 10 DAY, '17:17:00')),
  (1052, NULL, 'Sofía Rodríguez', 'sofia.rodriguez@mail.com', '11 42883143', 'domicilio', 'Av. Siempre Viva', '3006', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 94700, 0, 6500, 101200, 46500, 48200, TIMESTAMP(CURDATE() - INTERVAL 10 DAY, '10:27:00')),
  (1053, 1, 'Cliente Demo', 'demo@tienda.com', '11 47970168', 'domicilio', 'Av. Siempre Viva', '546', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 84800, 0, 6500, 91300, 43000, 41800, TIMESTAMP(CURDATE() - INTERVAL 9 DAY, '18:43:00')),
  (1054, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '11 47180023', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'entregado', 62800, 6280, 0, 56520, 30500, 26020, TIMESTAMP(CURDATE() - INTERVAL 9 DAY, '16:44:00')),
  (1055, 1, 'Cliente Demo', 'demo@tienda.com', '11 41114893', 'domicilio', 'Av. Siempre Viva', '1395', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'transferencia', 'entregado', 87800, 8780, 6500, 85520, 44500, 34520, TIMESTAMP(CURDATE() - INTERVAL 8 DAY, '17:17:00')),
  (1056, NULL, 'Lucía Fernández', 'lucia.fernandez@mail.com', '11 43783830', 'domicilio', 'Av. Siempre Viva', '1820', NULL, '2000', 'Rosario', 'Santa Fe', 'tarjeta', 'entregado', 72800, 0, 6500, 79300, 36000, 36800, TIMESTAMP(CURDATE() - INTERVAL 8 DAY, '20:41:00')),
  (1057, 1, 'Cliente Demo', 'demo@tienda.com', '11 41436537', 'domicilio', 'Av. Siempre Viva', '1723', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'transferencia', 'entregado', 44900, 4490, 6500, 46910, 22500, 17910, TIMESTAMP(CURDATE() - INTERVAL 8 DAY, '15:43:00')),
  (1058, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 40481373', 'domicilio', 'Av. Siempre Viva', '3742', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 59900, 0, 6500, 66400, 31000, 28900, TIMESTAMP(CURDATE() - INTERVAL 7 DAY, '14:48:00')),
  (1059, NULL, 'Nicolás Álvarez', 'nicolas.alvarez@mail.com', '11 41979237', 'domicilio', 'Av. Siempre Viva', '681', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'entregado', 114700, 0, 6500, 121200, 56500, 58200, TIMESTAMP(CURDATE() - INTERVAL 7 DAY, '10:38:00')),
  (1060, NULL, 'Valentina López', 'valentina.lopez@mail.com', '11 40026751', 'domicilio', 'Av. Siempre Viva', '2015', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'pagado', 59900, 0, 6500, 66400, 31000, 28900, TIMESTAMP(CURDATE() - INTERVAL 6 DAY, '18:47:00')),
  (1061, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '11 44655721', 'domicilio', 'Av. Siempre Viva', '3208', NULL, '1900', 'La Plata', 'Buenos Aires', 'tarjeta', 'entregado', 34900, 0, 6500, 41400, 17000, 17900, TIMESTAMP(CURDATE() - INTERVAL 6 DAY, '11:35:00')),
  (1062, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 46546107', 'domicilio', 'Av. Siempre Viva', '2043', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 55800, 0, 6500, 62300, 27000, 28800, TIMESTAMP(CURDATE() - INTERVAL 6 DAY, '21:57:00')),
  (1063, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '11 46360607', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'enviado', 34900, 0, 0, 34900, 17000, 17900, TIMESTAMP(CURDATE() - INTERVAL 5 DAY, '19:21:00')),
  (1064, 1, 'Cliente Demo', 'demo@tienda.com', '11 45459045', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'transferencia', 'pagado', 27900, 2790, 0, 25110, 13500, 11610, TIMESTAMP(CURDATE() - INTERVAL 5 DAY, '11:01:00')),
  (1065, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 41776467', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 24900, 0, 0, 24900, 12000, 12900, TIMESTAMP(CURDATE() - INTERVAL 4 DAY, '21:49:00')),
  (1066, NULL, 'Agustina Torres', 'agustina.torres@mail.com', '11 49355759', 'domicilio', 'Av. Siempre Viva', '2760', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'enviado', 26900, 0, 6500, 33400, 13000, 13900, TIMESTAMP(CURDATE() - INTERVAL 4 DAY, '16:04:00')),
  (1067, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '11 47885261', 'domicilio', 'Av. Siempre Viva', '1930', NULL, '1900', 'La Plata', 'Buenos Aires', 'tarjeta', 'entregado', 27900, 0, 6500, 34400, 13500, 14400, TIMESTAMP(CURDATE() - INTERVAL 4 DAY, '17:45:00')),
  (1068, NULL, 'Agustina Torres', 'agustina.torres@mail.com', '11 43267938', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'entregado', 89700, 0, 0, 89700, 43500, 46200, TIMESTAMP(CURDATE() - INTERVAL 3 DAY, '13:28:00')),
  (1069, NULL, 'Mateo Sánchez', 'mateo.sanchez@mail.com', '11 42332493', 'domicilio', 'Av. Siempre Viva', '2760', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'pagado', 69800, 0, 6500, 76300, 34000, 35800, TIMESTAMP(CURDATE() - INTERVAL 3 DAY, '18:14:00')),
  (1070, 1, 'Cliente Demo', 'demo@tienda.com', '11 41701073', 'domicilio', 'Av. Siempre Viva', '2488', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'tarjeta', 'enviado', 62800, 0, 6500, 69300, 30500, 32300, TIMESTAMP(CURDATE() - INTERVAL 2 DAY, '19:52:00')),
  (1071, 1, 'Cliente Demo', 'demo@tienda.com', '11 43158279', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'pagado', 44900, 0, 0, 44900, 22500, 22400, TIMESTAMP(CURDATE() - INTERVAL 2 DAY, '21:39:00')),
  (1072, NULL, 'Sofía Rodríguez', 'sofia.rodriguez@mail.com', '11 43055203', 'domicilio', 'Av. Siempre Viva', '858', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 34900, 0, 6500, 41400, 17000, 17900, TIMESTAMP(CURDATE() - INTERVAL 2 DAY, '20:23:00')),
  (1073, NULL, 'Juan Pérez', 'juan.perez@mail.com', '11 44130787', 'retiro', NULL, NULL, NULL, NULL, NULL, NULL, 'tarjeta', 'pagado', 24900, 0, 0, 24900, 12000, 12900, TIMESTAMP(CURDATE() - INTERVAL 1 DAY, '12:40:00')),
  (1074, NULL, 'Martín Gómez', 'martin.gomez@mail.com', '11 41264644', 'domicilio', 'Av. Siempre Viva', '1700', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'entregado', 90700, 0, 6500, 97200, 44000, 46700, TIMESTAMP(CURDATE() - INTERVAL 1 DAY, '20:12:00')),
  (1075, NULL, 'Tomás Díaz', 'tomas.diaz@mail.com', '11 46306261', 'domicilio', 'Av. Siempre Viva', '632', NULL, '2000', 'Rosario', 'Santa Fe', 'tarjeta', 'pagado', 24900, 0, 6500, 31400, 12000, 12900, NOW() - INTERVAL 410 MINUTE),
  (1076, NULL, 'Florencia Castro', 'florencia.castro@mail.com', '11 40826199', 'domicilio', 'Av. Siempre Viva', '1260', NULL, '1900', 'La Plata', 'Buenos Aires', 'tarjeta', 'pagado', 44900, 0, 6500, 51400, 22500, 22400, NOW() - INTERVAL 330 MINUTE),
  (1077, NULL, 'Agustina Torres', 'agustina.torres@mail.com', '11 48211673', 'domicilio', 'Av. Siempre Viva', '318', NULL, '5500', 'Mendoza', 'Mendoza', 'tarjeta', 'pagado', 59900, 0, 6500, 66400, 31000, 28900, NOW() - INTERVAL 253 MINUTE),
  (1078, 1, 'Cliente Demo', 'demo@tienda.com', '11 49619239', 'domicilio', 'Av. Siempre Viva', '270', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'transferencia', 'pendiente', 113700, 11370, 6500, 108830, 57000, 45330, NOW() - INTERVAL 184 MINUTE),
  (1079, NULL, 'Valentina López', 'valentina.lopez@mail.com', '11 48265123', 'domicilio', 'Av. Siempre Viva', '2353', NULL, '1405', 'CABA', 'Ciudad Autónoma de Buenos Aires', 'transferencia', 'pendiente', 148600, 14860, 6500, 140240, 74000, 59740, NOW() - INTERVAL 145 MINUTE),
  (1080, NULL, 'Lucía Fernández', 'lucia.fernandez@mail.com', '11 44649366', 'domicilio', 'Av. Siempre Viva', '2005', NULL, '2000', 'Rosario', 'Santa Fe', 'transferencia', 'pendiente', 79700, 7970, 6500, 78230, 38500, 33230, NOW() - INTERVAL 109 MINUTE);

-- Cobro: los pedidos pagados/enviados/entregados tienen el pago aprobado
UPDATE pedidos SET pago_estado = 'aprobado', pagado_en = creado_en
WHERE estado IN ('pagado', 'enviado', 'entregado');
UPDATE pedidos
SET pago_detalle = ELT(1 + MOD(id, 4), 'Visa terminada en 4242 · 3 cuotas', 'Mastercard terminada en 5100 · 1 cuota',
                       'Naranja terminada en 6019 · 6 cuotas', 'Dinero en cuenta de Mercado Pago'),
    pago_id = CONCAT('demo-', id)
WHERE medio_pago = 'tarjeta' AND pago_estado = 'aprobado';
UPDATE pedidos SET pago_detalle = 'Transferencia acreditada'
WHERE medio_pago = 'transferencia' AND pago_estado = 'aprobado';

-- Dirección guardada del cliente demo (se usa para completar el checkout)
UPDATE usuarios SET dni = '30111222', calle = 'Av. Siempre Viva', altura = '2837', codigo_postal = '1405',
       ciudad = 'CABA', provincia = 'Ciudad Autónoma de Buenos Aires'
WHERE email = 'demo@tienda.com';

UPDATE pedidos SET actualizado_en = creado_en;

-- ── Renglones de los pedidos (125) ─────────────────────────
INSERT INTO pedido_items (pedido_id, producto_id, nombre, color, precio, costo, cantidad) VALUES
  (1001, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1002, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1003, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1004, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1005, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1006, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1006, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1007, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1007, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 2),
  (1008, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1008, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 2),
  (1009, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1009, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1010, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1011, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 2),
  (1011, 1, 'Polo Essential', 'Negro', 34900, 17000, 2),
  (1011, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 2),
  (1012, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1012, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1013, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1014, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1014, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1015, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1016, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1017, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 2),
  (1018, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1018, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1019, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1019, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1019, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1020, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1021, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1022, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1022, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1023, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 2),
  (1024, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1024, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1025, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1026, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1026, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 2),
  (1027, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 2),
  (1027, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1028, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1029, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1030, 1, 'Polo Essential', 'Negro', 34900, 17000, 2),
  (1030, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1031, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1031, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 2),
  (1031, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1032, 1, 'Polo Essential', 'Negro', 34900, 17000, 2),
  (1032, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 2),
  (1033, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1034, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1035, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1036, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1037, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1037, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1037, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1038, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1039, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1040, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 2),
  (1040, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1040, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 2),
  (1041, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1041, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 2),
  (1042, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1042, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1043, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1044, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1044, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1045, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1046, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1047, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1048, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1049, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 2),
  (1049, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1049, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1050, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1051, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1051, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 2),
  (1051, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1052, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 2),
  (1052, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1053, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1053, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1054, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1054, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1055, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1055, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1056, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1056, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1057, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1058, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1059, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1059, 1, 'Polo Essential', 'Negro', 34900, 17000, 2),
  (1060, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1061, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1062, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1063, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1064, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1065, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1066, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1067, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1068, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1068, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1068, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1),
  (1069, 1, 'Polo Essential', 'Negro', 34900, 17000, 2),
  (1070, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1070, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1071, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1072, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1073, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1074, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1074, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 2),
  (1075, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1076, 6, 'Buzo Canguro Verde', 'Verde', 44900, 22500, 1),
  (1077, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1078, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 2),
  (1078, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1079, 2, 'Campera Gabardina Negra', 'Negro', 59900, 31000, 1),
  (1079, 1, 'Polo Essential', 'Negro', 34900, 17000, 1),
  (1079, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 2),
  (1080, 3, 'Remera Boxy Verde Agua', 'Verde agua', 27900, 13500, 1),
  (1080, 4, 'Remera Boxy Marrón', 'Marrón', 24900, 12000, 1),
  (1080, 5, 'Remera Oversize Gráfica', 'Negro', 26900, 13000, 1);

ALTER TABLE pedidos AUTO_INCREMENT = 1081;

-- ── Notificaciones para el admin (las 2 compras más recientes, sin leer) ──
INSERT INTO notificaciones (tipo, titulo, mensaje, url, pedido_id, leida, creado_en)
SELECT 'pedido',
       CONCAT('Nueva compra #', id),
       CONCAT(cliente, ' · $', FORMAT(total, 2, 'es_AR')),
       CONCAT('/admin/pedidos?q=', id),
       id, 0, creado_en
  FROM pedidos
 ORDER BY creado_en DESC
 LIMIT 2;
