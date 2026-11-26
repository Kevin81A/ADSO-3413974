# 7. Matriz de trazabilidad requisito → artefactos (Anexo C)

Abreviaturas: **Act** = diagrama de actividades · **Pl** = plantilla extendida · **—** = no aplica (solo se exigen actividades, plantilla y pantalla para los casos críticos CU-06, CU-15 y CU-18).

| Requisito | Caso de uso | Act | Pl | Clase de dominio | Entidad del MER | Pantalla |
|---|---|---|---|---|---|---|
| RF-01 | CU-01 | — | — | Producto, Categoría | PRODUCTO, CATEGORIA | — |
| RF-02.1 | CU-01 | — | — | Producto | PRODUCTO | — |
| RF-02.2 | CU-01 | — | — | Categoría | CATEGORIA | — |
| RF-02.3 | CU-01 | — | — | Producto | PRODUCTO | — |
| RF-02.4 | CU-01 | — | — | Producto | PRODUCTO | — |
| RF-03.1 | CU-02 | — | — | Producto | PRODUCTO | — |
| RF-03.2 | CU-02 | — | — | Variante | VARIANTE_PRODUCTO | — |
| RF-03.3 | CU-02 | — | — | Producto (disponibilidad) | PRODUCTO | — |
| RF-03.4 | CU-04 | — | — | Carrito, ÍtemCarrito | CARRITO, ITEM_CARRITO | — |
| RF-03.5 | CU-03 | — | — | Producto (ficha técnica) | PRODUCTO | — |
| RF-04.1 | CU-04 | — | — | ÍtemCarrito | ITEM_CARRITO | — |
| RF-04.2 | CU-05 | CU-06 | CU-06 paso 5 | LíneaPedido, Pedido | DETALLE_PEDIDO, PEDIDO | P-01 |
| RF-04.3 | CU-04 | — | — | Carrito | CARRITO | — |
| RF-04.4 | CU-04 | — | — | ÍtemCarrito | ITEM_CARRITO | — |
| RF-05.1 | CU-06 | CU-06 | CU-06 pasos 2-4 | Pedido | PEDIDO | P-01 |
| RF-05.2 | CU-05, CU-06 | CU-06 | CU-06 paso 5 | Pedido, LíneaPedido | PEDIDO, DETALLE_PEDIDO | P-01 |
| RF-05.3 | CU-06, CU-07 | CU-06 | CU-06 paso 6, 6a, 6b | Pago | PAGO | P-01 |
| RF-05.4 | CU-08 | CU-06 | CU-06 pasos 8-10 | Pedido (número) | PEDIDO | P-01 |
| RF-06.1 | CU-09 | — | — | Cliente | USUARIO | — |
| RF-06.2 | CU-10 | — | — | Usuario | USUARIO | — |
| RF-06.3 | CU-11 | — | — | Usuario | USUARIO | — |
| RF-06.4 | CU-12 | — | — | Cliente, Pedido | USUARIO, PEDIDO | — |
| RF-06.5 | CU-06 | CU-06 | CU-06 (actor invitado) | Pedido (Cliente 0..1) | PEDIDO (USUARIO 0..1) | P-01 |
| RF-07 | CU-13 | — | — | InformaciónEmpresa | INFORMACION_EMPRESA | — |
| RF-08.1 | CU-13 | — | — | InformaciónEmpresa | INFORMACION_EMPRESA | — |
| RF-08.2 | CU-13 | — | — | InformaciónEmpresa | INFORMACION_EMPRESA | — |
| RF-08.3 | CU-13 | — | — | InformaciónEmpresa | INFORMACION_EMPRESA | — |
| RF-08.4 | CU-13 | — | — | InformaciónEmpresa | INFORMACION_EMPRESA | — |
| RF-08.5 | CU-14 | — | — | MensajeContacto | MENSAJE_CONTACTO | — |
| RF-09.1 | CU-15 | CU-15 | CU-15 | SolicitudServicio | SOLICITUD_SERVICIO | P-02 |
| RF-09.2 | CU-15 | CU-15 | CU-15 paso 3 | SolicitudServicio | SOLICITUD_SERVICIO | P-02 |
| RF-09.3 | CU-21 | CU-15 (aviso) | — | SolicitudServicio (estado), Técnico | SOLICITUD_SERVICIO, USUARIO | — |
| RF-10.1 | CU-10 | — | CU-18 (precondición) | Administrador | USUARIO (rol) | P-03 |
| RF-10.2 | CU-18 | — | CU-18 | Producto | PRODUCTO | P-03 |
| RF-10.3 | CU-19 | — | — | Categoría | CATEGORIA | — |
| RF-10.4 | CU-20 | — | — | Pedido | PEDIDO | — |
| RF-10.5 | CU-21 | — | — | SolicitudServicio | SOLICITUD_SERVICIO | — |
| RF-10.6 | CU-22 | — | — | MensajeContacto | MENSAJE_CONTACTO | — |
| RF-10.7 | CU-23 | — | — | Pedido, LíneaPedido | PEDIDO, DETALLE_PEDIDO | — |
| RF-11 | — (requisito de interfaz) | — | — | — | — | Cabecera y pie en P-01, P-02, P-03 |
| RF-12 | CU-16 | — | — | Cotización | COTIZACION, DETALLE_COTIZACION | — |
| RF-13 | CU-17 | — | — | ReporteContador | REPORTE_CONTADOR | — |

## Resultado

- RF trazados completos hasta **caso de uso, clase de dominio y entidad**: **41 de 42 = 97,6 %** (≥ 90 %).
- RF-11 no llega a clase ni entidad porque es un requisito de interfaz (no guarda datos); se verifica en el prototipo.
- Los RF de los **casos críticos** (CU-06, CU-15, CU-18) tienen además diagrama de actividades (o plantilla) y pantalla.
