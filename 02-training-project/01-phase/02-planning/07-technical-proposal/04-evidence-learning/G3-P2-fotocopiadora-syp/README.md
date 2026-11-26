# G3 · Propuesta técnica · README de entrega · Producto 2

> Repositorio público: me identifico con mi usuario de GitHub. Sin datos personales reales.

## 1. Identificación

| Campo | Valor |
|---|---|
| Producto | P2 Propuesta técnica y validación |
| Usuario de GitHub del autor | `Kevin81A` |
| Ficha | 3413974 |
| Variante del escenario asignada (A, B, C o D) | **A (asumida; pendiente de confirmar con el instructor)** |
| Caso de estudio (nombre del proyecto de mi fork) | SyP Web · Fotocopiadoras SyP (Neiva) |
| Fecha de la última actualización | 2026-11-26 |
| Plazo de entrega | A más tardar el sábado 5 de diciembre de 2026 a las 6:00 a. m. |

## 2. Qué reutilicé de mi trabajo del año

| Artefacto de este producto | Archivo de origen (ruta) | Cómo lo reutilicé |
|---|---|---|
| Diagrama de arquitectura y despliegue | `06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/diagramas/A6-despliegue.drawio` | Lo ajusté: correo por la API de SES, pasarela en fase 2, dominio con costo y rubro del presupuesto en cada nodo |
| Riesgos | `03-execute/18-week/02-optional-activity/Plan de contingencia.png` | Base para la matriz de 6 riesgos con valor esperado |
| Presentación | `03-execute/14-week/02-optional-activity/SIGEV_Presentacion.pptx` (estructura de pitch) | Seguí el orden problema → beneficio → solución → costo → plazo |
| Esfuerzo y costos | Hoja A6 del Producto 1 | Horas PERT y precios trasladados al presupuesto |

## 3. Qué ajusté o construí desde cero

| Artefacto | Qué cambié o construí | Por qué |
|---|---|---|
| B1 Comparativo | 2 categorías × 3 alternativas reales, matriz de 5 criterios (100 %), TCO a 36 meses | C1 |
| B2 Presupuesto | Hoja con fórmulas: 6 categorías, directos e indirectos, únicos y recurrentes, contingencia = suma de valores esperados, margen e IVA, columna de nodo del diagrama, flujo a 36 meses | C2 |
| B3 Propuesta v1.0 | 12 secciones, diagrama ajustado, EDT de 11 tareas con ruta crítica, 6 riesgos | C3 |
| B4 Presentación | 10 diapositivas con propósito de negociación (ideal, mínima, MAAN) y 4 objeciones | C4 |
| B6 Contrato, términos de referencia y ANS | 14 elementos de contrato, 8 términos de referencia, ANS de 4 métricas | C7 |

## 4. Enlaces a los entregables

- [x] B1. Análisis comparativo de proveedores: [B1-comparativo-proveedores.md](B1-comparativo-proveedores.md) · [hoja](B1-comparativo-proveedores.xlsx)
- [x] B2. Presupuesto de software y hardware: [B2-presupuesto.xlsx](B2-presupuesto.xlsx)
- [x] B3. Propuesta técnica versión 1.0: [B3-propuesta-tecnica-v1.0.md](B3-propuesta-tecnica-v1.0.md) · diagrama [drawio](diagramas/arquitectura-despliegue-propuesta.drawio)
- [x] B4. Presentación a la contraparte: [B4-presentacion.md](B4-presentacion.md)
- [ ] B5. Acta de validación: [B5-acta-validacion.md](B5-acta-validacion.md) — **pendiente de la reunión real con la contraparte**
- [x] B6. Lista para contrato, términos de referencia y ANS: [B6-contrato-tdr-ans.md](B6-contrato-tdr-ans.md)
- [ ] B7. Propuesta ajustada v1.1 con control de cambios: [B7-control-cambios.md](B7-control-cambios.md) — **pendiente (depende del acta)**

## 5. Autoevaluación de mínimos

| Mínimo | Mi conteo |
|---|---|
| Alternativas por categoría / criterios que suman 100 % | 3 y 3 / sí |
| Riesgos en la matriz / tareas de la EDT | 6 / 11 con duración y predecesoras |
| Sugerencias clasificadas / ajustes de parámetros | pendiente / pendiente |
| Fecha del acta de validación | pendiente (anterior al 2026-12-05) |
| Mis hojas de cálculo usan fórmulas | sí |

## 6. Historial de trabajo

| Fecha | Qué hice ese día | Commits |
|---|---|---|
| 2026-11-26 | Comparativo, presupuesto, propuesta v1.0, presentación, contrato, términos de referencia y ANS | (ver historial de la carpeta) |
| (pendiente) | Reunión de validación, acta, v1.1 y verificación de Brevo | |

## 7. Fuentes consultadas

| Fuente (nombre y enlace) | Fecha de consulta | Para qué la usé |
|---|---|---|
| [Render pricing](https://render.com/pricing) | 2026-11-26 | Comparativo y presupuesto |
| [Railway pricing](https://railway.com/pricing) | 2026-11-26 | Comparativo |
| [DigitalOcean Droplets pricing](https://www.digitalocean.com/pricing/droplets) | 2026-11-26 | Comparativo |
| [Amazon SES pricing](https://aws.amazon.com/ses/pricing/) | 2026-11-26 | Comparativo y presupuesto |
| [Twilio SendGrid pricing](https://www.twilio.com/en-us/products/email-api/pricing) | 2026-11-26 | Comparativo |
| [Brevo pricing](https://www.brevo.com/pricing/) | pendiente | Comparativo (no se pudo leer automáticamente) |

## 8. Uso de herramientas de IA (declaración)

| Herramienta | Para qué la usé | Qué parte del producto | Cómo verifiqué el resultado |
|---|---|---|---|
| Claude (Anthropic) en Claude Code | Consultar las páginas de precios, armar las hojas con fórmulas, calcular la ruta crítica y proponer la redacción de la propuesta, la presentación y el ANS | B1 a B4, B6 | Precios tomados de las páginas oficiales con fecha; revisé que las cifras de la propuesta, la presentación y el presupuesto coincidan. El acta B5 **no** se generó con IA: queda para la reunión real |

## 9. Declaración de autoría

Declaro que este producto es de mi autoría, que lo elaboré reutilizando y ajustando el trabajo que realicé durante el año, que las fuentes están citadas, que los usos de IA están declarados arriba y que puedo explicar cada decisión y cada cálculo en la verificación oral del sábado 5 de diciembre de 2026. El caso es el del proyecto de equipo *Fotocopiadora-SyP*; las decisiones, cálculos y redacción de esta carpeta son míos.

Declaro además que no incluí datos personales reales ni documentos reales de terceros en este repositorio público.

Usuario de GitHub: `Kevin81A` · Fecha: 2026-11-26
