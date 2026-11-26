# B1 · Modelo conceptual

**Tipo de base de datos:** relacional (ver justificación en [A1](../G2-P1-fotocopiadora-syp/A1-ficha-interpretacion.md)): pedidos, pagos y productos tienen relaciones fijas y exigen integridad referencial y transacciones.

**Base reutilizada:** el MER de la guía 1 ([G1-P2 · modelo entidad-relación](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/diagramas/modelo-entidad-relacion.png)). Aquí se evalúa **lo que cambié** para ajustarlo al tipo de base de datos y al diseño:

| # | Ajuste frente a la guía 1 | Motivo |
|---|---|---|
| 1 | Nueva relación recursiva **N:M PRODUCTO «es compatible con» PRODUCTO** | El sistema real guarda `compatible_ids` como lista en un texto (atributo multivaluado). El buscador de repuestos (RF-03.2) necesita saber qué tóner sirve para qué equipo |
| 2 | Nueva entidad **CIUDAD** (nombre, departamento) | Al normalizar el pedido apareció la dependencia transitiva ciudad → departamento (B3) |
| 3 | Atributo multivaluado **redes sociales** de INFORMACION_EMPRESA → entidad **RED_SOCIAL** | 1FN: una red por fila |
| 4 | SOLICITUD_SERVICIO con **dos** relaciones con USUARIO (solicita / atiende) con cardinalidad mínima 0 | Un visitante sin cuenta puede pedir servicio; la solicitud nace sin técnico |
| 5 | El total del pedido se marca como **derivado** | Se calcula desde los detalles; no se almacena (B3) |

## Diagrama (Mermaid · notación pata de gallo · GitHub lo dibuja)

```mermaid
erDiagram
  CATEGORIA |o--o{ CATEGORIA : "es subcategoria de"
  CATEGORIA ||--o{ PRODUCTO : clasifica
  PRODUCTO ||--o{ VARIANTE_PRODUCTO : "tiene (debil)"
  PRODUCTO }o--o{ PRODUCTO : "es compatible con"
  USUARIO ||--o| CARRITO : tiene
  CARRITO ||--|{ ITEM_CARRITO : contiene
  PRODUCTO ||--o{ ITEM_CARRITO : "esta en"
  USUARIO |o--o{ PEDIDO : realiza
  CIUDAD ||--o{ PEDIDO : "recibe envio de"
  PEDIDO ||--|{ DETALLE_PEDIDO : contiene
  PRODUCTO ||--o{ DETALLE_PEDIDO : "se vende en"
  PEDIDO ||--o| PAGO : "se paga con"
  USUARIO |o--o{ COTIZACION : solicita
  COTIZACION ||--|{ DETALLE_COTIZACION : contiene
  PRODUCTO ||--o{ DETALLE_COTIZACION : "se cotiza en"
  USUARIO |o--o{ SOLICITUD_SERVICIO : solicita
  USUARIO |o--o{ SOLICITUD_SERVICIO : "atiende (tecnico)"
  USUARIO ||--o{ REPORTE_CONTADOR : reporta
  INFORMACION_EMPRESA ||--o{ RED_SOCIAL : publica
  USUARIO {
    int id_usuario PK
    string correo
    string nombre
    string telefono
    string rol
  }
  CATEGORIA {
    int id_categoria PK
    string nombre
    int orden
  }
  PRODUCTO {
    int id_producto PK
    string nombre
    string marca
    decimal precio
    string disponibilidad
  }
  VARIANTE_PRODUCTO {
    int num_variante PK
    string descripcion
    decimal precio_adicional
  }
  CARRITO {
    int id_carrito PK
    datetime creado_en
  }
  ITEM_CARRITO {
    int cantidad
  }
  CIUDAD {
    int id_ciudad PK
    string nombre
    string departamento
  }
  PEDIDO {
    int id_pedido PK
    string codigo
    datetime fecha
    string estado
    string direccion_envio
  }
  DETALLE_PEDIDO {
    int cantidad
    decimal precio_unitario
  }
  PAGO {
    int id_pago PK
    string metodo
    string estado
    decimal valor
  }
  COTIZACION {
    int id_cotizacion PK
    string codigo
    date fecha
  }
  DETALLE_COTIZACION {
    int cantidad
    decimal precio_unitario
  }
  SOLICITUD_SERVICIO {
    int id_solicitud PK
    string equipo
    string tipo_servicio
    date fecha_deseada
    string estado
  }
  REPORTE_CONTADOR {
    int id_reporte PK
    string mes
    int contador_mono
    int contador_color
  }
  MENSAJE_CONTACTO {
    int id_mensaje PK
    string asunto
    string mensaje
    int leido
  }
  INFORMACION_EMPRESA {
    int id_info PK
    string direccion
    string horario
    string whatsapp
  }
  RED_SOCIAL {
    int id_red PK
    string nombre
    string url
  }
```

## Relaciones: verbo y cardinalidad mínima y máxima

| Relación (verbo) | Lado A (mín..máx) | Lado B (mín..máx) | Tipo | Requisito |
|---|---|---|---|---|
| CATEGORIA es subcategoría de CATEGORIA | 0..1 | 0..N | 1:N recursiva | RF-02.2 |
| CATEGORIA clasifica PRODUCTO | 1..1 | 0..N | 1:N | RF-02.2, RF-10.3 |
| PRODUCTO tiene VARIANTE_PRODUCTO | 1..1 | 0..N | 1:N identificadora (débil) | RF-03.2 |
| PRODUCTO es compatible con PRODUCTO | 0..N | 0..N | **N:M** recursiva | RF-03.2 |
| USUARIO tiene CARRITO | 1..1 | 0..1 | 1:1 | RF-04.3 |
| CARRITO contiene PRODUCTO (vía ITEM_CARRITO) | 0..N | 0..N | **N:M** | RF-04.1 |
| USUARIO realiza PEDIDO | 0..1 | 0..N | 1:N | RF-05, RF-06.4, RF-06.5 |
| CIUDAD recibe envío de PEDIDO | 1..1 | 0..N | 1:N | RF-05.1 |
| PEDIDO contiene PRODUCTO (vía DETALLE_PEDIDO) | 1..N | 0..N | **N:M** | RF-05.2 |
| PEDIDO se paga con PAGO | 1..1 | 0..1 | 1:1 | RF-05.3 |
| COTIZACION contiene PRODUCTO (vía DETALLE_COTIZACION) | 1..N | 0..N | **N:M** | RF-12 |
| USUARIO solicita / atiende SOLICITUD_SERVICIO | 0..1 | 0..N | 1:N (dos roles) | RF-09 |
| USUARIO reporta REPORTE_CONTADOR | 1..1 | 0..N | 1:N | RF-13 |
| INFORMACION_EMPRESA publica RED_SOCIAL | 1..1 | 0..N | 1:N | RF-08.4 |

**17 entidades** con identificador; **4 relaciones N:M**, **9 relaciones 1:N** (contando los dos roles de USUARIO con SOLICITUD_SERVICIO) y **2 relaciones 1:1**. MENSAJE_CONTACTO no se relaciona (se guarda aunque el remitente no tenga cuenta; RF-08.5).
