# 2. Plantillas extendidas de casos de uso (Anexo A)

Redactadas como **intención**, sin tecnología (sin tablas, SQL, JWT ni nombres de servicios). Los pasos alternos y de excepción coinciden con las ramas de los diagramas de actividades.

## CU-06 · Realizar pedido

| Campo | Contenido |
|---|---|
| Identificador y nombre | CU-06 · Realizar pedido |
| Requisitos que atiende | RF-05.1, RF-05.2 (vía CU-05), RF-05.3, RF-05.4 (vía CU-08), RF-06.5 |
| Actor primario / secundarios | Cliente registrado o visitante invitado / Servicio de correo; Pasarela de pagos (solo en CU-07) |
| Objetivo del actor | Comprar los productos que tiene en el carrito y recibir un número de pedido |
| Precondiciones | El actor está en el sitio con un carrito abierto en su sesión |
| Disparador | El actor elige «Finalizar compra» en el carrito |
| Flujo principal | 1. El actor elige «Finalizar compra».<br>2. El sistema verifica que el carrito tenga productos y muestra el formulario de envío y facturación.<br>3. El actor ingresa nombre, teléfono, dirección, ciudad y, si quiere, NIT.<br>4. El sistema valida que los datos obligatorios estén completos.<br>5. El sistema calcula el total (CU-05) y muestra el resumen: productos, cantidades, subtotal, IVA y total.<br>6. El actor elige el método de pago (transferencia o contraentrega) y confirma el pedido.<br>7. El sistema verifica que todos los productos sigan disponibles.<br>8. El sistema registra el pedido con un número único.<br>9. En paralelo, el sistema actualiza la disponibilidad de los productos y envía la confirmación al cliente (CU-08).<br>10. El sistema muestra al actor el número y el resumen del pedido. |
| Flujos alternos | **4a.** Si faltan datos obligatorios, el sistema señala los campos faltantes y el caso vuelve al paso 3.<br>**6a.** Si el actor elige pago en línea, se ejecuta CU-07 Pagar en línea; si el pago es aprobado, el caso continúa en el paso 8.<br>**7a.** Si algún producto se agotó, el sistema lo quita del resumen, informa al actor y el caso vuelve al paso 5 con el total recalculado. |
| Excepciones | **2a.** Si el carrito está vacío, el sistema avisa «carrito vacío», lleva al actor al catálogo y el caso termina sin pedido.<br>**6b.** Si la pasarela rechaza el pago en línea, el sistema informa el rechazo, conserva el carrito y el caso termina sin registrar el pedido. |
| Postcondiciones | Existe un pedido con número único en estado «pendiente», la disponibilidad de los productos quedó actualizada y el cliente recibió la confirmación. |
| Reglas de negocio | Precios en COP con IVA del 19 %. Un pedido tiene al menos un producto. Envíos dentro de Neiva por defecto. |
| Pantalla del prototipo | [P-01 Finalizar compra](prototipo/P-01-cu06-realizar-pedido.png) |

## CU-15 · Solicitar servicio técnico

| Campo | Contenido |
|---|---|
| Identificador y nombre | CU-15 · Solicitar servicio técnico |
| Requisitos que atiende | RF-09.1, RF-09.2 |
| Actor primario / secundarios | Visitante (o cliente registrado) / — (el administrador recibe el aviso; la atención es CU-21) |
| Objetivo del actor | Pedir una visita o diagnóstico para su equipo en una fecha que le sirva |
| Precondiciones | Ninguna: el formulario es público y no exige sesión |
| Disparador | El visitante abre la página de servicio técnico |
| Flujo principal | 1. El visitante abre la página de servicio técnico.<br>2. El sistema muestra el formulario de solicitud.<br>3. El visitante ingresa nombre, teléfono, correo, equipo (marca y modelo), tipo de servicio, fecha y franja deseadas y la descripción del problema.<br>4. El sistema valida que los datos obligatorios estén completos.<br>5. El sistema verifica que la fecha deseada esté disponible.<br>6. El sistema verifica que el visitante no haya superado el límite de solicitudes.<br>7. El sistema registra la solicitud con un código y estado «Pendiente».<br>8. En paralelo, el sistema muestra el código al visitante y avisa al administrador de la nueva solicitud. |
| Flujos alternos | **4a.** Si faltan datos obligatorios, el sistema señala los campos y el caso vuelve al paso 3.<br>**5a.** Si la fecha no está disponible, el sistema propone fechas disponibles, el visitante elige una y el caso vuelve al paso 5. |
| Excepciones | **6a.** Si el visitante superó 5 solicitudes en la última hora, el sistema rechaza la solicitud, le pide intentar más tarde y el caso termina sin registro. |
| Postcondiciones | Existe una solicitud con código en estado «Pendiente», visible en el panel del administrador. |
| Reglas de negocio | Tipos de servicio: preventivo, correctivo o diagnóstico. No se agenda en fechas pasadas ni en domingo. Máximo 5 solicitudes por hora por remitente. |
| Pantalla del prototipo | [P-02 Solicitar servicio técnico](prototipo/P-02-cu15-solicitar-servicio.png) |

## CU-18 · Gestionar productos

| Campo | Contenido |
|---|---|
| Identificador y nombre | CU-18 · Gestionar productos |
| Requisitos que atiende | RF-10.2 (y RNF-07: sin depender de un programador) |
| Actor primario / secundarios | Administrador / — |
| Objetivo del actor | Mantener el catálogo al día (productos nuevos, precios, disponibilidad y retiro) |
| Precondiciones | El administrador inició sesión con rol de administrador (CU-10) |
| Disparador | El administrador abre la sección «Productos» del panel |
| Flujo principal | 1. El administrador abre la sección «Productos».<br>2. El sistema lista los productos con nombre, categoría, precio, disponibilidad y estado, y ofrece búsqueda.<br>3. El administrador elige «Nuevo producto».<br>4. El sistema muestra el formulario del producto con las categorías vigentes.<br>5. El administrador ingresa nombre, categoría, precio, disponibilidad, marca, descripción, imagen y, si es un equipo, la ficha técnica.<br>6. El sistema valida que los datos obligatorios estén completos, que el precio sea mayor que cero y que el nombre no exista.<br>7. El sistema registra el producto y lo publica en el catálogo.<br>8. El sistema confirma la operación y actualiza el listado. |
| Flujos alternos | **3a.** Si el administrador elige «Editar» en un producto, el sistema muestra el formulario con los datos actuales y el caso continúa en el paso 5.<br>**3b.** Si el administrador elige «Retirar», el sistema pide confirmación, marca el producto como retirado (deja de verse en el catálogo pero se conserva en los pedidos anteriores) y el caso termina. |
| Excepciones | **6a.** Si ya existe un producto con ese nombre o el precio no es válido, el sistema indica el error y no registra el producto; el administrador puede corregir o cancelar.<br>**6b.** Si la sesión del administrador expiró, el sistema pide iniciar sesión de nuevo y los cambios no se guardan. |
| Postcondiciones | El catálogo muestra el producto con los datos registrados (o ya no lo muestra, si se retiró). |
| Reglas de negocio | Un producto pertenece a una sola categoría. Un producto con pedidos no se elimina: se retira. Disponibilidad: normal, pocas unidades o agotado. |
| Pantalla del prototipo | [P-03 Gestionar productos](prototipo/P-03-cu18-gestionar-productos.png) |
