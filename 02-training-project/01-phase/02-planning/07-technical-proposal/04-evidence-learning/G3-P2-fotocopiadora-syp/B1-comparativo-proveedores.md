# B1 · Análisis comparativo de proveedores

Hoja con fórmulas: [B1-comparativo-proveedores.xlsx](B1-comparativo-proveedores.xlsx) (pestañas de matriz, TCO y evidencia). Todas las alternativas se comparan contra las **mismas fichas del Producto 1** y la misma cantidad: FT-HW-01 (1 vCPU, 2 GB RAM, 2 GB de disco persistente, ≥ 8 GB/mes de transferencia) y FT-SW-02 (≥ 1.000 correos/mes, TLS, SPF/DKIM). Precios consultados el **2026-11-26**, TRM 4.000, tarifa de 35.000 COP/h.

## Categoría 1 · Servidor de aplicación (FT-HW-01)

| Criterio | Peso | Render | Railway Hobby | DigitalOcean Droplet 2 GB |
|---|---|---|---|---|
| Costo total a 36 meses (TCO) | 30 % | 4 | 3 | 5 |
| Esfuerzo de operación (servicio administrado) | 25 % | 5 | 5 | 2 |
| Disponibilidad y reinicio automático | 20 % | 4 | 4 | 3 |
| Despliegue directo desde GitHub | 15 % | 5 | 5 | 2 |
| Disco persistente y respaldo | 10 % | 4 | 3 | 3 |
| **Puntaje ponderado (1 a 5)** | **100 %** | **4,40** | **4,00** | **3,20** |

**Justificación de los puntajes:** DigitalOcean tiene la infraestructura más barata (USD 12/mes), pero es un servidor autogestionado: hay que instalar y parchear el sistema, configurar TLS y el reinicio, y eso se cobra en horas (3 h/mes). Render y Railway despliegan desde GitHub con TLS gestionado. Render tiene precio fijo por instancia; en Railway el costo depende del consumo y para 2 GB de RAM resulta mayor.

**TCO a 36 meses (fórmulas en la hoja):**

| Rubro | Render (recomendado) | Railway (mejor descartado) |
|---|---|---|
| Infraestructura mensual | USD 25,50 (cómputo 25 + disco 2 × 0,25) | USD 40,30 (fee 5 + CPU 20 + RAM 2 × 10 + volumen 0,30 − crédito 5) |
| Infraestructura 36 meses | $3.672.000 | $5.803.200 |
| Configuración inicial (4 h) | $140.000 | $140.000 |
| Operación (0,5 h/mes × 36) | $630.000 | $630.000 |
| **TCO 36 meses** | **$4.442.000** | **$6.573.200** |

DigitalOcean: TCO $6.068.000 (infraestructura $1.728.000 + configuración de 16 h + operación de 3 h/mes).

**Recomendación:** **Render**. Tiene el menor TCO entre las opciones administradas y el mejor puntaje. Se descarta Railway porque, con el mismo servicio, su costo por consumo es 48 % mayor. Se descarta DigitalOcean porque su bajo precio se pierde en horas de administración y exige conocimientos de servidores que el equipo y el cliente no quieren asumir.

## Categoría 2 · Correo transaccional (FT-SW-02)

| Criterio | Peso | Amazon SES | Twilio SendGrid Essentials | Brevo (gratuito) |
|---|---|---|---|---|
| Costo total a 36 meses (TCO) | 30 % | 5 | 2 | 4 |
| Facilidad de integración con la API | 20 % | 3 | 5 | 4 |
| Entregabilidad y reputación | 20 % | 5 | 5 | 4 |
| Soporte en español / documentación | 15 % | 3 | 4 | 4 |
| Límite de envíos frente a la demanda (≈ 600/mes) | 15 % | 4 | 5 | 3 |
| **Puntaje ponderado (1 a 5)** | **100 %** | **4,15** | **3,95** | **3,85** |

**TCO a 36 meses:** Amazon SES (recomendado) = USD 0,06/mes × 36 × 4.000 + 6 h de configuración = **$218.640** · SendGrid (mejor descartado) = USD 19,95/mes × 36 × 4.000 + 3 h = **$2.977.800**.

**Recomendación:** **Amazon SES**. Por el volumen de SyP Web (≈ 600 correos/mes) el pago por uso cuesta centavos. SendGrid integra más fácil, pero cobra una tarifa fija 13 veces mayor en 36 meses. Brevo **queda pendiente de verificación**: su página de precios no se pudo leer automáticamente el 2026-11-26. Antes de la entrega hay que abrirla en el navegador y anotar el límite diario del plan gratuito y la fecha (pestaña «Evidencia» de la hoja).

## Evidencia

| Alternativa | Fuente | Fecha |
|---|---|---|
| Render | https://render.com/pricing | 2026-11-26 |
| Railway | https://railway.com/pricing | 2026-11-26 |
| DigitalOcean | https://www.digitalocean.com/pricing/droplets | 2026-11-26 |
| Amazon SES | https://aws.amazon.com/ses/pricing/ | 2026-11-26 |
| Twilio SendGrid | https://www.twilio.com/en-us/products/email-api/pricing | 2026-11-26 |
| Brevo | https://www.brevo.com/pricing/ | **Pendiente** |
