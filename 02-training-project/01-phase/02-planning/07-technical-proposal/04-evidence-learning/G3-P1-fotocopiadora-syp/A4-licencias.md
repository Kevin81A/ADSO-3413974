# A4 · Dimensionamiento de licencias

Parámetros de la variante A: 60 usuarios, 15 concurrentes, 1 sede, equipo de desarrollo de 2 personas, 1 equipo administrativo en el local. Precios consultados el 2026-11-26 (TRM 4.000).

## Componentes de la solución

| # | Componente | Producto (genérico → elegido) | Tipo de licencia | Modelo de cobro | Cantidad calculada (fórmula) | Costo y periodo | Obligación de cumplimiento |
|---|---|---|---|---|---|---|---|
| 1 | Sistema operativo del servidor | Linux gestionado por el PaaS | Incluido en el servicio (GPL para el núcleo) | Incluido en la suscripción | 1 = instancias del servidor | $0 (incluido en el cómputo) | Ninguna para el usuario del servicio |
| 2 | Base de datos | SQLite 3 | Dominio público | Gratuita | 1 = un archivo de base por instalación | $0 | Ninguna (dominio público) |
| 3 | Lenguaje y framework | Python 3.12 + FastAPI | PSF License + MIT | Gratuita | 1 instalación por servidor (= 1) | $0 | Conservar avisos de copyright y licencia en la distribución |
| 4 | Librerías clave del backend | Ver inventario abajo (8 dependencias) | MIT, BSD-3-Clause, Apache-2.0 | Gratuita | 8 = líneas de `requirements.txt` | $0 | Atribución; Apache-2.0 exige conservar el archivo NOTICE si existe |
| 5 | Herramientas de desarrollo y diseño | Editor de código y diagrams.net | Licencia gratuita del editor; Apache-2.0 (diagrams.net) | Gratuita, nominal por desarrollador | 2 = desarrolladores | $0 | Uso según términos del editor; sin restricción comercial |
| 6 | Hosting en la nube | Servidor de aplicación 1 CPU / 2 GB + disco 2 GB | Servicio comercial (términos del proveedor) | Suscripción mensual por instancia | 1 instancia = ⌈15 concurrentes ÷ 25 por instancia⌉; disco = 2 GB (A5) | USD 25,50/mes ≈ $102.000/mes | Pago mensual; aceptación de términos y política de datos del proveedor |
| 7 | Control de versiones e integración continua | GitHub Free + GitHub Actions | Servicio gratuito (términos de GitHub) | Gratuita nominal por usuario | 2 = desarrolladores | $0 (dentro de los minutos gratuitos de Actions) | Términos de servicio de GitHub |
| 8 | Correo transaccional | Amazon SES | Servicio comercial | Pago por uso | ≈ 600 correos/mes = (240 pedidos × 2 correos) + 60 solicitudes + 60 recuperaciones (A5) | USD 0,06/mes ≈ $240/mes | Pago por uso; dominio verificado |

**Capacidad por instancia (supuesto):** con FastAPI y SQLite en 1 CPU, se estima atender 25 usuarios concurrentes con respuesta < 800 ms; con 15 concurrentes basta 1 instancia. Se verifica con la prueba de carga de la ficha FT-SW-01.

## Inventario de dependencias del código

Fuente: `fastapi_backend/requirements.txt` del proyecto del equipo (versiones fijadas).

| Dependencia | Versión | Licencia | Alerta de compatibilidad |
|---|---|---|---|
| fastapi | 0.115.14 | MIT | Permisiva: compatible con licencia propietaria |
| starlette | 0.46.2 | BSD-3-Clause | Permisiva; no usar el nombre de los autores para promoción |
| uvicorn | 0.54.0 | BSD-3-Clause | Permisiva |
| pydantic | 2.14.4 | MIT | Permisiva |
| pyjwt | 2.15.1 | MIT | Permisiva |
| bcrypt | 5.0.0 | Apache-2.0 | Permisiva; conservar NOTICE y avisos de cambios |
| python-multipart | 0.0.34 | Apache-2.0 | Permisiva; conservar NOTICE |
| email-validator | 2.4.0 | The Unlicense (dominio público): **verificar en el repositorio del paquete** | Sin obligaciones si se confirma |

**Ninguna dependencia es copyleft** (GPL/AGPL), así que no obliga a liberar el código de SyP Web.

## Decisión sobre la licencia del software propio

**Licencia propietaria con cesión de derechos patrimoniales a la propietaria de Fotocopiadoras SyP**, sujeta al pago total y pactada por escrito en el contrato (Ley 23 de 1982). Los autores conservan los derechos morales: mención como autores e integridad de la obra. Se entrega el código fuente y la propietaria puede registrar el software en la Dirección Nacional de Derecho de Autor.

**Por qué:** el sistema contiene reglas y datos propios del negocio, el cliente quiere controlarlo sin depender del equipo, y las dependencias son todas permisivas, así que lo permiten. Se descartó publicarlo como MIT: dejaría a la competencia usar libremente un desarrollo que pagó la propietaria.
