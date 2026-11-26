# README de entrega · Guía 1 · Modelo conceptual · Producto 2

> Repositorio público: me identifico solo con mi usuario de GitHub. No hay datos personales de terceros.

## 1. Datos de la entrega

- **Producto:** P2 · modelo de análisis y verificación
- **Usuario de GitHub del autor:** `Kevin81A`
- **Caso de estudio:** SyP Web, tienda en línea y servicio técnico de *Fotocopiadoras SyP* (Neiva)
- **Trabajo en equipo del año:** sí, el proyecto *Fotocopiadora-SyP* (2 personas). El MER, las tablas y las páginas base son del equipo; **la lista de chequeo, el informe de análisis, el registro de ajustes y los modelos ajustados son individuales**.

## 2. Qué reutilicé

| Artefacto | Ruta original | ¿Solo o en equipo? |
|---|---|---|
| Modelo entidad-relación (tablas SQLite) | `Fotocopiadora-SyP/docs/Spain/er_diagram_syp.png` y `fastapi_backend/database.py` | En equipo |
| Narrativas de funciones (base de las plantillas) | `Fotocopiadora-SyP/docs/Spain/SRS_Fotocopiadoras_SyP.md` (RF-05, RF-09, RF-10) | En equipo |
| Pantallas del sitio (base del prototipo) | `Fotocopiadora-SyP/servicio-tecnico.html`, `admin.html`, `productos.html` | En equipo |
| Flujo de usuario | `Fotocopiadora-SyP/docs/Spain/user_manual_flowchart.png` | En equipo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | MER | Resolví la N:M guardada como texto (`items_json`) con las entidades asociativas DETALLE_PEDIDO y DETALLE_COTIZACION; agregué entidad débil (VARIANTE_PRODUCTO) y relación recursiva (CATEGORIA). Mejora C4. | [ebdce1a](https://github.com/Kevin81A/ADSO-3413974/commit/ebdce1a) |
| 2 | MER y dominio | Agregué CARRITO, ITEM_CARRITO e INFORMACION_EMPRESA y el atributo ficha técnica para que los RF de carrito, ficha técnica y páginas institucionales lleguen hasta entidad. Mejora C8. | [ebdce1a](https://github.com/Kevin81A/ADSO-3413974/commit/ebdce1a) |
| 3 | Dominio | Pasé de tablas con claves y tipos a **17 clases conceptuales** sin métodos ni FK, con generalización de Usuario y la clase de asociación LíneaPedido. Mejora C3. | [ebdce1a](https://github.com/Kevin81A/ADSO-3413974/commit/ebdce1a) |
| 4 | Prototipo | Redibujé 3 páginas reales como bocetos rotulados con su caso de uso y con los mensajes de los flujos alternos. Mejora C5. | [ebdce1a](https://github.com/Kevin81A/ADSO-3413974/commit/ebdce1a) |

## 4. Qué construí nuevo

- 2 diagramas de actividades (CU-06, CU-15) con calles, guardas, bifurcación y unión.
- 3 plantillas extendidas (CU-06, CU-15, CU-18) con alternos y excepciones coherentes con los diagramas.
- Lista de chequeo de 19 criterios aplicada en dos rondas, registro de 6 hallazgos corregidos, informe de análisis y matriz de trazabilidad (97,6 %).

## 5. Artefactos entregados

- [x] Diagramas de actividades (2): [01-diagramas-actividades.md](01-diagramas-actividades.md) · fuentes en [diagramas/](diagramas/)
- [x] Plantillas extendidas de casos de uso (3): [02-plantillas-extendidas.md](02-plantillas-extendidas.md)
- [x] Modelo de dominio: [03 §3.1](03-dominio-mer-prototipo.md) · [drawio](diagramas/modelo-dominio.drawio) · [svg](diagramas/modelo-dominio.svg)
- [x] Modelo entidad-relación: [03 §3.2](03-dominio-mer-prototipo.md) · [drawio](diagramas/modelo-entidad-relacion.drawio) · [svg](diagramas/modelo-entidad-relacion.svg)
- [x] Prototipo inicial (3 pantallas): [03 §3.3](03-dominio-mer-prototipo.md) · [prototipo/](prototipo/)
- [x] Lista de chequeo diligenciada (19 criterios): [04-lista-chequeo.md](04-lista-chequeo.md)
- [x] Registro de ajustes y segunda verificación: [05-registro-ajustes.md](05-registro-ajustes.md)
- [x] Informe de análisis (Anexo E): [06-informe-analisis.md](06-informe-analisis.md)
- [x] Matriz de trazabilidad (Anexo C): [07-matriz-trazabilidad.md](07-matriz-trazabilidad.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma: `Kevin81A` · 2026-11-26

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Claude (Anthropic) en Claude Code | Proponer la redacción de las plantillas, la lista de chequeo y el informe; generar los `.drawio`/`.svg` de actividades, dominio, MER y prototipo a partir de mis decisiones de modelado | Revisé que cada rama de los diagramas esté en la plantilla, que las multiplicidades y cardinalidades correspondan al negocio, y que cada hallazgo del registro sea real frente a los archivos base del equipo |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre el 21 de noviembre de 2026 y la entrega.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
