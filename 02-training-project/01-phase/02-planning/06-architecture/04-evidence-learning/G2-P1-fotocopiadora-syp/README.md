# README de entrega · Guía 2: Diseño de la solución · Producto 1

> Repositorio público: me identifico solo con mi usuario de GitHub.

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | `Kevin81A` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | SyP Web · Fotocopiadoras SyP (tienda en línea y servicio técnico) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/06-informe-analisis.md` y `.../G1-P1-fotocopiadora-syp/00-insumo-requisitos-srs.md` |
| Cuenta de GitHub con la que haces los commits | `Kevin81A` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | El SRS v2.0 lo hizo el equipo del proyecto *Fotocopiadora-SyP* (2 personas). El informe de análisis de la G1 es mío. |
| ¿Qué parte del SRS es tuya? | Coautor del SRS; los RF-12 y RF-13 (v2.1) los agregué yo en la G1. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| A1 Ficha de interpretación | [A1-ficha-interpretacion.md](A1-ficha-interpretacion.md) | Nuevo, a partir del informe de análisis de la G1 | Selección de 13 RF y 6 RNF; justificación de Python y base relacional con condiciones del caso |
| A2 Diagrama de clases | [A2-A3-clases-y-patrones.md](A2-A3-clases-y-patrones.md) · [drawio](diagramas/A2-diagrama-clases.drawio) | Modelo de dominio de la G1 (`G1-P2-fotocopiadora-syp/diagramas/modelo-dominio.drawio`) y backend del equipo (`Fotocopiadora-SyP/fastapi_backend`) | Tipos, visibilidad y métodos; interfaz `MetodoPago` con 3 implementaciones; capas de persistencia y notificación separadas |
| A3 Patrones | [A2-A3-clases-y-patrones.md](A2-A3-clases-y-patrones.md) | Nuevo | Estrategia, Fachada y Singleton con problema del caso |
| A4 Arquitectura | [A4-A5-A6-arquitectura-y-vistas.md](A4-A5-A6-arquitectura-y-vistas.md) · [drawio](diagramas/A4-arquitectura-capas.drawio) | `Fotocopiadora-SyP/docs/Spain/tech_architecture_diagram.png` (equipo) | Redibujado en 4 capas sin saltos; tabla de 6 decisiones contra RNF; alternativa descartada |
| A5 Componentes | [A4-A5-A6-arquitectura-y-vistas.md](A4-A5-A6-arquitectura-y-vistas.md) · [drawio](diagramas/A5-componentes.drawio) | Nuevo (agrupa los *routers* del backend del equipo) | 8 componentes con interfaces provistas y requeridas |
| A6 Despliegue | [A4-A5-A6-arquitectura-y-vistas.md](A4-A5-A6-arquitectura-y-vistas.md) · [drawio](diagramas/A6-despliegue.drawio) | `Fotocopiadora-SyP/docs/Spain/deployment_diagram.png` y `render.yaml` (equipo) | Nodos con artefactos, protocolos y puertos; nodo de respaldo nuevo |
| A7 Matriz de trazabilidad | [A7-matriz-trazabilidad.md](A7-matriz-trazabilidad.md) | Nuevo | 13/13 RF hacia adelante y 28/28 clases hacia atrás |

**Qué reutilicé:** el modelo de dominio y el informe de análisis que hice en la G1, la estructura real del backend del equipo (*routers*, `security.py`, `database.py`) y los diagramas de arquitectura y despliegue del paquete documental del equipo.

**Qué ajusté para llevarlo al estándar de la rúbrica:** convertí el dominio en un diagrama de clases de diseño con tipos, visibilidad, métodos y relaciones con criterio; separé las responsabilidades por área (dominio, cobro, notificación, persistencia); redibujé arquitectura y despliegue con protocolos, puertos y decisiones atadas a RNF.

**Qué hice completamente nuevo:** la ficha A1, los 3 patrones con su justificación, la vista de componentes con interfaces y la matriz de trazabilidad en los dos sentidos.

## 4. Autoverificación de mínimos

- [x] A1 Ficha de interpretación: ≥ 8 RF y ≥ 3 RNF con ID; plataforma justificada
- [x] A2 Diagrama de clases: ≥ 8 clases, tipos, métodos, multiplicidades, ≥ 1 composición/agregación y ≥ 1 herencia o interfaz (con ≥ 2 implementaciones)
- [x] A3 ≥ 2 patrones GoF distintos aplicados en el diagrama (al menos uno distinto de singleton)
- [x] A4 Arquitectura con diagrama y tabla de ≥ 3 RNF → decisión
- [x] A5 Vista de componentes: ≥ 5 componentes con interfaces
- [x] A6 Vista de despliegue: ≥ 3 nodos con artefactos y protocolos
- [x] A7 Matriz de trazabilidad análisis → diseño
- [x] Fuente editable e imagen exportada de cada diagrama (`diagramas/*.drawio`, `*.svg`, `*.png`)

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| 2026-11-26 | «G2-P1: ficha, diagrama de clases con patrones, arquitectura, componentes, despliegue y matriz» |
| (segundo día) | (anotar el commit del segundo día) |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Claude (Anthropic) en Claude Code | Proponer la redacción de la ficha, la tabla de patrones y las decisiones de arquitectura; generar los `.drawio`/`.svg` a partir de mis listas de clases, componentes y nodos | Comparé las clases con el backend real del equipo, revisé multiplicidades y que ninguna clase mezcle áreas, y corregí los hallazgos de la lista de chequeo (B7 de P2) |

## 7. Enlaces

- Informe de análisis / SRS del caso: [informe G1](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/06-informe-analisis.md)
- Carpeta de esta entrega en GitHub: https://github.com/Kevin81A/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp
- Producto 2 (modelo de datos y verificación): [G2-P2](../G2-P2-fotocopiadora-syp/README.md)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `Kevin81A`  Fecha: 2026-11-26
