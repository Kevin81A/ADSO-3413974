# 6. Informe de análisis · SyP Web (Anexo E)

**Proyecto:** SyP Web, tienda en línea y servicio técnico de Fotocopiadoras SyP (Neiva) · **Autor:** `Kevin81A` · **Metodología:** Scrum, 2 sprints de análisis de una semana · **Fecha:** noviembre de 2026

## 1. Requisitos interpretados

El insumo fue el SRS v2.0 del equipo (IEEE 830 adaptado). Al interpretarlo:

- **Requisitos funcionales:** 42 ítems trazables (RF-01 a RF-13 con sus subrequisitos). Al cruzar el SRS con el sistema que ya construimos agregué **RF-12** (solicitar cotización) y **RF-13** (reportar contadores de renting), que el producto tenía y el SRS no (SRS v2.1). Hay tres opcionales para la v1: RF-06.5, RF-10.7 y el método de pago en línea de RF-05.3, que modelé como extensión (CU-07).
- **Requisitos no funcionales:** 11 (usabilidad, responsividad, rendimiento < 3 s, disponibilidad 99 %, seguridad con hash y HTTPS, escalabilidad, mantenibilidad sin programador, compatibilidad, SEO, localización COP y respaldo diario). No generan casos de uso: restringen los casos y el diseño (por ejemplo, RNF-07 justifica CU-18 y la clase InformaciónEmpresa; RNF-05 justifica que el pago lo procese un actor externo).
- **Distinción aplicada:** RF-11 (navegación global) se trató como requisito de interfaz y no como caso de uso.

## 2. Modelos elaborados (enlaces)

| Modelo | Archivo |
|---|---|
| Caracterización, comparación y selección de metodología | [P1 · 01](../G1-P1-fotocopiadora-syp/01-caracterizacion-y-metodologia.md) |
| Plan de actividades de análisis | [P1 · 02](../G1-P1-fotocopiadora-syp/02-plan-actividades-analisis.md) |
| Diagrama de casos de uso (23 casos, 3 include, 3 extend) | [P1 · 03](../G1-P1-fotocopiadora-syp/03-casos-de-uso.md) |
| Matriz requisito → caso de uso | [P1 · 04](../G1-P1-fotocopiadora-syp/04-matriz-requisito-caso-de-uso.md) |
| Diagramas de actividades (CU-06, CU-15) | [01-diagramas-actividades.md](01-diagramas-actividades.md) |
| Plantillas extendidas (CU-06, CU-15, CU-18) | [02-plantillas-extendidas.md](02-plantillas-extendidas.md) |
| Modelo de dominio (17 clases) | [03 · §3.1](03-dominio-mer-prototipo.md) |
| Modelo entidad-relación (15 entidades, pata de gallo) | [03 · §3.2](03-dominio-mer-prototipo.md) |
| Prototipo (P-01, P-02, P-03) | [03 · §3.3](03-dominio-mer-prototipo.md) |
| Matriz de trazabilidad | [07-matriz-trazabilidad.md](07-matriz-trazabilidad.md) |

## 3. Resultado de la verificación

Apliqué una lista de chequeo de **19 criterios** (5 de cobertura y trazabilidad) en dos rondas ([04-lista-chequeo.md](04-lista-chequeo.md)).

- **1.ª verificación (artefactos base del equipo):** cumplen 12; **no cumplen 7**: C02 (casos sin requisito), C05 (nombres que no son función), C06 (actores que son personas), C07 (sin include ni extend), C08 (tecnología en los casos de uso), C14 (N:M sin resolver en el MER) y C18 (funciones del SRS sin caso de uso).
- **2.ª verificación (después de ajustar):** cumplen los **19**.
- **Cobertura final:** 41 de 42 RF (97,6 %) trazados hasta caso de uso, clase de dominio y entidad; RF-11 justificado.

## 4. Ajustes realizados

Seis hallazgos corregidos ([05-registro-ajustes.md](05-registro-ajustes.md)):

1. **H-01:** se agregaron RF-12 y RF-13 al SRS para que todo caso de uso tenga requisito.
2. **H-02:** los actores con nombres propios pasaron a roles.
3. **H-03:** 23 casos con verbo + objeto; se separó «Gestión de Cuenta y JWT» y se agregaron 3 include y 3 extend justificados.
4. **H-04:** la lista de productos guardada como texto en pedidos y cotizaciones se resolvió con DETALLE_PEDIDO y DETALLE_COTIZACION.
5. **H-05:** se quitó la tecnología y las marcas de bancos de los casos de uso; el pago en línea quedó como extensión con actor secundario.
6. **H-06:** se agregaron los casos que faltaban para contacto, historial e información de la empresa.

**Pendiente para la fase de diseño (G2):** pasar el MER a modelo lógico con claves foráneas, normalizar la lista de modelos compatibles que hoy se guarda como texto en el producto y definir las políticas de seguridad de los datos personales.
