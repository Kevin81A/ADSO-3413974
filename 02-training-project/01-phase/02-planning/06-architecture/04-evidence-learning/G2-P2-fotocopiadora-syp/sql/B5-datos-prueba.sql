-- Datos ficticios de prueba (sin datos personales reales)
INSERT INTO usuario (correo, nombre, telefono, rol, contrasena_hash) VALUES
 ('admin@ejemplo.test', 'Administrador Demo', '3000000001', 'administrador', '$2b$12$hashDeEjemploNoReal1'),
 ('cliente@ejemplo.test', 'Cliente Demo', '3000000002', 'cliente', '$2b$12$hashDeEjemploNoReal2'),
 ('tecnico@ejemplo.test', 'Técnico Demo', '3000000003', 'tecnico', '$2b$12$hashDeEjemploNoReal3');
INSERT INTO categoria (nombre, orden) VALUES ('Fotocopiadoras', 1), ('Tintas y tóneres', 2), ('Repuestos', 3);
INSERT INTO categoria (nombre, orden, id_categoria_padre) VALUES ('Tóneres compatibles', 1, 2);
INSERT INTO producto (id_categoria, nombre, precio, disponibilidad) VALUES
 (1, 'Multifuncional demo A', 6900000, 'pocas'), (2, 'Tóner demo MP', 90000, 'normal'), (3, 'Unidad fusora demo', 480000, 'agotado');
INSERT INTO variante_producto VALUES (2, 1, 'Estándar', 0), (2, 2, 'Premium', 15000);
INSERT INTO compatibilidad_producto VALUES (2, 1), (3, 1);
INSERT INTO ciudad (nombre, departamento) VALUES ('Neiva', 'Huila');
INSERT INTO pedido (codigo, id_usuario, nombre_contacto, telefono_contacto, correo_contacto, direccion_envio, id_ciudad)
 VALUES ('SYP-2026-00001', 2, 'Cliente Demo', '3000000002', 'cliente@ejemplo.test', 'Calle Falsa 123', 1);
INSERT INTO detalle_pedido VALUES (1, 2, 2, 90000);
INSERT INTO pago (id_pedido, metodo, valor) VALUES (1, 'transferencia', 214200);
INSERT INTO informacion_empresa VALUES (1, 'Dirección de ejemplo, Neiva', 'L-V 8:00-18:00', '6080000000', '3000000000', 'Texto de ejemplo');
INSERT INTO red_social (id_info, nombre, url) VALUES (1, 'Facebook', 'https://facebook.com/ejemplo');
