# Preguntas Abiertas para el Negocio — Orderflow Engine

**Prueba técnica:** Tech Lead 1 · Marketplace B2B multi-tenant
**Instructor:** Jesús Ariel
**Fecha:** 17 de octubre de 2026

---

## Criterio de selección

Ninguna de estas preguntas ya tiene respuesta en el enunciado (`assignment/Prueba_Tecnica_Tech_Lead_1.pdf`) ni en la documentación (`spec/`, `handoff/`, `deliverables/`). Antes de redactar cada una, revisé que el tema **no estuviera resuelto** en el SPEC, el modelo de datos, el contrato de la API, el plan ni los supuestos `A-01` a `A-10`.

Cada pregunta tiene esta estructura:
- **Qué dice el enunciado**: la parte del PDF de donde sale la pregunta.
- **Qué dice la documentación**: qué decidió la documentación y dónde quedó el hueco.
- **Por qué importa**: el riesgo concreto si nadie la responde.
- **Pregunta**: tal como se le haría al dueño del producto o al instructor.

---

## Pregunta 1 — ¿El impuesto entra en el "sellado" de la cotización?

**Qué dice el enunciado:**
"El total cotizado y el total confirmado deben ser idénticos [...] aunque **las palancas o los precios** cambien entre un momento y otro." El enunciado nombra palancas y precios. **No nombra los impuestos.**

**Qué dice la documentación:**
`quote_lines.tax_rate` guarda la tasa vigente al momento de cotizar y se respeta al confirmar (`data-model.md` §4, `SPEC.md` §6). Es decir, la documentación **extendió el sellado a la tasa de impuesto**, algo que el enunciado no pide. No hay una regla para el caso en que la tasa cambie por ley mientras la cotización sigue abierta.

**Por qué importa:**
El precio es un acuerdo comercial; el impuesto es una obligación legal. Imaginemos una cotización creada a las 23:55 del 31 de diciembre y confirmada a las 00:05 del 1 de enero, justo cuando entra en vigor una nueva tasa de IVA. El sistema confirmaría el pedido con la tasa anterior, y la factura electrónica (que la documentación misma usa para justificar el redondeo por línea, `SPEC.md` §4) saldría con un impuesto que ya no es válido.

**Pregunta:**
> Si la tasa de impuesto de un SKU cambia por disposición legal mientras una cotización sigue abierta, ¿se debe respetar la tasa sellada en la cotización o se debe invalidar la cotización y obligar al tendero a cotizar de nuevo? ¿Qué fecha manda fiscalmente: la de la cotización o la de la confirmación?

---

## Pregunta 2 — ¿"Confirmado" significa registrado en nuestro sistema o aceptado por el distribuidor?

**Qué dice el enunciado:**
"Si la respuesta es 201 con número de orden, la orden existe y es consultable." También pide garantizar que la publicación al ERP "no se pierda ni se duplique, y qué pasa si el sistema externo está caído".

**Qué dice la documentación:**
Si el ERP responde con un error no reintentable (4xx) o se agotan los reintentos, el evento queda en estado `DEAD` y lo cuenta la métrica `outbox_dead` (`SPEC.md` §7.4, `AC-35`). Mientras tanto, la orden queda confirmada, el cupo queda consumido y la cancelación y la liberación de crédito están **fuera de alcance** (`A-09`). La documentación **no define** qué estado ve el tendero ni quién resuelve una orden que el ERP rechazó.

**Por qué importa:**
Es una variante del mismo defecto que motivó el ejercicio. Antes, la orden "desaparecía" del historial. Ahora la orden aparece en el historial, pero el distribuidor nunca la recibe: el tendero espera un despacho que no va a llegar, y su cupo sigue consumido. El procedimiento de reencolar eventos (`plan.md`, `RISK-02`) sirve cuando el ERP estuvo caído, pero no cuando el ERP rechaza la orden.

**Pregunta:**
> Cuando el ERP rechaza definitivamente un pedido ya confirmado (por ejemplo, un cliente bloqueado en el ERP o un SKU descontinuado), ¿qué estado debe ver el tendero en "Mis pedidos", quién es el responsable de resolverlo y en cuánto tiempo, y se le debe devolver el cupo consumido?

---

## Pregunta 3 — ¿Cuál es la fuente de verdad del cupo de crédito y cómo se libera?

**Qué dice el enunciado:**
"Un pedido a crédito solo procede si el total cabe en el cupo, y **el cupo debe reflejar el consumo**."

**Qué dice la documentación:**
El cupo vive en la tabla local `credit_accounts` (`credit_limit`, `consumed`). Se carga con datos de semilla y **solo aumenta** con cada pedido (`credit_ledger` es append-only, `data-model.md` §3). La liberación de crédito está fuera de alcance (`A-09`). En ningún documento se dice de dónde sale `credit_limit` en producción ni cómo se registran los pagos del tendero.

**Por qué importa:**
En la distribución B2B, el cupo suele administrarlo el ERP o el área de cartera, no la plataforma de pedidos. Si el cupo solo crece en consumo y nunca se libera, cada tendero a crédito va a quedar bloqueado tarde o temprano. Si la fuente de verdad es el ERP, la copia local se va a desalinear sin un mecanismo de sincronización, y la protección de concurrencia (`CHECK consumed <= credit_limit`) estaría protegiendo un número desactualizado.

**Pregunta:**
> ¿Qué sistema es el dueño del cupo de crédito en producción (la plataforma, el ERP o cartera)? ¿Cómo y con qué frecuencia se reflejan los pagos del tendero y los cambios de su límite, y qué hacemos si el valor local no coincide con el del sistema dueño?

---

## Pregunta 4 — ¿La confirmación debe validar la disponibilidad de inventario?

**Qué dice el enunciado:**
El flujo es "catálogo → carrito → checkout (cotización) → confirmación → historial". El enunciado no menciona inventario, pero sí exige que un 201 signifique que la orden existe.

**Qué dice la documentación:**
No hay ninguna mención de inventario, stock o disponibilidad en todo `spec/` (cero coincidencias). Tampoco hay un supuestso que lo deje explícitamente fuera de alcance, como sí se hizo con la autenticación (`A-06`) o la cancelación (`A-09`).

**Por qué importa:**
El sistema puede confirmar con 201 un pedido de productos que el distribuidor no tiene. Esto afecta también a los **obsequios**: la regla `BR-04` agrega unidades gratis que salen de bodega y tienen valor de referencia, pero nada garantiza que existan. Además, si la validación del inventario la hace el ERP después de confirmar, este caso termina en el escenario de la pregunta 2 (pedido confirmado y luego rechazado).

**Pregunta:**
> ¿La disponibilidad de inventario es responsabilidad de este motor (reservar al confirmar, dentro de la misma transacción) o del ERP después de la confirmación? Si es del ERP, ¿cómo se le comunica al tendero que un producto o un obsequio de un pedido ya confirmado no se puede despachar?

---

## Pregunta 5 — ¿Cómo se comporta un mismo tendero cuando compra a varias marcas?

**Qué dice el enunciado:**
"La app corre en varios países [...] y **varias marcas comerciales**, sobre la misma plataforma multi-tenant."

**Qué dice la documentación:**
Un tenant es un par (país, marca) (`SPEC.md` §2, `data-model.md`: `UNIQUE (country_code, brand)`). El cliente y su cupo dependen del tenant: `customers` tiene la llave `(tenant_id, id)` y `credit_accounts` tiene la llave `(tenant_id, customer_id)`. Todos los datos de semilla tienen una sola marca por país (`co-alpha`, `ec-alpha`, `gt-alpha`, `pe-alpha`). La documentación **no explica** qué pasa con un tendero físico que compra a dos marcas del mismo país.

**Por qué importa:**
Con el modelo actual, la misma tienda sería dos clientes independientes, con dos cupos y dos historiales separados, y no podría armar un carrito con productos de ambas marcas. Si el negocio espera un solo cupo por tendero, un carrito mixto o combos entre marcas, la llave del tenant y la idempotencia por `(tenant_id, customer_id)` tendrían que rediseñarse, y es mucho más caro hacerlo después de tener datos en producción.

**Pregunta:**
> Cuando un mismo tendero compra a dos marcas comerciales en el mismo país, ¿debe verse como un solo cliente con un cupo y un historial unificados, o como un cliente distinto por marca? ¿Un carrito puede mezclar productos de varias marcas y puede existir un combo entre marcas?

---

## Resumen

| # | Tema | Huella en el enunciado | Hueco en la documentación | Riesgo si no se responde |
|---|------|------------------------|---------------------------|--------------------------|
| 1 | Cambio legal de la tasa de impuesto | "palancas o precios" (no menciona impuestos) | Sella la tasa sin una regla para cambios legales | Factura con un impuesto inválido |
| 2 | Rechazo definitivo del ERP | "201 ⇒ la orden existe", efectos hacia el ERP | `DEAD` sin estado de negocio ni responsable | Pedido "confirmado" que nunca se despacha |
| 3 | Fuente de verdad del cupo | "el cupo debe reflejar el consumo" | Cupo local que solo crece, sin liberación ni sincronización | Clientes bloqueados o cupo desalineado |
| 4 | Inventario y obsequios | 201 con número de orden | Cero menciones y ningún supuesto que lo excluya | Pedidos y obsequios sin existencias |
| 5 | Un tendero con varias marcas | "varias marcas comerciales" | Cliente y cupo por tenant, una marca de semilla | Rediseño costoso de llaves y cupo |
