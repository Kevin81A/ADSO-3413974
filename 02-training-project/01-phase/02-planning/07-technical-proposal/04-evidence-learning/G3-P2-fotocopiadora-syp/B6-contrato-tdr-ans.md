# B6 · Lista de verificación para el contrato, matriz de términos de referencia y ANS

## (a) Lista de verificación para el contrato

| # | Elemento del contrato | ¿Está en la propuesta? | Sección donde se cumple |
|---|---|---|---|
| 1 | Partes (contratante y contratista, por rol) | Sí | Encabezado de la propuesta |
| 2 | Objeto | Sí | §1 Resumen ejecutivo |
| 3 | Alcance (incluye, excluye, supuestos) | Sí | §3 Alcance |
| 4 | Valor (con IVA) | Sí | §8 Costos |
| 5 | Forma e hitos de pago | Sí | §11 (30 % · 30 % · 40 % ligados a H3 y H5) |
| 6 | Plazos y cronograma | Sí | §6 (40 días hábiles, hitos H1 a H5) |
| 7 | Entregables | Sí | §3 y §12 (software, código fuente, manuales, capacitación) |
| 8 | Criterios de aceptación | Sí | §5: fichas técnicas medibles con su método de verificación (P1) |
| 9 | Garantías | Sí | §10 (3 meses) |
| 10 | Propiedad intelectual y titularidad | Sí | §11 (cesión de derechos patrimoniales al pagar; derechos morales de los autores) |
| 11 | Confidencialidad y datos personales | Sí | §11 (responsable y encargado según la Ley 1581) |
| 12 | Acuerdo de niveles de servicio | Sí | §10 y sección (c) de este documento |
| 13 | Terminación (causales y efectos) | **Parcial** | Agregar en el contrato: terminación por incumplimiento con 15 días para subsanar, y pago de lo ejecutado |
| 14 | Vigencia | Sí | §12 (oferta de 30 días; contrato hasta el fin de la garantía) |

## (b) Matriz de cumplimiento de términos de referencia

Términos de referencia **simulados** a partir de lo que pidió la propietaria en el SRS (no hubo un documento formal de la contraparte):

| # | Requisito del término de referencia | Cumple / Parcial / No cumple | Evidencia |
|---|---|---|---|
| TR-1 | La tienda debe funcionar en celular, tableta y computador | Cumple | FT-SW-01 y RNF-02; §5 |
| TR-2 | El personal debe cambiar precios y productos sin programador | Cumple | CU-18 y panel administrativo; §3 |
| TR-3 | Debe aceptar pago en línea con tarjeta | **Parcial** | Transferencia y contraentrega en la fase 1; pago en línea en la fase 2 (§3, excluido) |
| TR-4 | Los datos de los clientes deben estar protegidos por ley | Cumple | Referente Ley 1581 (A3) y políticas de seguridad de la G2 |
| TR-5 | El costo del primer año no debe superar $45.000.000 | Cumple | §8: $39.565.711 con IVA |
| TR-6 | Debe entregarse en menos de 3 meses | Cumple | §6: 40 días hábiles |
| TR-7 | Debe incluir facturación electrónica DIAN | No cumple | Excluida del alcance (§3); se propone como mejora futura |
| TR-8 | Debe haber copia de seguridad diaria | Cumple | ANS-4 (RPO 24 h); despliegue de §4 |

## (c) Acuerdo de niveles de servicio (ANS)

| ID | Métrica | Valor comprometido | Ventana de medición | Fuente de medición | Compensación por incumplimiento |
|---|---|---|---|---|---|
| ANS-1 | Disponibilidad del sitio | ≥ 99,0 % | Mensual (730 h; se excluyen mantenimientos avisados con 48 h, máximo 4 h/mes) | Monitor de salud externo cada 5 min sobre `/api/v1/health` | 10 % de descuento sobre la cuota de soporte del mes por cada 0,5 % por debajo |
| ANS-2 | Tiempo de respuesta de la API (p95) | ≤ 800 ms con 15 usuarios concurrentes | Mensual | Registro de tiempos de la API (percentil 95) | 1 h de soporte adicional sin costo por cada mes incumplido |
| ANS-3 | Atención de incidentes críticos (sitio caído o checkout sin funcionar) | Respuesta ≤ 4 h hábiles; solución o contingencia ≤ 1 día hábil | Lunes a sábado, 8:00 a 18:00 | Registro de casos (fecha y hora de reporte y de solución) | 5 % de descuento sobre la cuota del mes por caso fuera de plazo |
| ANS-4 | Respaldo y recuperación | RPO ≤ 24 h · RTO ≤ 4 h | Prueba de restauración mensual | Acta de la prueba de restauración | Restauración sin costo y 2 h de soporte adicional |
