# B7 · Lista de chequeo de verificación del diseño (P1 y P2)

Severidad: **Crítico** = rompe un requisito o la integridad de los datos · **Mayor** = afecta la calidad o la trazabilidad, no el funcionamiento · **Menor** = forma o legibilidad.

Aplicada sobre los artefactos de [G2-P1](../G2-P1-fotocopiadora-syp/README.md) y de esta carpeta. «Cumple» refleja el estado **final**; si hubo hallazgo, la corrección está en el registro de abajo.

| ID | Artefacto | Criterio de aceptación (medible) | Severidad | Cumple | Evidencia |
|---|---|---|---|---|---|
| LC-01 | Ficha A1 | Lista ≥ 8 RF y ≥ 3 RNF con su ID del SRS | Mayor | Sí | 13 RF y 6 RNF en [A1](../G2-P1-fotocopiadora-syp/A1-ficha-interpretacion.md) |
| LC-02 | Ficha A1 | El lenguaje y la base de datos se justifican con ≥ 3 condiciones del caso cada uno | Mayor | Sí | 4 condiciones para Python, 3 para la base relacional |
| LC-03 | Clases | Hay ≥ 8 clases con atributos tipados, visibilidad y métodos con parámetros | Mayor | Sí | 28 clases en A2 |
| LC-04 | Clases | Todas las asociaciones tienen multiplicidad en los dos extremos | Menor | Sí | Revisadas las 11 asociaciones del diagrama |
| LC-05 | Clases | Cada clase traza a ≥ 1 requisito (matriz hacia atrás) | Mayor | Sí (tras H-01) | 28/28 en [A7](../G2-P1-fotocopiadora-syp/A7-matriz-trazabilidad.md) |
| LC-06 | Clases | Ninguna clase mezcla dos áreas (interfaz, negocio, persistencia, cobro, notificaciones) | Mayor | Sí | `Pedido` no guarda ni notifica; tabla de áreas en A2 |
| LC-07 | Clases | Hay ≥ 1 composición y ≥ 1 interfaz con ≥ 2 implementaciones | Mayor | Sí | 3 composiciones; `MetodoPago` con 3 implementaciones |
| LC-08 | Patrones | Hay ≥ 2 patrones GoF distintos dibujados en el diagrama, uno distinto de singleton | Mayor | Sí | Estrategia, Fachada, Singleton (colores en A2) |
| LC-09 | Patrones | Cada patrón declara problema del caso, clases y mejora en mantenibilidad | Menor | Sí | Tabla A3 |
| LC-10 | Arquitectura | La presentación no accede directamente a la base de datos (sin capas saltadas) | Crítico | Sí | Diagrama A4: cada capa solo llama a la de abajo |
| LC-11 | Arquitectura | Cada RNF de la ficha tiene una decisión visible en la tabla de arquitectura | Mayor | Sí | RNF-03, 04, 05, 07, 11 en la tabla A4 |
| LC-12 | Componentes | Hay ≥ 5 componentes con interfaz provista y requeridas nombradas | Mayor | Sí | 8 componentes en A5 |
| LC-13 | Componentes | Las dependencias van en una sola dirección (ningún ciclo) | Mayor | Sí | Diagrama A5 |
| LC-14 | Despliegue | Hay ≥ 3 nodos y cada conexión indica protocolo y puerto | Menor | Sí | 6 nodos; HTTPS 443, SMTP 587 en A6 |
| LC-15 | Todos los diagramas | Cada diagrama tiene título, es legible (sin textos encimados) y trae fuente editable | Menor | Sí (tras H-02 y H-03) | `.drawio` + `.svg` + `.png` en `diagramas/` |
| LC-16 | Modelo conceptual | ≥ 6 entidades con identificador; cardinalidad mínima y máxima y verbo en cada relación | Mayor | Sí | 17 entidades; tabla de relaciones en [B1](B1-modelo-conceptual.md) |
| LC-17 | Modelo lógico | Toda tabla tiene PK y toda relación 1:N tiene FK | Crítico | Sí | 18 tablas, 20 FK ([evidencia](sql/B5-evidencia-ejecucion.txt)) |
| LC-18 | Modelo lógico | Cada N:M tiene tabla intermedia con PK compuesta | Crítico | Sí | `detalle_pedido`, `detalle_cotizacion`, `item_carrito`, `compatibilidad_producto` |
| LC-19 | Normalización | No hay columnas con varios valores en una celda (1FN) | Crítico | Sí | `items_json` y `compatible_ids` eliminados ([B3](B3-normalizacion.md)) |
| LC-20 | Normalización | No hay dependencias parciales ni transitivas en el modelo final | Crítico | Sí | B3: 2FN en `detalle_pedido`, 3FN con `ciudad` y `categoria` |
| LC-21 | Diccionario | 100 % de las columnas con tipo, tamaño, restricciones y dominio | Mayor | Sí | 18 tablas y 107 columnas en [B4](B4-diccionario-datos.md) |
| LC-22 | Script SQL | Ejecuta sin errores en un motor real | Crítico | Sí | SQLite 3.49.1, [log](sql/B5-evidencia-ejecucion.txt) |
| LC-23 | Script SQL | Tiene ≥ 3 `CHECK` y `ON DELETE` en ≥ 3 FK | Mayor | Sí | 26 `CHECK`, 20 `ON DELETE` |
| LC-24 | Consistencia | Nombres y tipos idénticos entre diccionario, script y modelo lógico | Mayor | Sí | Diccionario y script generados desde la misma definición |
| LC-25 | Consistencia | Los números citados en los documentos coinciden con los artefactos | Menor | Sí (tras H-04 y H-05) | Conteos verificados contra el script y los diagramas |
| LC-26 | Seguridad | Hay ≥ 2 políticas por principio y contraseñas con hash y sal, no «cifradas» | Crítico | Sí | 10 políticas en [B6](B6-politicas-seguridad.md); P4 bcrypt |
| LC-27 | Seguridad | Hay matriz de ≥ 3 roles contra tablas y política de datos personales (finalidad y autorización) | Mayor | Sí | 4 roles × 12 grupos de tablas; P7 |
| LC-28 | Seguridad | El respaldo tiene frecuencia y prueba de restauración | Mayor | Sí | P8 (diario) y P9 (restauración mensual con acta) |

**Resultado:** 28 criterios; **28 cumplen** en el estado final. En la primera pasada fallaron LC-05, LC-15 (dos veces) y LC-25 (dos veces) → 5 hallazgos corregidos.

## Registro de hallazgos y correcciones

| ID | Artefacto | Descripción del hallazgo | Requisito o criterio afectado | Severidad | Corrección aplicada |
|---|---|---|---|---|---|
| H-01 | Diagrama de clases (A2) | La primera versión del diagrama no tenía clases para RF-07, RF-08, RF-12 y RF-13: la matriz A7 no podía mapear esos requisitos a una clase | LC-05 · RF-07, RF-08, RF-12, RF-13 | Mayor | Se agregaron `Cotizacion`, `ReporteContador`, `MensajeContacto` e `InformacionEmpresa` con atributos tipados y métodos; la matriz queda en 13/13 RF y 28/28 clases |
| H-02 | Arquitectura (A4) | En la primera exportación el texto de la capa API se salía de la caja y la nota de reglas tapaba la capa API | LC-15 | Menor | Texto partido en dos líneas y nota movida a la esquina inferior derecha |
| H-03 | Componentes (A5) | La dependencia de Pedidos hacia IAutenticacion atravesaba la caja de Catálogo y parecía una dependencia de Catálogo | LC-15 · LC-13 | Menor | Línea redibujada por encima de la fila de componentes |
| H-04 | Modelo conceptual (B1) y lógico (B2) | Se decía «19 entidades», pero el modelo tiene 17 (la compatibilidad es una relación, no una entidad) | LC-25 | Menor | Texto corregido a 17 entidades y explicada la diferencia con las 18 tablas |
| H-05 | Políticas (B6) | La política P1 decía «15 CHECK» y el script tiene 26 | LC-25 | Menor | Cifra corregida después de contar en el script |
