-- SyP Web · Script de creación del modelo lógico (SQLite 3)
-- Generado a partir del diccionario de datos B4 (mismos nombres y tipos).
PRAGMA foreign_keys = ON;

-- Personas con cuenta: clientes, administradores y técnicos
CREATE TABLE usuario (
  id_usuario              INTEGER PRIMARY KEY,
  correo                  VARCHAR(120) NOT NULL UNIQUE,
  nombre                  VARCHAR(80) NOT NULL,
  telefono                VARCHAR(15) NOT NULL,
  rol                     VARCHAR(15) NOT NULL DEFAULT 'cliente',
  contrasena_hash         VARCHAR(100) NOT NULL,
  nit                     VARCHAR(15),
  activo                  INTEGER(1) NOT NULL DEFAULT 1,
  creado_en               DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT ck_usuario_rol CHECK (rol IN ('cliente','administrador','tecnico')),
  CONSTRAINT ck_usuario_activo CHECK (activo IN (0,1))
);

-- Categorías y subcategorías del catálogo (relación recursiva)
CREATE TABLE categoria (
  id_categoria            INTEGER PRIMARY KEY,
  nombre                  VARCHAR(60) NOT NULL UNIQUE,
  orden                   INTEGER NOT NULL DEFAULT 0,
  id_categoria_padre      INTEGER,
  CONSTRAINT ck_categoria_orden CHECK (orden >= 0),
  CONSTRAINT fk_categoria_id_categoria_padre FOREIGN KEY (id_categoria_padre) REFERENCES categoria (id_categoria) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Equipos, insumos, repuestos y accesorios en venta
CREATE TABLE producto (
  id_producto             INTEGER PRIMARY KEY,
  id_categoria            INTEGER NOT NULL,
  nombre                  VARCHAR(120) NOT NULL UNIQUE,
  marca                   VARCHAR(40) NOT NULL DEFAULT 'Ricoh',
  precio                  DECIMAL(12,2) NOT NULL,
  descripcion             TEXT,
  disponibilidad          VARCHAR(10) NOT NULL DEFAULT 'normal',
  ficha_tecnica_url       VARCHAR(255),
  activo                  INTEGER(1) NOT NULL DEFAULT 1,
  CONSTRAINT ck_producto_precio CHECK (precio > 0),
  CONSTRAINT ck_producto_disponibilidad CHECK (disponibilidad IN ('normal','pocas','agotado')),
  CONSTRAINT ck_producto_activo CHECK (activo IN (0,1)),
  CONSTRAINT fk_producto_id_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Variantes de un producto (entidad débil)
CREATE TABLE variante_producto (
  id_producto             INTEGER,
  num_variante            INTEGER,
  descripcion             VARCHAR(80) NOT NULL,
  precio_adicional        DECIMAL(12,2) NOT NULL DEFAULT 0,
  CONSTRAINT pk_variante_producto PRIMARY KEY (id_producto, num_variante),
  CONSTRAINT ck_variante_producto_num_variante CHECK (num_variante > 0),
  CONSTRAINT ck_variante_producto_precio_adicional CHECK (precio_adicional >= 0),
  CONSTRAINT fk_variante_producto_id_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Qué insumo o repuesto es compatible con qué equipo (N:M recursiva)
CREATE TABLE compatibilidad_producto (
  id_producto             INTEGER,
  id_producto_compatible  INTEGER,
  CONSTRAINT pk_compatibilidad_producto PRIMARY KEY (id_producto, id_producto_compatible),
  CONSTRAINT ck_compatibilidad_producto_id_producto_compatible CHECK (id_producto <> id_producto_compatible),
  CONSTRAINT fk_compatibilidad_producto_id_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_compatibilidad_producto_id_producto_compatible FOREIGN KEY (id_producto_compatible) REFERENCES producto (id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Carrito guardado de un cliente registrado (1:1 con usuario)
CREATE TABLE carrito (
  id_carrito              INTEGER PRIMARY KEY,
  id_usuario              INTEGER NOT NULL UNIQUE,
  creado_en               DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_carrito_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Productos dentro de un carrito (resuelve N:M carrito-producto)
CREATE TABLE item_carrito (
  id_carrito              INTEGER,
  id_producto             INTEGER,
  cantidad                INTEGER NOT NULL,
  CONSTRAINT pk_item_carrito PRIMARY KEY (id_carrito, id_producto),
  CONSTRAINT ck_item_carrito_cantidad CHECK (cantidad > 0),
  CONSTRAINT fk_item_carrito_id_carrito FOREIGN KEY (id_carrito) REFERENCES carrito (id_carrito) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_item_carrito_id_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Ciudades de envío (sale de la 3FN: ciudad → departamento)
CREATE TABLE ciudad (
  id_ciudad               INTEGER PRIMARY KEY,
  nombre                  VARCHAR(60) NOT NULL,
  departamento            VARCHAR(60) NOT NULL,
  CONSTRAINT uq_ciudad_nombre_departamento UNIQUE (nombre, departamento)
);

-- Pedidos de compra (de cliente registrado o de invitado)
CREATE TABLE pedido (
  id_pedido               INTEGER PRIMARY KEY,
  codigo                  VARCHAR(20) NOT NULL UNIQUE,
  id_usuario              INTEGER,
  nombre_contacto         VARCHAR(80) NOT NULL,
  telefono_contacto       VARCHAR(15) NOT NULL,
  correo_contacto         VARCHAR(120) NOT NULL,
  direccion_envio         VARCHAR(150) NOT NULL,
  id_ciudad               INTEGER NOT NULL,
  fecha                   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  estado                  VARCHAR(12) NOT NULL DEFAULT 'pendiente',
  CONSTRAINT ck_pedido_estado CHECK (estado IN ('pendiente','confirmado','en_camino','entregado','cancelado')),
  CONSTRAINT fk_pedido_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_pedido_id_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Líneas de cada pedido (resuelve N:M pedido-producto)
CREATE TABLE detalle_pedido (
  id_pedido               INTEGER,
  id_producto             INTEGER,
  cantidad                INTEGER NOT NULL,
  precio_unitario         DECIMAL(12,2) NOT NULL,
  CONSTRAINT pk_detalle_pedido PRIMARY KEY (id_pedido, id_producto),
  CONSTRAINT ck_detalle_pedido_cantidad CHECK (cantidad > 0),
  CONSTRAINT ck_detalle_pedido_precio_unitario CHECK (precio_unitario > 0),
  CONSTRAINT fk_detalle_pedido_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_detalle_pedido_id_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Pago de un pedido (1:1 con pedido)
CREATE TABLE pago (
  id_pago                 INTEGER PRIMARY KEY,
  id_pedido               INTEGER NOT NULL UNIQUE,
  metodo                  VARCHAR(15) NOT NULL,
  estado                  VARCHAR(10) NOT NULL DEFAULT 'pendiente',
  valor                   DECIMAL(12,2) NOT NULL,
  referencia              VARCHAR(60),
  fecha                   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT ck_pago_metodo CHECK (metodo IN ('transferencia','contraentrega','en_linea')),
  CONSTRAINT ck_pago_estado CHECK (estado IN ('pendiente','aprobado','rechazado')),
  CONSTRAINT ck_pago_valor CHECK (valor > 0),
  CONSTRAINT fk_pago_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Cotizaciones formales con IVA
CREATE TABLE cotizacion (
  id_cotizacion           INTEGER PRIMARY KEY,
  codigo                  VARCHAR(20) NOT NULL UNIQUE,
  id_usuario              INTEGER,
  nombre_contacto         VARCHAR(80) NOT NULL,
  correo_contacto         VARCHAR(120) NOT NULL,
  fecha                   DATE NOT NULL DEFAULT (CURRENT_DATE),
  notas                   TEXT,
  CONSTRAINT fk_cotizacion_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Líneas de cada cotización (resuelve N:M cotización-producto)
CREATE TABLE detalle_cotizacion (
  id_cotizacion           INTEGER,
  id_producto             INTEGER,
  cantidad                INTEGER NOT NULL,
  precio_unitario         DECIMAL(12,2) NOT NULL,
  CONSTRAINT pk_detalle_cotizacion PRIMARY KEY (id_cotizacion, id_producto),
  CONSTRAINT ck_detalle_cotizacion_cantidad CHECK (cantidad > 0),
  CONSTRAINT ck_detalle_cotizacion_precio_unitario CHECK (precio_unitario > 0),
  CONSTRAINT fk_detalle_cotizacion_id_cotizacion FOREIGN KEY (id_cotizacion) REFERENCES cotizacion (id_cotizacion) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_detalle_cotizacion_id_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Solicitudes de servicio técnico
CREATE TABLE solicitud_servicio (
  id_solicitud            INTEGER PRIMARY KEY,
  codigo                  VARCHAR(20) NOT NULL UNIQUE,
  id_usuario              INTEGER,
  id_tecnico              INTEGER,
  nombre_contacto         VARCHAR(80) NOT NULL,
  telefono_contacto       VARCHAR(15) NOT NULL,
  correo_contacto         VARCHAR(120) NOT NULL,
  equipo                  VARCHAR(80) NOT NULL,
  tipo_servicio           VARCHAR(12) NOT NULL,
  fecha_deseada           DATE NOT NULL,
  franja                  VARCHAR(6) NOT NULL,
  descripcion             TEXT NOT NULL,
  estado                  VARCHAR(10) NOT NULL DEFAULT 'pendiente',
  creado_en               DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT ck_solicitud_servicio_tipo_servicio CHECK (tipo_servicio IN ('preventivo','correctivo','diagnostico')),
  CONSTRAINT ck_solicitud_servicio_franja CHECK (franja IN ('manana','tarde')),
  CONSTRAINT ck_solicitud_servicio_estado CHECK (estado IN ('pendiente','en_proceso','resuelta','cancelada')),
  CONSTRAINT fk_solicitud_servicio_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_solicitud_servicio_id_tecnico FOREIGN KEY (id_tecnico) REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Lecturas mensuales de contadores de equipos en renting
CREATE TABLE reporte_contador (
  id_reporte              INTEGER PRIMARY KEY,
  id_usuario              INTEGER NOT NULL,
  modelo_equipo           VARCHAR(60) NOT NULL,
  mes                     CHAR(7) NOT NULL,
  contador_mono           INTEGER NOT NULL,
  contador_color          INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT uq_reporte_contador_id_usuario_modelo_equipo_mes UNIQUE (id_usuario, modelo_equipo, mes),
  CONSTRAINT ck_reporte_contador_mes CHECK (mes GLOB '[0-9][0-9][0-9][0-9]-[01][0-9]'),
  CONSTRAINT ck_reporte_contador_contador_mono CHECK (contador_mono >= 0),
  CONSTRAINT ck_reporte_contador_contador_color CHECK (contador_color >= 0),
  CONSTRAINT fk_reporte_contador_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Mensajes del formulario de contacto
CREATE TABLE mensaje_contacto (
  id_mensaje              INTEGER PRIMARY KEY,
  nombre                  VARCHAR(80) NOT NULL,
  correo                  VARCHAR(120) NOT NULL,
  telefono                VARCHAR(15),
  asunto                  VARCHAR(120) NOT NULL,
  mensaje                 TEXT NOT NULL,
  leido                   INTEGER(1) NOT NULL DEFAULT 0,
  creado_en               DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT ck_mensaje_contacto_leido CHECK (leido IN (0,1))
);

-- Datos institucionales editables (registro único)
CREATE TABLE informacion_empresa (
  id_info                 INTEGER PRIMARY KEY,
  direccion               VARCHAR(150) NOT NULL,
  horario                 VARCHAR(120) NOT NULL,
  telefono                VARCHAR(15) NOT NULL,
  whatsapp                VARCHAR(15) NOT NULL,
  historia                TEXT,
  CONSTRAINT ck_informacion_empresa_id_info CHECK (id_info = 1)
);

-- Redes sociales de la empresa (atributo multivaluado en tabla aparte)
CREATE TABLE red_social (
  id_red                  INTEGER PRIMARY KEY,
  id_info                 INTEGER NOT NULL,
  nombre                  VARCHAR(30) NOT NULL,
  url                     VARCHAR(255) NOT NULL UNIQUE,
  CONSTRAINT fk_red_social_id_info FOREIGN KEY (id_info) REFERENCES informacion_empresa (id_info) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Índices para RNF-03 (rendimiento)
CREATE INDEX ix_producto_categoria ON producto (id_categoria);
CREATE INDEX ix_pedido_usuario ON pedido (id_usuario);
CREATE INDEX ix_solicitud_estado ON solicitud_servicio (estado);

-- Total del pedido como vista (dato derivado: no se guarda para no romper la 3FN)
CREATE VIEW v_total_pedido AS
  SELECT p.id_pedido, p.codigo,
         SUM(d.cantidad * d.precio_unitario)        AS subtotal,
         ROUND(SUM(d.cantidad * d.precio_unitario) * 0.19, 2) AS iva,
         ROUND(SUM(d.cantidad * d.precio_unitario) * 1.19, 2) AS total
  FROM pedido p JOIN detalle_pedido d ON d.id_pedido = p.id_pedido
  GROUP BY p.id_pedido, p.codigo;
