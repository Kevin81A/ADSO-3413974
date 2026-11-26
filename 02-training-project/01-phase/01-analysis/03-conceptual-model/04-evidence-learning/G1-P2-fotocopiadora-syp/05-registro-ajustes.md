# 5. Registro de ajustes (Anexo D) y segunda verificación

Hallazgos de la 1.ª verificación de la [lista de chequeo](04-lista-chequeo.md), sobre los artefactos base del equipo. Los enlaces de commit apuntan a mi fork (`Kevin81A/ADSO-3413974`).

| # | Hallazgo (criterio que no cumplía) | Artefacto | Antes | Después | Enlace al commit | ¿Se verificó de nuevo? |
|---|---|---|---|---|---|---|
| H-01 | C02: casos de uso sin requisito | SRS y matriz | El diagrama del equipo tenía «Generar Cotización» y «Reportar Contadores (Renting)», pero el SRS v2.0 no tenía requisitos para ellos | Se agregaron **RF-12** (solicitar cotización) y **RF-13** (reportar contadores) al catálogo v2.1; CU-16 y CU-17 quedan trazados | ver README §3 | Sí: C02 cumple (2.ª verif.) |
| H-02 | C06: actores que son personas | Diagrama de CU | Actores «Administrador (nombre propio)» y «Técnico Ricoh (nombre propio)» | Roles: **Administrador** y **Técnico de soporte**; sin datos personales en un repositorio público | ver README §3 | Sí: C06 cumple |
| H-03 | C05 y C07: nombres que no son función; sin include ni extend | Diagrama de CU | 10 casos, 0 relaciones; nombres como «Gestión CRUD Productos», «Panel y analítica SyP», «Gestión de Cuenta y JWT» (tres objetivos en uno) | 23 casos verbo + objeto; «Gestión de Cuenta» se separó en CU-09, CU-10 y CU-11; **3 «include»** (CU-04→CU-05, CU-06→CU-05, CU-06→CU-08) y **3 «extend»** (CU-03, CU-07, CU-11), cada uno justificado | ver README §3 | Sí: C05 y C07 cumplen |
| H-04 | C14: N:M sin resolver (atributo multivaluado) | MER | `orders.items_json` y `quotes.items_json` guardaban la lista de productos en un solo campo de texto | Entidades asociativas **DETALLE_PEDIDO** y **DETALLE_COTIZACION** con atributos propios (cantidad, precio_unitario) | ver README §3 | Sí: C14 cumple |
| H-05 | C08: detalle de implementación en el análisis | Diagrama de CU | «Realizar Checkout: PSE, Bancolombia, Nequi, Crédito»; «Gestión de Cuenta y JWT» | Casos sin tecnología ni marcas; el pago en línea quedó como extensión CU-07 con la Pasarela de pagos como actor secundario | ver README §3 | Sí: C08 cumple |
| H-06 | C18: funciones del SRS sin caso de uso | Diagrama de CU | No había casos para mensajes de contacto (RF-08.5, RF-10.6), historial (RF-06.4) ni información de la empresa (RF-07, RF-08.1-08.4) | Se agregaron CU-12, CU-13, CU-14 y CU-22; cobertura de RF del 97,6 % | ver README §3 | Sí: C18 cumple |

## Segunda verificación

Después de los ajustes se aplicó de nuevo la lista completa: **19 de 19 criterios cumplen**, incluidos los 7 que fallaron (C02, C05, C06, C07, C08, C14, C18). La columna «2.ª verif.» de la lista de chequeo tiene el resultado y la evidencia de cada uno.
