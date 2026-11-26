# A3 · Referente técnico con normatividad vigente

Enlaces consultados el **2026-11-26** (los de Función Pública, Secretaría del Senado, WIPO Lex y W3C respondieron correctamente ese día). Los textos legales no se copian aquí: se resume qué exige cada norma para SyP Web.

## Normatividad legal y estándares

| # | Norma o estándar | Qué exige | A qué parte del software aplica | Cómo se cumple en SyP Web | Cómo se verifica | Vigencia verificada (enlace y fecha) |
|---|---|---|---|---|---|---|
| 1 | **Ley 1581 de 2012** (protección de datos personales) y su reglamentación en el **Decreto 1074 de 2015** (Libro 2, Parte 2, Título 2, Capítulo 25, que compiló el Decreto 1377 de 2013) | Autorización previa, expresa e informada del titular; finalidad informada; derechos de consulta, actualización y supresión; política de tratamiento publicada; medidas de seguridad | Registro, checkout, cotización, servicio técnico, contacto; tablas `usuario`, `pedido`, `solicitud_servicio`, `mensaje_contacto` | Casilla de autorización obligatoria en cada formulario; política de tratamiento en el pie de página; canal de solicitudes del titular; hash con sal y HTTPS (política P4, P5, P7 de la G2) | Revisión de los 5 formularios (casilla obligatoria y enlace a la política); prueba de una solicitud de supresión | [Ley 1581](http://www.secretariasenado.gov.co/senado/basedoc/ley_1581_2012.html) · [Decreto 1074](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=76608) · 2026-11-26 |
| 2 | **Ley 23 de 1982** (derechos de autor) | Protege el software como obra; distingue derechos morales (del autor, irrenunciables) y patrimoniales (transferibles por contrato escrito) | El código de SyP Web, las imágenes y los textos del sitio | Contrato con cláusula de cesión de derechos patrimoniales a la propietaria al pagar; solo se usan imágenes propias o con licencia; los autores conservan el derecho moral de mención | Revisión del contrato (cláusula de propiedad intelectual) e inventario de imágenes con su origen | [Ley 23 de 1982](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=3431) · 2026-11-26 |
| 3 | **Decisión Andina 351 de 1993** (régimen común sobre derecho de autor y derechos conexos) | Reconoce los programas de ordenador como obras; permite al usuario legítimo hacer copia de respaldo; regula la cesión de derechos | Código fuente, respaldos del software y licencias de terceros | Copia de respaldo del código en el repositorio y entrega del código fuente al cliente; respeto de las licencias de las dependencias (A4) | Verificar que el cliente recibe código y licencias; inventario de dependencias sin licencias incompatibles | [WIPO Lex · Decisión 351](https://www.wipo.int/wipolex/es/legislation/details/9445) · [Normograma Cancillería](https://cancilleria.gov.co/normograma/compilacion/docs/decision_comisioncandina_dec351.htm) · 2026-11-26 |
| 4 | **WCAG 2.2** (W3C, pautas de accesibilidad), nivel AA | Contraste mínimo, navegación por teclado, textos alternativos, formularios con etiquetas y mensajes de error claros | Todas las páginas públicas y el panel | Contraste ≥ 4,5:1, etiquetas en formularios, foco visible, imágenes con `alt` | Validador automático + recorrido con teclado en 3 pantallas (ficha FT-SW-01) | [WCAG 2.2](https://www.w3.org/TR/WCAG22/) · 2026-11-26 |
| 5 (opcional) | **Ley 1480 de 2011** (Estatuto del Consumidor), comercio electrónico | Información veraz del proveedor y del producto, precio total con impuestos, resumen antes de pagar, constancia de la transacción y derecho de retracto | Ficha de producto, checkout y confirmación del pedido | Precios con IVA, resumen del pedido antes de confirmar (RF-05.2), número de pedido y correo de confirmación (RF-05.4), información de retracto en los términos | Revisión del flujo de compra contra la lista de la norma | [Ley 1480](http://www.secretariasenado.gov.co/senado/basedoc/ley_1480_2011.html) · 2026-11-26 |

**Estándar técnico adicional usado en las fichas:** ISO/IEC 25010:2023 (modelo de calidad del producto de software). La página de ISO no permitió la consulta automática el 2026-11-26 (respuesta 403); se cita por su número y año.

## Reglas internas del proyecto (no son normatividad legal)

Estas reglas vienen del documento «Normativa del Proyecto» del año y del equipo; se cumplen, pero **no** se presentan como ley:

| Regla interna | Origen |
|---|---|
| Ramas por funcionalidad y revisión antes de unir a `main` | Acuerdo del equipo |
| Pruebas automatizadas en cada `push` (CI) | Acuerdo del equipo (`.github/workflows/ci.yml`) |
| Versiones de dependencias fijadas en `requirements.txt` | Acuerdo del equipo |
| Nombres de tablas en singular y `snake_case` | Estándar de nombrado de la G2 |
