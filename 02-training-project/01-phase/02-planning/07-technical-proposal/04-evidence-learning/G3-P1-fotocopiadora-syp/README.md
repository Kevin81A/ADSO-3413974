# G3 · Propuesta técnica · README de entrega · Producto 1

> Repositorio público: me identifico con mi usuario de GitHub. Datos ficticios o de dominio público.

## 1. Identificación

| Campo | Valor |
|---|---|
| Producto | P1 Especificaciones técnicas |
| Usuario de GitHub del autor | `Kevin81A` |
| Ficha | 3413974 |
| Variante del escenario asignada (A, B, C o D) | **A (asumida; pendiente de confirmar con el instructor)** |
| Caso de estudio (nombre del proyecto de mi fork) | SyP Web · Fotocopiadoras SyP (Neiva) |
| Fecha de la última actualización | 2026-11-26 |
| Plazo de entrega | A más tardar el sábado 5 de diciembre de 2026 a las 6:00 a. m. |

## 2. Qué reutilicé de mi trabajo del año

| Artefacto de este producto | Archivo de origen (ruta) | Cómo lo reutilicé |
|---|---|---|
| Fichas técnicas | SRS y RNF (`01-analysis/.../G1-P1-fotocopiadora-syp/00-insumo-requisitos-srs.md`); `03-execute/13-week/02-optional-activity/NORMATIVA DEL PROYECTO.docx` | Convertí los RNF en características medibles con valor, unidad y verificación |
| Condiciones técnicas | RNF-03, RNF-04, RNF-11 del SRS; despliegue de la G2 (`06-architecture/.../G2-P1-fotocopiadora-syp/A4-A5-A6-arquitectura-y-vistas.md`) | Calculé capacidad, almacenamiento, ancho de banda, RPO y RTO con la variante |
| Licencias | `Fotocopiadora-SyP/fastapi_backend/requirements.txt` (equipo) | Inventario de 8 dependencias con su licencia |
| Esfuerzo y costos | Lista de casos de uso de la G1 (23 casos) y módulos del SRS | 12 ítems de esfuerzo por módulo con tres puntos |

## 3. Qué ajusté o construí desde cero

| Artefacto | Qué cambié o construí | Por qué |
|---|---|---|
| A1 Formato de ficha | Construido desde cero: 14 campos basados en ISO/IEC 25010 | C1: formato con valor, unidad, verificación y normas |
| A2 Fichas | 4 fichas (2 software, 2 hardware/infraestructura) con 6 o 7 características medibles cada una, sin marcas | C2 |
| A3 Referentes | 4 obligatorios + Ley 1480 de 2011, con enlace y fecha; reglas internas separadas | C3: no se había trabajado normatividad legal en el año |
| A4 Licencias | 8 componentes con fórmula de cantidad; decisión de licencia propietaria con cesión | C4 |
| A5 Condiciones técnicas | 8 parámetros con fórmula | C5 |
| A6 Hoja de costos | Hoja con fórmulas vivas a 12 y 36 meses, rango ±25 %, supuestos y exclusiones | C6 |

## 4. Enlaces a los entregables

- [x] A1. Formato de ficha técnica: [A1-A2-fichas-tecnicas.md §A1](A1-A2-fichas-tecnicas.md)
- [x] A2. Fichas técnicas diligenciadas (4): [A1-A2-fichas-tecnicas.md §A2](A1-A2-fichas-tecnicas.md)
- [x] A3. Referente técnico (4 obligatorios + 1 opcional, con fecha y enlace): [A3-referentes-tecnicos.md](A3-referentes-tecnicos.md)
- [x] A4. Dimensionamiento de licencias e inventario de dependencias: [A4-licencias.md](A4-licencias.md)
- [x] A5. Estimación de condiciones técnicas (8 parámetros): [A5-condiciones-tecnicas.md](A5-condiciones-tecnicas.md)
- [x] A6. Estimación preliminar de condiciones económicas (hoja con fórmulas): [A6-estimacion-economica.xlsx](A6-estimacion-economica.xlsx)

## 5. Autoevaluación de mínimos

| Mínimo | Mi conteo |
|---|---|
| Fichas diligenciadas / características medibles por ficha | 4 / 6 a 7 |
| Referentes técnicos / incluyen Ley 1581, Ley 23, Decisión 351 y un estándar | 5 / sí |
| Componentes de licencias / dependencias inventariadas | 8 / 8 |
| Mis hojas de cálculo usan fórmulas | sí |

Resultado de la hoja A6 (variante A): talento humano 405,9 h ≈ $14,2 M; total estimado a 12 meses ≈ $20,7 M y a 36 meses ≈ $30,9 M sin IVA; el límite superior (+25 %) ≈ $25,9 M cabe en el tope de $45 M.

## 6. Historial de trabajo

| Fecha | Qué hice ese día | Commits |
|---|---|---|
| 2026-11-26 | Fichas, referentes, licencias, condiciones técnicas y hoja de costos | (ver historial de la carpeta) |
| (pendiente) | Segundo día de trabajo: ajustes tras confirmar la variante | |

Regla: commits en al menos 2 días distintos y mínimo 3 commits por producto.

## 7. Fuentes consultadas

| Fuente (nombre y enlace) | Fecha de consulta | Para qué la usé |
|---|---|---|
| [Ley 1581 de 2012 · Secretaría del Senado](http://www.secretariasenado.gov.co/senado/basedoc/ley_1581_2012.html) | 2026-11-26 | Referente 1 |
| [Decreto 1074 de 2015 · Función Pública](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=76608) | 2026-11-26 | Reglamentación de la Ley 1581 |
| [Ley 23 de 1982 · Función Pública](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=3431) | 2026-11-26 | Referente 2 y licencia propia |
| [Decisión 351 de 1993 · WIPO Lex](https://www.wipo.int/wipolex/es/legislation/details/9445) | 2026-11-26 | Referente 3 |
| [WCAG 2.2 · W3C](https://www.w3.org/TR/WCAG22/) | 2026-11-26 | Referente 4 |
| [Ley 1480 de 2011 · Secretaría del Senado](http://www.secretariasenado.gov.co/senado/basedoc/ley_1480_2011.html) | 2026-11-26 | Referente 5 |
| [Render pricing](https://render.com/pricing) · [Amazon SES pricing](https://aws.amazon.com/ses/pricing/) | 2026-11-26 | Costos de hosting y correo |

## 8. Uso de herramientas de IA (declaración)

| Herramienta | Para qué la usé | Qué parte del producto | Cómo verifiqué el resultado |
|---|---|---|---|
| Claude (Anthropic) en Claude Code | Proponer redacción y estructura; armar la hoja de cálculo con fórmulas; consultar páginas de precios y comprobar que los enlaces de las normas responden | A1 a A6 | Normas abiertas en sus fuentes oficiales (enlaces con fecha); precios tomados de las páginas de los proveedores el 2026-11-26; revisé las fórmulas de la hoja. La licencia de `email-validator` queda marcada para verificar |

## 9. Declaración de autoría

Declaro que este producto es de mi autoría, que lo elaboré reutilizando y ajustando el trabajo que realicé durante el año, que las fuentes están citadas, que los usos de IA están declarados arriba y que puedo explicar cada decisión y cada cálculo en la verificación oral del sábado 5 de diciembre de 2026. El caso es el del proyecto de equipo *Fotocopiadora-SyP* (2 personas); las decisiones, cálculos y redacción de esta carpeta son míos.

Declaro además que no incluí datos personales reales ni documentos reales de terceros en este repositorio público.

Usuario de GitHub: `Kevin81A` · Fecha: 2026-11-26
