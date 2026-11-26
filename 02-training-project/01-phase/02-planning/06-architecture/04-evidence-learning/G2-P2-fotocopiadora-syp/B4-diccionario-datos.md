# B4 · Diccionario de datos

**Estándar de nombrado:** tablas en singular y `snake_case`; columnas en `snake_case`; llave primaria `id_<tabla>`; llave foránea con el mismo nombre de la PK que referencia (salvo roles: `id_tecnico`, `id_categoria_padre`, `id_producto_compatible`); restricciones `pk_`, `fk_<tabla>_<columna>`, `uq_`, `ck_`. Motor: SQLite 3 (los tipos `VARCHAR(n)` y `DECIMAL(p,s)` se declaran para documentar el tamaño y facilitar la migración a PostgreSQL).

Cobertura: **18 tablas y 107 columnas (100 %)**. Este diccionario y el script [`sql/B5-crear-modelo.sql`](sql/B5-crear-modelo.sql) salen de la misma fuente, por eso los nombres y tipos son idénticos.

## `usuario`

Personas con cuenta: clientes, administradores y técnicos

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_usuario` | INTEGER | n/a | PK | Entero positivo autoincremental |
| `correo` | VARCHAR | 120 | NOT NULL, UNIQUE | Correo válido; identifica la cuenta |
| `nombre` | VARCHAR | 80 | NOT NULL | Texto |
| `telefono` | VARCHAR | 15 | NOT NULL | Solo dígitos y + |
| `rol` | VARCHAR | 15 | NOT NULL, DEFAULT 'cliente', CHECK (rol IN ('cliente','administrador','tecnico')) | cliente · administrador · tecnico |
| `contrasena_hash` | VARCHAR | 100 | NOT NULL | Hash bcrypt con sal (nunca la contraseña) |
| `nit` | VARCHAR | 15 | — | NIT opcional para factura |
| `activo` | INTEGER | 1 | NOT NULL, DEFAULT 1, CHECK (activo IN (0,1)) | 1 activo · 0 desactivado |
| `creado_en` | DATETIME | n/a | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha y hora de registro |

## `categoria`

Categorías y subcategorías del catálogo (relación recursiva)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_categoria` | INTEGER | n/a | PK | Entero positivo |
| `nombre` | VARCHAR | 60 | NOT NULL, UNIQUE | Ej. Fotocopiadoras, Tintas y tóneres |
| `orden` | INTEGER | n/a | NOT NULL, DEFAULT 0, CHECK (orden >= 0) | Posición en el menú |
| `id_categoria_padre` | INTEGER | n/a | FK → categoria.id_categoria, ON DELETE SET NULL | Nulo si es categoría principal |

## `producto`

Equipos, insumos, repuestos y accesorios en venta

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_producto` | INTEGER | n/a | PK | Entero positivo |
| `id_categoria` | INTEGER | n/a | NOT NULL, FK → categoria.id_categoria, ON DELETE RESTRICT | Categoría existente |
| `nombre` | VARCHAR | 120 | NOT NULL, UNIQUE | Nombre comercial |
| `marca` | VARCHAR | 40 | NOT NULL, DEFAULT 'Ricoh' | Texto |
| `precio` | DECIMAL | 12,2 | NOT NULL, CHECK (precio > 0) | Pesos colombianos sin IVA |
| `descripcion` | TEXT | n/a | — | Texto libre |
| `disponibilidad` | VARCHAR | 10 | NOT NULL, DEFAULT 'normal', CHECK (disponibilidad IN ('normal','pocas','agotado')) | normal · pocas · agotado |
| `ficha_tecnica_url` | VARCHAR | 255 | — | Ruta del PDF; nula si no aplica |
| `activo` | INTEGER | 1 | NOT NULL, DEFAULT 1, CHECK (activo IN (0,1)) | 0 = retirado del catálogo |

## `variante_producto`

Variantes de un producto (entidad débil)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_producto` | INTEGER | n/a | PK, FK → producto.id_producto, ON DELETE CASCADE | Producto dueño |
| `num_variante` | INTEGER | n/a | PK, CHECK (num_variante > 0) | 1, 2, 3… dentro del producto |
| `descripcion` | VARCHAR | 80 | NOT NULL | Ej. 300 g, premium |
| `precio_adicional` | DECIMAL | 12,2 | NOT NULL, DEFAULT 0, CHECK (precio_adicional >= 0) | COP que se suman al precio base |

## `compatibilidad_producto`

Qué insumo o repuesto es compatible con qué equipo (N:M recursiva)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_producto` | INTEGER | n/a | PK, FK → producto.id_producto, ON DELETE CASCADE | Insumo o repuesto |
| `id_producto_compatible` | INTEGER | n/a | PK, FK → producto.id_producto, ON DELETE CASCADE, CHECK (id_producto <> id_producto_compatible) | Equipo con el que funciona |

## `carrito`

Carrito guardado de un cliente registrado (1:1 con usuario)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_carrito` | INTEGER | n/a | PK | Entero positivo |
| `id_usuario` | INTEGER | n/a | NOT NULL, UNIQUE, FK → usuario.id_usuario, ON DELETE CASCADE | Un carrito por cliente |
| `creado_en` | DATETIME | n/a | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de creación |

## `item_carrito`

Productos dentro de un carrito (resuelve N:M carrito-producto)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_carrito` | INTEGER | n/a | PK, FK → carrito.id_carrito, ON DELETE CASCADE | Carrito existente |
| `id_producto` | INTEGER | n/a | PK, FK → producto.id_producto, ON DELETE CASCADE | Producto existente |
| `cantidad` | INTEGER | n/a | NOT NULL, CHECK (cantidad > 0) | Unidades |

## `ciudad`

Ciudades de envío (sale de la 3FN: ciudad → departamento)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_ciudad` | INTEGER | n/a | PK | Entero positivo |
| `nombre` | VARCHAR | 60 | NOT NULL, UNIQUE (nombre, departamento) | Ej. Neiva |
| `departamento` | VARCHAR | 60 | NOT NULL | Ej. Huila |

## `pedido`

Pedidos de compra (de cliente registrado o de invitado)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_pedido` | INTEGER | n/a | PK | Entero positivo |
| `codigo` | VARCHAR | 20 | NOT NULL, UNIQUE | Formato SYP-AAAA-NNNNN |
| `id_usuario` | INTEGER | n/a | FK → usuario.id_usuario, ON DELETE SET NULL | Nulo si compró como invitado |
| `nombre_contacto` | VARCHAR | 80 | NOT NULL | Quien recibe el envío |
| `telefono_contacto` | VARCHAR | 15 | NOT NULL | Teléfono de quien recibe |
| `correo_contacto` | VARCHAR | 120 | NOT NULL | Correo para la confirmación |
| `direccion_envio` | VARCHAR | 150 | NOT NULL | Dirección de entrega |
| `id_ciudad` | INTEGER | n/a | NOT NULL, FK → ciudad.id_ciudad, ON DELETE RESTRICT | Ciudad existente |
| `fecha` | DATETIME | n/a | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha del pedido |
| `estado` | VARCHAR | 12 | NOT NULL, DEFAULT 'pendiente', CHECK (estado IN ('pendiente','confirmado','en_camino','entregado','cancelado')) | Ciclo de vida del pedido |

## `detalle_pedido`

Líneas de cada pedido (resuelve N:M pedido-producto)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_pedido` | INTEGER | n/a | PK, FK → pedido.id_pedido, ON DELETE CASCADE | Pedido existente |
| `id_producto` | INTEGER | n/a | PK, FK → producto.id_producto, ON DELETE RESTRICT | Producto vendido (no se borra si tiene ventas) |
| `cantidad` | INTEGER | n/a | NOT NULL, CHECK (cantidad > 0) | Unidades |
| `precio_unitario` | DECIMAL | 12,2 | NOT NULL, CHECK (precio_unitario > 0) | Precio congelado al momento de la compra |

## `pago`

Pago de un pedido (1:1 con pedido)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_pago` | INTEGER | n/a | PK | Entero positivo |
| `id_pedido` | INTEGER | n/a | NOT NULL, UNIQUE, FK → pedido.id_pedido, ON DELETE CASCADE | Un pago por pedido |
| `metodo` | VARCHAR | 15 | NOT NULL, CHECK (metodo IN ('transferencia','contraentrega','en_linea')) | Método elegido |
| `estado` | VARCHAR | 10 | NOT NULL, DEFAULT 'pendiente', CHECK (estado IN ('pendiente','aprobado','rechazado')) | Estado del cobro |
| `valor` | DECIMAL | 12,2 | NOT NULL, CHECK (valor > 0) | COP con IVA |
| `referencia` | VARCHAR | 60 | — | Referencia de la pasarela o del comprobante; nunca datos de tarjeta |
| `fecha` | DATETIME | n/a | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha del registro del pago |

## `cotizacion`

Cotizaciones formales con IVA

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_cotizacion` | INTEGER | n/a | PK | Entero positivo |
| `codigo` | VARCHAR | 20 | NOT NULL, UNIQUE | Formato COT-AAAA-NNNNN |
| `id_usuario` | INTEGER | n/a | FK → usuario.id_usuario, ON DELETE SET NULL | Nulo si la pidió un visitante |
| `nombre_contacto` | VARCHAR | 80 | NOT NULL | A quién se dirige |
| `correo_contacto` | VARCHAR | 120 | NOT NULL | Correo de envío |
| `fecha` | DATE | n/a | NOT NULL, DEFAULT CURRENT_DATE | Fecha de emisión |
| `notas` | TEXT | n/a | — | Observaciones |

## `detalle_cotizacion`

Líneas de cada cotización (resuelve N:M cotización-producto)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_cotizacion` | INTEGER | n/a | PK, FK → cotizacion.id_cotizacion, ON DELETE CASCADE | Cotización existente |
| `id_producto` | INTEGER | n/a | PK, FK → producto.id_producto, ON DELETE RESTRICT | Producto cotizado |
| `cantidad` | INTEGER | n/a | NOT NULL, CHECK (cantidad > 0) | Unidades |
| `precio_unitario` | DECIMAL | 12,2 | NOT NULL, CHECK (precio_unitario > 0) | Precio ofrecido sin IVA |

## `solicitud_servicio`

Solicitudes de servicio técnico

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_solicitud` | INTEGER | n/a | PK | Entero positivo |
| `codigo` | VARCHAR | 20 | NOT NULL, UNIQUE | Formato ST-AAAA-NNNN |
| `id_usuario` | INTEGER | n/a | FK → usuario.id_usuario, ON DELETE SET NULL | Solicitante con cuenta; nulo si es visitante |
| `id_tecnico` | INTEGER | n/a | FK → usuario.id_usuario, ON DELETE SET NULL | Técnico asignado; nulo si aún no |
| `nombre_contacto` | VARCHAR | 80 | NOT NULL | Quien atiende la visita |
| `telefono_contacto` | VARCHAR | 15 | NOT NULL | Teléfono de contacto |
| `correo_contacto` | VARCHAR | 120 | NOT NULL | Correo de contacto |
| `equipo` | VARCHAR | 80 | NOT NULL | Marca y modelo |
| `tipo_servicio` | VARCHAR | 12 | NOT NULL, CHECK (tipo_servicio IN ('preventivo','correctivo','diagnostico')) | Tipo de servicio |
| `fecha_deseada` | DATE | n/a | NOT NULL | No pasada ni domingo (regla en la aplicación) |
| `franja` | VARCHAR | 6 | NOT NULL, CHECK (franja IN ('manana','tarde')) | Franja horaria |
| `descripcion` | TEXT | n/a | NOT NULL | Problema reportado |
| `estado` | VARCHAR | 10 | NOT NULL, DEFAULT 'pendiente', CHECK (estado IN ('pendiente','en_proceso','resuelta','cancelada')) | Estado de atención |
| `creado_en` | DATETIME | n/a | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de registro |

## `reporte_contador`

Lecturas mensuales de contadores de equipos en renting

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_reporte` | INTEGER | n/a | PK | Entero positivo |
| `id_usuario` | INTEGER | n/a | NOT NULL, FK → usuario.id_usuario, ON DELETE CASCADE, UNIQUE (id_usuario, modelo_equipo, mes) | Cliente de renting |
| `modelo_equipo` | VARCHAR | 60 | NOT NULL | Modelo del equipo |
| `mes` | CHAR | 7 | NOT NULL, CHECK (mes GLOB '[0-9][0-9][0-9][0-9]-[01][0-9]') | AAAA-MM |
| `contador_mono` | INTEGER | n/a | NOT NULL, CHECK (contador_mono >= 0) | Copias acumuladas en negro |
| `contador_color` | INTEGER | n/a | NOT NULL, DEFAULT 0, CHECK (contador_color >= 0) | Copias acumuladas a color |

## `mensaje_contacto`

Mensajes del formulario de contacto

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_mensaje` | INTEGER | n/a | PK | Entero positivo |
| `nombre` | VARCHAR | 80 | NOT NULL | Remitente |
| `correo` | VARCHAR | 120 | NOT NULL | Correo del remitente |
| `telefono` | VARCHAR | 15 | — | Opcional |
| `asunto` | VARCHAR | 120 | NOT NULL | Asunto |
| `mensaje` | TEXT | n/a | NOT NULL | Contenido |
| `leido` | INTEGER | 1 | NOT NULL, DEFAULT 0, CHECK (leido IN (0,1)) | 0 no leído · 1 leído |
| `creado_en` | DATETIME | n/a | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de recepción |

## `informacion_empresa`

Datos institucionales editables (registro único)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_info` | INTEGER | n/a | PK, CHECK (id_info = 1) | Siempre 1 (un solo registro) |
| `direccion` | VARCHAR | 150 | NOT NULL | Dirección del local |
| `horario` | VARCHAR | 120 | NOT NULL | Horario de atención |
| `telefono` | VARCHAR | 15 | NOT NULL | Teléfono fijo o móvil |
| `whatsapp` | VARCHAR | 15 | NOT NULL | Número para el enlace wa.me |
| `historia` | TEXT | n/a | — | Texto de la página Nosotros |

## `red_social`

Redes sociales de la empresa (atributo multivaluado en tabla aparte)

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_red` | INTEGER | n/a | PK | Entero positivo |
| `id_info` | INTEGER | n/a | NOT NULL, FK → informacion_empresa.id_info, ON DELETE CASCADE | Siempre 1 |
| `nombre` | VARCHAR | 30 | NOT NULL | Facebook, Instagram… |
| `url` | VARCHAR | 255 | NOT NULL, UNIQUE | Enlace público |
