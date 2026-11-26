# A1 · Formato de ficha técnica y A2 · Fichas diligenciadas

**Variante del escenario:** A (60 usuarios, 15 concurrentes, 1 sede, disponibilidad 99,0 %, tope $45.000.000). *Asumida mientras el instructor confirma la variante; si es otra, se cambian los parámetros de [A5](A5-condiciones-tecnicas.md) y de la hoja [A6](A6-estimacion-economica.xlsx).*

## A1 · Formato propio (14 campos)

Basado en la estructura de calidad de **ISO/IEC 25010:2023** (características medibles) y en la guía de fichas técnicas de Colombia Compra Eficiente (identificación, especificación medible, verificación y garantía). Regla del formato: **ninguna característica exige una marca o modelo**; cada una lleva valor, unidad y método de verificación.

| # | Campo | Qué se escribe |
|---|---|---|
| 1 | Código de la ficha | FT-SW-nn o FT-HW-nn |
| 2 | Nombre del bien o servicio | Denominación genérica, sin marca |
| 3 | Tipo | Software propio · software o servicio de terceros · hardware · infraestructura |
| 4 | Descripción y propósito | Para qué se necesita en SyP Web |
| 5 | Requisitos que atiende | RF y RNF del SRS |
| 6 | Característica | Nombre de la característica medible |
| 7 | Valor mínimo exigido | Número |
| 8 | Unidad de medida | ms, GB, %, núcleos, usuarios… |
| 9 | Método de verificación | Prueba, inspección, certificado o documento del proveedor |
| 10 | Cantidad y unidad de compra | Cuántos y en qué unidad (instancia, licencia, mes) |
| 11 | Normas o estándares aplicables | Referentes de [A3](A3-referentes-tecnicos.md) |
| 12 | Garantía y soporte | Tiempo y alcance |
| 13 | Compatibilidad | Con qué debe funcionar (justificada si menciona tecnología) |
| 14 | Observaciones | Supuestos y exclusiones |

## A2 · Fichas diligenciadas

### FT-SW-01 · SyP Web (software propio)

| Campo | Contenido |
|---|---|
| Tipo | Software propio (aplicación web) |
| Descripción | Tienda en línea, servicio técnico, cotizaciones y panel administrativo de Fotocopiadoras SyP |
| Requisitos | RF-01 a RF-13; RNF-01 a RNF-11 |
| Cantidad | 1 sistema · 1 instalación en producción |
| Normas | ISO/IEC 25010:2023, WCAG 2.2 nivel AA, Ley 1581 de 2012 |
| Garantía | 3 meses de corrección de defectos sin costo desde la entrega |
| Compatibilidad | Navegadores de escritorio y móviles de las 2 últimas versiones |

| Característica | Valor | Unidad | Verificación |
|---|---|---|---|
| Tiempo de carga de páginas principales (p95) | ≤ 3 | segundos | Prueba con Lighthouse en red «4G rápida», 5 corridas |
| Tiempo de respuesta de la API (p95) con 15 usuarios concurrentes | ≤ 800 | ms | Prueba de carga con 15 usuarios virtuales durante 10 min |
| Usuarios concurrentes soportados sin errores | ≥ 15 | usuarios | Misma prueba de carga: 0 % de errores HTTP 5xx |
| Disponibilidad mensual | ≥ 99,0 | % | Reporte del monitor de salud (minutos caídos / minutos del mes) |
| Contraste y accesibilidad | 0 errores nivel A/AA | errores | Validador automático WCAG + revisión manual de 3 pantallas |
| Clics para llegar a un producto desde el inicio | ≤ 3 | clics | Inspección del recorrido en 5 productos al azar |
| Cobertura de pruebas automatizadas de la API | ≥ 70 | % de líneas | Reporte de cobertura de la suite de pruebas |

### FT-SW-02 · Servicio de correo transaccional (servicio de terceros)

| Campo | Contenido |
|---|---|
| Tipo | Servicio en la nube de terceros |
| Descripción | Envío de confirmaciones de pedido, recuperación de contraseña y avisos de solicitudes |
| Requisitos | RF-05.4, RF-06.3, RF-09.3 |
| Cantidad | 1 cuenta · ≈ 600 correos/mes (ver A5) |
| Normas | Ley 1581 de 2012 (datos personales en el correo); autenticación de dominio SPF, DKIM y DMARC |
| Garantía | La del ANS publicado por el proveedor |
| Compatibilidad | Envío por API HTTPS o SMTP con TLS (el backend usa ambos) |

| Característica | Valor | Unidad | Verificación |
|---|---|---|---|
| Capacidad mensual de envío | ≥ 1.000 | correos/mes | Plan o cuota publicada por el proveedor |
| Cifrado en tránsito | TLS ≥ 1.2 | versión | Prueba de conexión SMTP STARTTLS o documentación de la API |
| Autenticación del dominio | SPF + DKIM + DMARC | registros | Consulta DNS de los 3 registros |
| Tiempo de entrega al buzón (p95) | ≤ 60 | segundos | 20 correos de prueba con marca de tiempo |
| Disponibilidad del servicio | ≥ 99,9 | % | ANS publicado por el proveedor |
| Costo por 1.000 correos | ≤ 0,50 | USD | Página de precios con fecha de consulta |

### FT-HW-01 · Servidor de aplicación en la nube (infraestructura)

| Campo | Contenido |
|---|---|
| Tipo | Infraestructura como servicio / plataforma como servicio |
| Descripción | Ejecuta la API y sirve los archivos estáticos |
| Requisitos | RNF-03, RNF-04, RNF-05, RNF-06 |
| Cantidad | 1 instancia · por mes |
| Normas | ISO/IEC 27001:2022 (certificación del proveedor del centro de datos) |
| Garantía | Reinicio automático y ANS del proveedor |
| Compatibilidad | Ejecuta Python 3.12 y contenedores; disco persistente montable |

| Característica | Valor | Unidad | Verificación |
|---|---|---|---|
| Núcleos de CPU | ≥ 1 | vCPU | Panel del proveedor |
| Memoria RAM | ≥ 2 | GB | Panel del proveedor |
| Disco persistente | ≥ 2 | GB | Panel del proveedor; prueba de escritura que sobrevive a un reinicio |
| Transferencia mensual incluida o contratada | ≥ 8 | GB/mes | Plan contratado |
| Certificado TLS gestionado | Sí, renovación automática | — | Inspección del certificado en el navegador |
| Reinicio automático por chequeo de salud | ≤ 5 | minutos para recuperarse | Prueba: detener el proceso y medir el tiempo de vuelta |

### FT-HW-02 · Equipo de cómputo para la administración en el local (hardware)

| Campo | Contenido |
|---|---|
| Tipo | Hardware |
| Descripción | Computador en el mostrador para el panel administrativo (pedidos, solicitudes, catálogo) |
| Requisitos | RF-10, RNF-08 |
| Cantidad | 1 unidad |
| Normas | Etiqueta de eficiencia energética; RETIE para la conexión eléctrica |
| Garantía | ≥ 1 año del fabricante |
| Compatibilidad | Navegador actualizado; lector de PDF (fichas técnicas y cotizaciones) |

| Característica | Valor | Unidad | Verificación |
|---|---|---|---|
| Procesador | ≥ 4 núcleos, ≥ 2,0 GHz | núcleos / GHz | Ficha del fabricante y administrador de tareas |
| Memoria RAM | ≥ 8 | GB | Información del sistema |
| Almacenamiento | ≥ 256 GB de estado sólido | GB | Información del sistema |
| Pantalla | ≥ 21 pulgadas, ≥ 1920 × 1080 | pulgadas / píxeles | Inspección |
| Conectividad | Ethernet 1 Gbps y Wi-Fi 5 o superior | Gbps / estándar | Ficha y prueba de conexión |
| Sistema operativo | Con licencia original y soporte vigente ≥ 3 años | años | Certificado de licencia y fecha de fin de soporte |
