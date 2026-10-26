// ==========================================================
// INICIO — Aparición al hacer scroll (usa base.js)
// ==========================================================

(() => {
  const { $, $$ } = window.Tienda;
  const sinMovimiento = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  // ---------- Pastillas de categoría (Elegidos de la semana) ----------
  const pastillas = $$("#pastillasInicio .pastilla");
  pastillas.forEach((pastilla) => {
    pastilla.addEventListener("click", () => {
      pastillas.forEach((p) => {
        p.classList.toggle("activa", p === pastilla);
        p.setAttribute("aria-selected", String(p === pastilla));
      });
      $$("#elegidosGrilla .tarjeta").forEach((t) => {
        t.hidden = Boolean(pastilla.dataset.categoria) && t.dataset.categoria !== pastilla.dataset.categoria;
      });
    });
  });

  const revelables = $$("[data-revelar]");
  if (!("IntersectionObserver" in window) || sinMovimiento) return;

  document.documentElement.classList.add("js-animar");

  // Los elementos hermanos aparecen escalonados
  revelables.forEach((el) => {
    const hermanos = [...el.parentElement.children].filter((h) => h.hasAttribute("data-revelar"));
    const i = hermanos.indexOf(el);
    if (i > 0) el.style.setProperty("--retraso", `${Math.min(i, 5) * 0.08}s`);
  });

  const observador = new IntersectionObserver(
    (entradas) => {
      entradas.forEach((e) => {
        if (!e.isIntersecting) return;
        e.target.classList.add("visible");
        observador.unobserve(e.target);
      });
    },
    { rootMargin: "0px 0px -8% 0px", threshold: 0.12 },
  );
  revelables.forEach((el) => observador.observe(el));
})();
