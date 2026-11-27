# Insumo · Catálogo de requisitos del SRS (SyP Web)

Fuente: SRS v2.0 del proyecto de equipo *Fotocopiadoras SyP* (`docs/Spain/SRS_Fotocopiadoras_SyP.md` del repositorio del equipo, IEEE 830 adaptado). Aquí se copia **solo la lista de IDs y un texto corto** para poder trazar; el texto completo está en el SRS del equipo.

Ajuste propio (G1): al verificar el SRS contra el sistema que ya construimos encontré dos funciones que existen en el producto y **no estaban en el SRS v2.0** (cotizaciones y reporte de contadores de renting). Las agregué como **RF-12** y **RF-13** (SRS v2.1). Ver el registro de ajustes del producto 2 (hallazgo H-01).

> **Qué SRS se usó y equivalencia de números (ajuste del día 2).** Este catálogo parte del **SRS inicial en texto** del equipo (`docs/Spain/SRS_Fotocopiadoras_SyP.md`), no del SRS formal en Word (`docs/Spain/01_SRS_Fotocopiadoras_SyP.docx`, v2.0). Los dos numeran distinto: en el Word las cotizaciones ya son **RF-04** y los contadores de renting **RF-08**, y allí RF-12 y RF-13 son otros requisitos (asignación de solicitudes técnicas y notificaciones). Por eso «el SRS v2.0 no las tenía» se refiere solo al SRS en texto. Equivalencias principales (este catálogo → Word): RF-02/RF-03 → RF-01/RF-02 (catálogo y ficha) · RF-04 → RF-03 (carrito) · RF-12 → RF-04 (cotizaciones) · RF-05 → RF-05 (checkout) · RF-06 → RF-06 (cuentas) · RF-09 → RF-07 (servicio técnico) · RF-13 → RF-08 (contadores) · RF-10.7 → RF-09 (analítica) · RF-10.2 → RF-10 (productos) · RF-10.4 → RF-11 (pedidos) · RF-10.5 → RF-12 (solicitudes) · RF-08.5 → RF-15 (contacto). Hallazgo H-07 del registro de ajustes.

## Requisitos funcionales (42 ítems trazables)

| ID | Requisito (texto corto) |
|---|---|
| RF-01 | Mostrar página de inicio con propuesta de valor, destacados y accesos a categorías |
| RF-02.1 | Listar productos con imagen, nombre, categoría y precio |
| RF-02.2 | Filtrar productos por categoría |
| RF-02.3 | Buscar productos por texto |
| RF-02.4 | Mostrar el número de productos encontrados |
| RF-03.1 | Mostrar imagen, nombre, categoría, descripción y precio del producto |
| RF-03.2 | Seleccionar variantes del producto |
| RF-03.3 | Mostrar disponibilidad (pocas unidades, agotado) |
| RF-03.4 | Agregar el producto al carrito desde la ficha |
| RF-03.5 | Descargar la ficha técnica (PDF) de un equipo |
| RF-04.1 | Agregar, modificar cantidad y eliminar productos del carrito |
| RF-04.2 | Mostrar el total acumulado en tiempo real |
| RF-04.3 | Conservar el carrito durante la sesión |
| RF-04.4 | Mostrar contador de artículos del carrito en la cabecera |
| RF-05.1 | Solicitar datos de envío y facturación |
| RF-05.2 | Mostrar resumen del pedido antes de confirmar |
| RF-05.3 | Ofrecer al menos un método de pago |
| RF-05.4 | Generar número de pedido único y enviar confirmación |
| RF-06.1 | Registrar clientes nuevos |
| RF-06.2 | Iniciar y cerrar sesión |
| RF-06.3 | Recuperar contraseña |
| RF-06.4 | Mostrar historial de pedidos del cliente |
| RF-06.5 | Comprar como invitado (opcional v1) |
| RF-07 | Mostrar página «Nosotros» |
| RF-08.1 | Mostrar dirección, horarios y teléfonos |
| RF-08.2 | Mostrar mapa embebido de la ubicación |
| RF-08.3 | Enlace directo a WhatsApp con mensaje predeterminado |
| RF-08.4 | Enlaces a redes sociales |
| RF-08.5 | Formulario de contacto que llega al panel del administrador |
| RF-09.1 | Página para describir el problema del equipo y pedir visita o diagnóstico |
| RF-09.2 | Capturar nombre, teléfono, marca/modelo y descripción del problema |
| RF-09.3 | Registrar las solicitudes en el panel con estados (recibida, en proceso, resuelta) |
| RF-10.1 | Acceso restringido al panel por autenticación y rol |
| RF-10.2 | Gestionar productos (crear, consultar, actualizar, retirar) |
| RF-10.3 | Gestionar categorías |
| RF-10.4 | Gestionar pedidos: ver detalle y cambiar estado |
| RF-10.5 | Gestionar solicitudes de servicio técnico |
| RF-10.6 | Ver mensajes del formulario de contacto |
| RF-10.7 | Ver estadísticas básicas (opcional v1) |
| RF-11 | Navegación global, contador de carrito y pie de página en todas las páginas |
| RF-12 | **(nuevo v2.1)** Solicitar una cotización formal con IVA para varios productos |
| RF-13 | **(nuevo v2.1)** Reportar mensualmente los contadores (copias mono y color) de un equipo en renting |

## Requisitos no funcionales (no se trazan a casos de uso)

Los requisitos no funcionales describen **cómo** debe comportarse el sistema, no una función que un actor pide; por eso no aparecen en la matriz requisito → caso de uso, sino como restricciones de los casos y del diseño.

| ID | Tipo | Requisito |
|---|---|---|
| RNF-01 | Usabilidad | Máximo 3 clics para llegar a cualquier producto desde el inicio |
| RNF-02 | Responsividad | Funciona en móvil, tableta y escritorio |
| RNF-03 | Rendimiento | Páginas principales cargan en menos de 3 s |
| RNF-04 | Disponibilidad | 99 % de disponibilidad mensual |
| RNF-05 | Seguridad | Contraseñas con hash, HTTPS, sin guardar datos de tarjeta |
| RNF-06 | Escalabilidad | Soporta un catálogo de más de 177 productos sin degradarse |
| RNF-07 | Mantenibilidad | El personal actualiza productos y precios sin programador |
| RNF-08 | Compatibilidad | Chrome, Safari, Firefox y Edge recientes |
| RNF-09 | SEO | Metadatos de título y descripción en cada página |
| RNF-10 | Localización | COP, fecha DD/MM/AAAA, español |
| RNF-11 | Respaldo | Copia de la base de datos al menos diaria |
