# README de entrega · Guía 2: Diseño de la solución · Producto 2

> Repositorio público: me identifico solo con mi usuario de GitHub. Los datos de prueba del script son ficticios.

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub del autor | `Kevin81A` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | SyP Web · Fotocopiadoras SyP (el mismo de P1) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/06-informe-analisis.md` |
| Cuenta de GitHub con la que haces los commits | `Kevin81A` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | SRS del equipo (2 personas); informe de análisis y MER ajustado de la G1, míos. |
| ¿Qué parte del SRS es tuya? | Coautor; RF-12 y RF-13 agregados por mí. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| B1 Modelo conceptual | [B1-modelo-conceptual.md](B1-modelo-conceptual.md) | MER de la G1 (`01-analysis/.../G1-P2-fotocopiadora-syp/diagramas/modelo-entidad-relacion.drawio`) | N:M recursiva de compatibilidad, entidad CIUDAD, RED_SOCIAL, dos roles usuario-solicitud, total derivado |
| B2 Modelo lógico | [B2-modelo-logico.md](B2-modelo-logico.md) | Tablas SQLite del equipo (`Fotocopiadora-SyP/fastapi_backend/database.py`) | 18 tablas con PK/FK, tablas intermedias y cuadro de reglas de transformación |
| B3 Normalización | [B3-normalizacion.md](B3-normalizacion.md) | Tablas reales `orders` y `products` del equipo | 0FN → 3FN con dependencias funcionales escritas |
| B4 Diccionario de datos | [B4-diccionario-datos.md](B4-diccionario-datos.md) | `Fotocopiadora-SyP/docs/Spain/04_Diccionario_y_Modelo_Base_Datos.docx` (equipo) como referencia | Rehecho para el modelo normalizado: 18 tablas, 107 columnas, estándar de nombrado |
| B5 Script SQL | [sql/B5-crear-modelo.sql](sql/B5-crear-modelo.sql) · [evidencia](sql/B5-evidencia-ejecucion.txt) · [datos de prueba](sql/B5-datos-prueba.sql) | Nuevo | 26 `CHECK`, 20 FK con `ON DELETE`, vista de totales, índices; ejecutado en SQLite 3.49.1 |
| B6 Políticas de seguridad | [B6-politicas-seguridad.md](B6-politicas-seguridad.md) | `Fotocopiadora-SyP/docs/Spain/AUDITORIA_SEGURIDAD_STRIX.md` (equipo) como insumo | 10 políticas sobre tablas del caso, matriz de 4 roles, Ley 1581, respaldo y restauración |
| B7 Lista de chequeo | [B7-lista-chequeo.md](B7-lista-chequeo.md) | Nuevo | 28 criterios con severidad sobre P1 y P2; 5 hallazgos corregidos |

**Qué reutilicé:** el MER que ajusté en la G1, las tablas reales del backend del equipo y su diccionario y auditoría de seguridad como insumos.

**Qué ajusté para llevarlo al estándar de la rúbrica:** eliminé los atributos multivaluados (`items_json`, `compatible_ids`), saqué la dependencia transitiva de ciudad y de los datos de la cuenta, declaré todas las acciones referenciales y rehíce el diccionario para que coincida exactamente con el script.

**Qué hice completamente nuevo:** la normalización paso a paso, el script con su evidencia de ejecución y pruebas negativas, la matriz de roles y la lista de chequeo con registro de hallazgos.

## 4. Autoverificación de mínimos

- [x] B1 Modelo conceptual: ≥ 6 entidades, cardinalidades, ≥ 1 N:M y ≥ 1 1:N (17 entidades, 4 N:M)
- [x] B2 Modelo lógico: ≥ 8 tablas con PK/FK y cuadro de reglas de transformación (18 tablas)
- [x] B3 Normalización: ≥ 2 tablas de 0FN a 3FN con dependencias funcionales (`orders` con llave compuesta; `products` con dependencia transitiva)
- [x] B4 Diccionario de datos completo (107 de 107 columnas)
- [x] B5 Script SQL ejecutado sin errores (evidencia adjunta) y `ON DELETE` en ≥ 3 FK (20)
- [x] B6 ≥ 6 políticas de seguridad (con hash y sal en contraseñas y TLS) y matriz de ≥ 3 roles (10 políticas, 4 roles)
- [x] B7 Lista de chequeo de ≥ 20 criterios, diligenciada sobre P1 y P2, con evidencia (28)

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| 2026-11-26 | «G2-P2: modelo conceptual y lógico, normalización, diccionario, script SQL con evidencia, seguridad y lista de chequeo» |
| (segundo día) | (anotar el commit del segundo día) |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Claude (Anthropic) en Claude Code | Proponer la redacción de la normalización y las políticas; generar el script SQL y el diccionario desde una sola definición de tablas y ejecutar el script en SQLite | Revisé cada dependencia funcional contra las tablas reales del equipo, comprobé en el log que el script corre sin errores y que las pruebas negativas se rechazan, y corregí los conteos que no coincidían (hallazgos H-04 y H-05) |

## 7. Enlaces

- Informe de análisis / SRS del caso: [informe G1](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/06-informe-analisis.md)
- Carpeta de esta entrega en GitHub: https://github.com/Kevin81A/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp
- Producto 1 (artefactos de diseño): [G2-P1](../G2-P1-fotocopiadora-syp/README.md)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `Kevin81A`  Fecha: 2026-11-26
