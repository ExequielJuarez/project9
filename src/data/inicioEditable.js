// ==========================================================
// Qué se puede editar del inicio desde el panel (Admin → Inicio)
// y el valor original de cada cosa.
//
// Este esquema arma solo el formulario del panel, limpia lo que
// se guarda y completa lo que falta. Para sumar un campo nuevo
// alcanza con agregarlo acá y usarlo en views/inicio.ejs.
//
// Tipos: texto (una línea) · lineas (varios renglones) · parrafo
//        numero · link · imagen · opciones · lista (fija o variable)
// En los textos, *palabra* se muestra en cursiva.
// ==========================================================

const IMG = (nombre) => `/img/inicio/${nombre}`;

const FONDOS = { claro: "Claro", medio: "Gris", oscuro: "Oscuro" };

const texto = (etiqueta, defecto, max = 80, extra = {}) => ({ tipo: "texto", etiqueta, defecto, max, ...extra });
const parrafo = (etiqueta, defecto, max = 300, extra = {}) => ({ tipo: "parrafo", etiqueta, defecto, max, ...extra });
const link = (etiqueta, defecto, extra = {}) => ({ tipo: "link", etiqueta, defecto, max: 255, ancho: "medio", ...extra });
const imagen = (etiqueta, defecto, extra = {}) => ({ tipo: "imagen", etiqueta, defecto, ...extra });
const etiquetaSeccion = (defecto) => texto("Texto chico de arriba", defecto, 40);
const tituloSeccion = (defecto) =>
  texto("Título", defecto, 70, { ayuda: "Poné *entre asteriscos* la parte que va en cursiva." });

const SECCIONES = {
  portada: {
    titulo: "Portada",
    descripcion: "Lo primero que se ve al entrar: título, botones y la foto grande.",
    siempreVisible: true,
    campos: {
      etiqueta: texto("Texto chico de arriba (opcional)", "Colección actual", 70),
      titulo: {
        tipo: "lineas",
        etiqueta: "Título grande",
        defecto: "Vestite a tu\nmanera.",
        max: 90,
        maxLineas: 4,
        ayuda: "Un renglón por línea.",
      },
      bajada: parrafo(
        "Texto debajo del título",
        "Básicos con carácter. Elegancia relajada para todos los días.",
        260
      ),
      botonTexto: texto("Botón principal", "Ver colección", 30, { ancho: "medio" }),
      botonLink: link("Link del botón principal", "/catalogo"),
      imagen: imagen("Foto principal", IMG("portada.jpg"), {
        ayuda: "Foto vertical (como la del polo). Se muestra a la derecha del título.",
      }),
    },
  },

  cinta: {
    titulo: "Cinta de texto",
    descripcion: "La franja de letras grandes que se desplaza entre los productos y el banner.",
    campos: {
      palabras: {
        tipo: "lineas",
        etiqueta: "Frases",
        defecto: "Huella Negra\nBásicos con carácter\nEnvíos a todo el país\nCambios fáciles",
        max: 200,
        maxLineas: 8,
        ayuda: "Una por renglón.",
      },
    },
  },

  banner: {
    titulo: "Banner de colección",
    descripcion: "El bloque con foto a la izquierda y texto a la derecha, debajo de los productos.",
    campos: {
      etiqueta: etiquetaSeccion("Nueva colección"),
      titulo: {
        tipo: "lineas",
        etiqueta: "Título",
        defecto: "Menos ruido.\nMás estilo.",
        max: 60,
        maxLineas: 3,
      },
      botonTexto: texto("Texto del botón", "Descubrir Huella Negra", 30, { ancho: "medio" }),
      botonLink: link("A dónde lleva", "/catalogo"),
      imagen: imagen("Foto", IMG("banner.jpg"), { ayuda: "Mejor una foto horizontal." }),
    },
  },
};

module.exports = { SECCIONES, FONDOS };
