# B3 · Normalización paso a paso (0FN → 3FN)

Las dos tablas de partida son **reales del proyecto del equipo** (`fastapi_backend/database.py`), no ejemplos inventados: `orders` y `products`.

---

## Tabla 1 · `orders` (pedidos) → llave compuesta y dependencia parcial (2FN)

**0FN (como está en el sistema del equipo):**

`orders(id, order_code, client_id, client_name, client_email, client_phone, delivery_address, delivery_city, items_json, subtotal, iva, total, payment_method, status, created_at)`

`items_json` guarda en **una sola celda** la lista de productos: `[{"product_id": "p2", "name": "Tóner MP", "category": "Tintas", "qty": 2, "price": 90000}, …]`. Además `delivery_city` trae «Neiva, Huila» (ciudad y departamento juntos).

**Dependencias funcionales (DF) identificadas:**

- `id_pedido → codigo, id_usuario, nombre_contacto, telefono_contacto, correo_contacto, direccion_envio, ciudad, metodo_pago, estado, fecha`
- `(id_pedido, id_producto) → cantidad, precio_unitario`
- `id_producto → nombre_producto, categoria`
- `id_usuario → nombre_usuario, correo_usuario` (los datos de la cuenta)
- `ciudad → departamento`
- `id_pedido → subtotal, iva, total` **son derivados**: `subtotal = Σ cantidad × precio_unitario`

| Paso | Violación encontrada | Qué se hace | Resultado (estado después) |
|---|---|---|---|
| **1FN** | `items_json` no es atómico (grupo repetitivo); `delivery_city` mezcla dos datos | Se saca cada producto del pedido a una fila; ciudad y departamento en columnas separadas | `pedido_1fn(id_pedido, id_producto, codigo, id_usuario, nombre_usuario, correo_usuario, nombre_contacto, telefono_contacto, correo_contacto, direccion_envio, ciudad, departamento, metodo_pago, estado, fecha, nombre_producto, categoria, cantidad, precio_unitario)` con **PK compuesta (`id_pedido`, `id_producto`)** |
| **2FN** (dependencia parcial) | Con la PK compuesta, `nombre_producto` y `categoria` dependen **solo de `id_producto`**; `codigo`, `direccion_envio`, `estado`, etc. dependen **solo de `id_pedido`** | Se separa cada grupo con la parte de la llave de la que depende | `pedido(id_pedido, codigo, id_usuario, nombre_usuario, correo_usuario, nombre_contacto, …, ciudad, departamento, metodo_pago, estado, fecha)` · `producto(id_producto, nombre, categoria)` · **`detalle_pedido(id_pedido, id_producto, cantidad, precio_unitario)`** |
| **3FN** (dependencia transitiva) | En `pedido`: `id_pedido → id_usuario → nombre_usuario, correo_usuario` y `id_pedido → ciudad → departamento`. `metodo_pago` describe el pago, no el pedido. `subtotal`, `iva`, `total` son derivados | Los datos de la cuenta quedan solo en `usuario`; ciudad pasa a su tabla; el pago a su tabla 1:1; los totales a una vista | `pedido(id_pedido, codigo, id_usuario FK, nombre_contacto, telefono_contacto, correo_contacto, direccion_envio, id_ciudad FK, fecha, estado)` · `usuario(id_usuario, nombre, correo, …)` · `ciudad(id_ciudad, nombre, departamento)` · `pago(id_pago, id_pedido FK UNIQUE, metodo, estado, valor, …)` · vista `v_total_pedido` |

**Nota sobre `nombre_contacto`, `telefono_contacto` y `correo_contacto`:** **no** son dependencia transitiva. Describen a quien recibe **este** envío (puede ser distinto del dueño de la cuenta, y en compra como invitado no hay cuenta): dependen directamente de `id_pedido`.

**`precio_unitario` en `detalle_pedido`:** no viola 2FN aunque el producto tenga precio. Depende del par (pedido, producto) porque guarda el precio **al momento de la compra**; si después cambia el precio del producto, el pedido viejo no debe cambiar.

---

## Tabla 2 · `products` (productos) → dependencia transitiva (3FN) y multivaluado (1FN)

**0FN (la lista plana de productos que usa el catálogo):** combina la tabla `products` del backend con los datos del catálogo del frontend (`js/products.js`), donde cada producto repite el nombre de su categoría:

`producto_0fn(id, name, category_slug, category, brand, price, stock_status, compatible_ids, …)`

`compatible_ids` (columna real de `products`) guarda varios valores en un texto: los equipos con los que funciona un tóner o repuesto. `category` repite el nombre de la categoría en cada producto (por ejemplo «Unidad de Fusión» en tres productos seguidos).

**Dependencias funcionales:**

- `id_producto → nombre, marca, precio, disponibilidad, id_categoria`
- `id_categoria → nombre_categoria, orden`
- `(id_producto, id_producto_compatible) →` (sin atributos: la relación es el dato)

| Paso | Violación encontrada | Qué se hace | Resultado (estado después) |
|---|---|---|---|
| **1FN** | `compatible_ids` no es atómico | Una fila por cada par producto–equipo compatible en una tabla aparte | `producto(id_producto, nombre, marca, precio, disponibilidad, id_categoria, nombre_categoria, orden)` · `compatibilidad_producto(id_producto, id_producto_compatible)` con PK compuesta |
| **2FN** | `producto` tiene PK simple: no puede haber dependencia parcial. `compatibilidad_producto` no tiene atributos fuera de la PK | Sin cambios | Igual que en 1FN |
| **3FN** (dependencia transitiva) | `id_producto → id_categoria → nombre_categoria, orden` | Los datos de la categoría pasan a su tabla y en `producto` queda solo la FK | `producto(id_producto, id_categoria FK, nombre, marca, precio, disponibilidad, ficha_tecnica_url, activo)` · `categoria(id_categoria, nombre, orden, id_categoria_padre)` |

---

## Estado final

Todas las tablas del [modelo lógico](B2-modelo-logico.md) quedan en 3FN: cada atributo que no es llave depende de la llave completa y solo de ella.

**Desnormalización declarada:** ninguna en las tablas. El total del pedido **no** se guarda (sería un dato derivado que puede quedar desactualizado); se calcula en la vista `v_total_pedido`. Si en el futuro el reporte de ventas (RF-10.7) se vuelve lento, se evaluaría guardar el total con un disparador, y se documentaría aquí.
