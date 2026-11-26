# README de entrega · Guía 1 · Modelo conceptual · Producto 1

> Repositorio público: me identifico solo con mi usuario de GitHub. No hay datos personales de terceros.

## 1. Datos de la entrega

- **Producto:** P1 · plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `Kevin81A`
- **Caso de estudio:** SyP Web, tienda en línea y servicio técnico de *Fotocopiadoras SyP* (Neiva)
- **Trabajo en equipo del año:** sí, el proyecto *Fotocopiadora-SyP* (2 personas). El SRS y el diagrama de casos de uso base son del equipo; **el ajuste, la selección de metodología, el plan y la matriz de esta carpeta son individuales**.

## 2. Qué reutilicé

Mi carpeta `03-execute` no tiene artefactos de este caso: el trabajo del proyecto está en el repositorio del equipo `Fotocopiadora-SyP` (fork `Kevin81A/Fotocopiadora-SyP`).

| Artefacto | Ruta original | ¿Solo o en equipo? |
|---|---|---|
| SRS v2.0 (requisitos funcionales y no funcionales) | `Fotocopiadora-SyP/docs/Spain/SRS_Fotocopiadoras_SyP.md` | En equipo |
| Diagrama general de casos de uso (10 casos) | `Fotocopiadora-SyP/docs/Spain/srs_use_case_diagram.png` | En equipo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Diagrama de casos de uso | Pasé de 10 a **23 casos** con nombre verbo + objeto y agregué **3 «include» y 3 «extend»** justificados (el original no tenía relaciones). Mejora C4. | [ce72748](https://github.com/Kevin81A/ADSO-3413974/commit/ce72748) |
| 2 | Diagrama de casos de uso | Cambié los **actores con nombres de personas** por roles (Administrador, Técnico de soporte) y agregué actores secundarios y la generalización Cliente registrado → Visitante. Mejora C4. | [ce72748](https://github.com/Kevin81A/ADSO-3413974/commit/ce72748) |
| 3 | Diagrama de casos de uso | Quité **detalle técnico** («JWT», «PSE, Bancolombia, Nequi») y separé «Gestión de Cuenta y JWT» en CU-09, CU-10 y CU-11. Mejora C4. | [ce72748](https://github.com/Kevin81A/ADSO-3413974/commit/ce72748) |
| 4 | SRS (catálogo de requisitos) | Agregué **RF-12 y RF-13** porque dos casos del diagrama no tenían requisito; separé funcionales de no funcionales. Mejora C3. | [ce72748](https://github.com/Kevin81A/ADSO-3413974/commit/ce72748) |
| 5 | Diagrama de casos de uso | Agregué casos que el SRS pedía y faltaban (CU-12, CU-13, CU-14, CU-22). Mejora C3 (cobertura 97,6 %). | [ce72748](https://github.com/Kevin81A/ADSO-3413974/commit/ce72748) |

## 4. Qué construí nuevo

- Caracterización de la solución y comparación de RUP, Scrum, XP y RAD con 5 criterios del caso; selección justificada de Scrum.
- Plan de 11 actividades de análisis priorizadas, con responsable, fecha, entregable y cronograma por sprint.
- Matriz requisito → caso de uso (42 RF, cobertura 97,6 %, RF-11 justificado).
- Fuente editable `.drawio` del diagrama (el original solo existía como imagen).

## 5. Artefactos entregados

- [x] Caracterización de la solución: [01-caracterizacion-y-metodologia.md §1.1](01-caracterizacion-y-metodologia.md)
- [x] Comparación de metodologías y selección justificada: [01-caracterizacion-y-metodologia.md §1.2-1.3](01-caracterizacion-y-metodologia.md)
- [x] Plan de actividades, cronograma y entregables: [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [diagramas/casos-de-uso.drawio](diagramas/casos-de-uso.drawio)
- [x] Diagrama de casos de uso (imagen): [diagramas/casos-de-uso.svg](diagramas/casos-de-uso.svg) · [png](diagramas/casos-de-uso.png)
- [x] Actores, casos y justificación de relaciones: [03-casos-de-uso.md](03-casos-de-uso.md)
- [x] Matriz requisito → caso de uso: [04-matriz-requisito-caso-de-uso.md](04-matriz-requisito-caso-de-uso.md)
- Insumo (lista de requisitos con ID): [00-insumo-requisitos-srs.md](00-insumo-requisitos-srs.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma: `Kevin81A` · 2026-11-26

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Claude (Anthropic) en Claude Code | Proponer la redacción de la caracterización, la tabla comparativa y el plan; generar los archivos `.drawio`/`.svg` del diagrama a partir de mi lista de casos y relaciones; revisar la cobertura de la matriz | Comprobé cada caso contra el SRS y contra el sistema real del equipo, revisé que cada «include» sea obligatorio y cada «extend» condicional, y que la matriz cubra los 42 RF |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre el 21 de noviembre de 2026 y la entrega (ver historial de la carpeta).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
