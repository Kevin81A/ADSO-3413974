# B6 · Políticas de seguridad de los datos

Datos personales que guarda SyP Web: nombre, correo, teléfono, NIT, dirección de envío (`usuario`, `pedido`, `cotizacion`, `solicitud_servicio`, `mensaje_contacto`). **No** se guardan datos de tarjeta: los procesa la pasarela.

## Políticas por principio (medidas concretas sobre las tablas del caso)

| # | Principio | Política | Medida concreta en SyP Web |
|---|---|---|---|
| P1 | Integridad | Reglas de negocio en la base, no solo en la pantalla | 26 `CHECK` (precio > 0, cantidad > 0, estados y roles válidos, mes AAAA-MM), `UNIQUE` en `usuario.correo`, `pedido.codigo`, `pago.id_pedido`; ver [script](sql/B5-crear-modelo.sql) |
| P2 | Integridad | Integridad referencial con acciones explícitas | 20 FK con `ON DELETE`: `RESTRICT` en `detalle_pedido.id_producto` (no se borra un producto vendido: se retira con `activo = 0`), `CASCADE` en detalles e ítems, `SET NULL` en `pedido.id_usuario` (el pedido se conserva si se elimina la cuenta) |
| P3 | Integridad | Precio congelado y trazabilidad de cambios de estado | `detalle_pedido.precio_unitario` guarda el precio de la compra; cada cambio de `pedido.estado` y `solicitud_servicio.estado` se registra en el log de la aplicación con usuario, fecha y estado anterior |
| P4 | Confidencialidad | Contraseñas con **hash y sal** (no «cifradas») | `usuario.contrasena_hash` = bcrypt con sal aleatoria por usuario y factor de costo 12; la contraseña nunca se guarda ni se registra en logs |
| P5 | Confidencialidad | Datos en tránsito por **TLS** | Todo el tráfico navegador ↔ API por HTTPS (TLS 1.2 o superior) con HSTS; correo saliente por SMTP con STARTTLS; la base no tiene puerto expuesto (nodo de datos solo montado en el servidor) |
| P6 | Confidencialidad | Mínimo privilegio por rol | Matriz de abajo, aplicada en el middleware de la API (SQLite no maneja usuarios ni `GRANT`; si se migra a PostgreSQL, cada rol será un rol de base de datos con esos mismos permisos). El token JWT va en cookie HttpOnly y Secure |
| P7 | Confidencialidad | **Tratamiento de datos personales** (Ley 1581 de 2012) | Finalidad declarada en la política de privacidad: gestionar pedidos, cotizaciones y servicio técnico, y contactar al titular. Casilla de **autorización previa** obligatoria en registro, checkout, cotización, servicio técnico y contacto. El titular puede consultar, actualizar o pedir la supresión de sus datos por el canal de contacto; la supresión anonimiza `nombre_contacto`, `telefono_contacto` y `correo_contacto` en sus pedidos |
| P8 | Disponibilidad | **Respaldo** con frecuencia definida | Copia diaria a las 02:00 del archivo `syp.db` (con `sqlite3 .backup`, consistente aunque haya escrituras) a un almacenamiento en otra región, cifrada y con retención de 30 días. *Propuesta: todavía no está automatizada porque el backend no está publicado.* |
| P9 | Disponibilidad | **Prueba de restauración** | Una vez al mes se restaura la última copia en un entorno de prueba, se ejecuta `PRAGMA integrity_check` y se compara el número de pedidos; queda acta con fecha, responsable y resultado. Objetivos: RPO 24 h, RTO 4 h |
| P10 | Disponibilidad | Servicio vigilado y límite de abuso | Health check `/api/v1/health` con reinicio automático; límite de peticiones en inicio de sesión (5 intentos/min) y en solicitudes de servicio (5/hora) para evitar saturación |

## Matriz de roles contra tablas

S = SELECT · I = INSERT · U = UPDATE · D = DELETE · «propias» = solo las filas del usuario autenticado · — = sin acceso

| Tabla | Visitante (sin sesión) | Cliente | Técnico | Administrador |
|---|---|---|---|---|
| `usuario` | I (registro) | S, U (solo su fila) | S (solo su fila) | S, U (desactivar) |
| `categoria` | S | S | S | S, I, U, D |
| `producto`, `variante_producto`, `compatibilidad_producto` | S (activos) | S (activos) | S | S, I, U (retiro con `activo = 0`) |
| `carrito`, `item_carrito` | — | S, I, U, D (propias) | — | — |
| `ciudad` | S | S | S | S, I, U |
| `pedido`, `detalle_pedido` | I (compra como invitado) | S (propias), I | — | S, U (estado) |
| `pago` | I | S (propias), I | — | S, U (estado) |
| `cotizacion`, `detalle_cotizacion` | I | S (propias), I | — | S |
| `solicitud_servicio` | I | S (propias), I | S, U (asignadas: estado) | S, U (asignar técnico) |
| `reporte_contador` | — | S, I (propias) | S | S |
| `mensaje_contacto` | I | I | — | S, U (`leido`) |
| `informacion_empresa`, `red_social` | S | S | S | S, U |

Ningún rol borra pedidos, pagos ni solicitudes: se cambian de estado (por ejemplo, `cancelado`), para conservar la trazabilidad.
