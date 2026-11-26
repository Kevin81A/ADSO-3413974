# A7 · Matriz de trazabilidad (análisis → diseño)

Requisitos del SRS v2.1 (13 requisitos funcionales con sus subrequisitos). Las tablas son las del modelo lógico del [producto 2](../G2-P2-fotocopiadora-syp/B2-modelo-logico.md).

## Hacia adelante (requisito → diseño)

| Requisito | Clase(s) | Tabla(s) | Componente(s) | Decisión o patrón |
|---|---|---|---|---|
| RF-01 Página de inicio | Producto, Categoria | `producto`, `categoria` | Frontend web, Catálogo | Caché de estáticos (RNF-03) |
| RF-02 Catálogo, filtro y búsqueda | Producto, Categoria | `producto`, `categoria` | Catálogo | Índice `ix_producto_categoria` |
| RF-03 Ficha de producto, variantes, ficha técnica | Producto, Variante, Disponibilidad | `producto`, `variante_producto` | Catálogo | Composición Producto ◆— Variante |
| RF-04 Carrito | Carrito, ItemCarrito | `carrito`, `item_carrito` | Pedidos, Frontend web | Composición Carrito ◆— ItemCarrito |
| RF-05 Checkout, pago, número y confirmación | ServicioPedidos, Pedido, LineaPedido, MetodoPago (+3), ResultadoPago, Notificador | `pedido`, `detalle_pedido`, `pago` | Pedidos, Pagos, Notificaciones | **Fachada** + **Estrategia** |
| RF-06 Cuentas e historial | Usuario, Cliente, RepositorioPedidos | `usuario`, `pedido` | Autenticación, Pedidos | Hash con sal y JWT (RNF-05) |
| RF-07 Página «Nosotros» | InformacionEmpresa | `informacion_empresa` | Frontend web | Contenido editable (RNF-07) |
| RF-08 Contacto (datos, mapa, WhatsApp, formulario) | InformacionEmpresa, MensajeContacto | `informacion_empresa`, `mensaje_contacto` | Frontend web, Servicio técnico | — |
| RF-09 Servicio técnico con estados | SolicitudServicio, Tecnico | `solicitud_servicio` | Servicio técnico, Notificaciones | Límite de peticiones en la API |
| RF-10 Panel administrativo | Administrador, Producto, Categoria, Pedido, SolicitudServicio, MensajeContacto | todas las de gestión | Autenticación (rol), Catálogo, Pedidos, Servicio técnico | Autorización por rol en el middleware |
| RF-11 Navegación global | — (interfaz) | — | Frontend web | — |
| RF-12 Cotización | Cotizacion, LineaPedido | `cotizacion`, `detalle_cotizacion` | Pedidos | — |
| RF-13 Contadores de renting | ReporteContador, Cliente | `reporte_contador` | Servicio técnico | — |
| RNF-05 Seguridad | Usuario (`hashContrasena`) | `usuario` | Autenticación | Middleware JWT, bcrypt, HTTPS |
| RNF-11 Respaldo | ConexionBD | todas | Persistencia | **Singleton**; copia diaria a otro nodo |

**Cobertura hacia adelante:** 13 de 13 RF (100 %). RF-11 es de interfaz y se atiende en el componente Frontend web.

## Hacia atrás (clase → requisito)

| Clase | Requisito | Clase | Requisito |
|---|---|---|---|
| Usuario | RF-06 | ServicioPedidos | RF-05, RF-10.4 |
| Cliente | RF-06, RF-13 | RepositorioPedidos | RF-05, RF-06.4 |
| Administrador | RF-10.1 | MetodoPago | RF-05.3 |
| Tecnico | RF-09.3 | PagoTransferencia | RF-05.3 |
| Categoria | RF-02.2, RF-10.3 | PagoContraentrega | RF-05.3 |
| Producto | RF-02, RF-03, RF-10.2 | PagoEnLinea | RF-05.3 |
| Variante | RF-03.2 | ResultadoPago | RF-05.3 |
| Carrito | RF-04 | Notificador | RF-05.4, RF-06.3 |
| ItemCarrito | RF-04 | NotificadorCorreo | RF-05.4, RF-06.3 |
| Pedido | RF-05, RF-06.4 | ConexionBD | RNF-11, RNF-05 |
| LineaPedido | RF-05.2, RF-12 | Cotizacion | RF-12 |
| SolicitudServicio | RF-09, RF-10.5 | ReporteContador | RF-13 |
| EstadoPedido | RF-10.4 | MensajeContacto | RF-08.5, RF-10.6 |
| Disponibilidad | RF-03.3 | InformacionEmpresa | RF-07, RF-08.1-08.4 |

**Ninguna clase queda sin requisito** (28 de 28).
