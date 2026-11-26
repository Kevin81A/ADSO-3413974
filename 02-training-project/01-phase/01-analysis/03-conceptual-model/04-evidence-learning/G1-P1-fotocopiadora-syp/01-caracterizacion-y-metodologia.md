# 1. Caracterización de la solución y selección de metodología

## 1.1 Caracterización de SyP Web

| Aspecto | Valor en el caso | Evidencia |
|---|---|---|
| **Tipo de proyecto** | Aplicación web nueva de comercio electrónico con módulo de servicio técnico y panel administrativo para una pyme de Neiva (venta de fotocopiadoras, impresoras, tóners y repuestos). Producto pequeño-mediano (42 requisitos funcionales, 11 no funcionales), sin integración con sistemas legados. | SRS v2.0, secciones 1.2 y 2.2 |
| **Tamaño del equipo** | 2 personas (yo, `Kevin81A`, como analista y desarrollador principal, y un co-desarrollador). Sin roles separados de pruebas ni de diseño. | README del repositorio del equipo |
| **Estabilidad de los requisitos** | **Media-baja**. Hay decisiones abiertas: el método de pago está «a definir» (RF-05.3), tres requisitos son «opcional v1» (RF-06.5, RF-10.7) y durante el año aparecieron funciones nuevas que no estaban en el SRS (cotizaciones y contadores de renting, que agregué como RF-12 y RF-13). | SRS v2.0: RF-05.3, sección 6; hallazgo H-01 del producto 2 |
| **Disponibilidad del cliente** | **Parcial pero frecuente**: la propietaria atiende el local, no puede asistir a talleres largos, pero responde por WhatsApp a diario y puede revisar avances una vez por semana (30 a 45 minutos). | SRS 2.5 (canal WhatsApp prioritario) y acuerdo con la propietaria |

Otras características que influyen: plazo corto (el análisis debe cerrar en 2 semanas), presupuesto bajo, software web desplegable de forma incremental (Render), y riesgo principal de negocio en el checkout (pagos y pedidos).

## 1.2 Comparación de metodologías

Criterios tomados de las características anteriores (escala 1 = poco adecuada, 3 = muy adecuada):

| Criterio (de la caracterización) | RUP | Scrum | XP | RAD |
|---|---|---|---|---|
| C1. Equipo de 2 personas | 1 · Pide muchos roles y artefactos formales; sobrecarga a dos personas | 2 · Funciona con equipos pequeños; el rol de Scrum Master se comparte | 3 · Pensado para equipos pequeños de desarrolladores | 2 · Equipo pequeño, pero exige usuarios disponibles en talleres |
| C2. Requisitos de estabilidad media-baja | 2 · Iterativo, pero cada cambio pasa por documentos formales | 3 · El backlog se reprioriza cada sprint | 3 · Acepta cambios continuos | 2 · Tolera cambios en prototipos, poco en la arquitectura |
| C3. Cliente con disponibilidad parcial (1 revisión por semana) | 2 · Hitos por fase, revisión al final de cada fase | 3 · Revisión de sprint semanal de 30 a 45 min encaja con la propietaria | 1 · Exige cliente en sitio de forma continua | 1 · Exige sesiones JAD intensivas con el usuario |
| C4. Entrega incremental en la web y plazo corto | 2 · Cuatro fases pesadas para un plazo de 2 semanas de análisis | 3 · Sprints cortos con incremento revisable | 3 · Entregas pequeñas y frecuentes | 3 · Construcción rápida por prototipos |
| C5. Necesidad de documentar el análisis (SRS, modelos UML) para la formación | 3 · Muy documentado | 2 · Documenta lo necesario en el backlog y en la definición de terminado | 1 · Prioriza código sobre documentos | 1 · Prioriza prototipos |
| **Total (máx. 15)** | **10** | **13** | **11** | **9** |

## 1.3 Metodología seleccionada: Scrum (con sprints de una semana)

**Selección:** Scrum, sin mezcla con otra metodología.

**Justificación con las características del caso:**

1. **Cliente parcial (C3):** Scrum concentra la participación de la propietaria en una revisión de sprint semanal y corta; XP y RAD fallan porque exigen al cliente en sitio o en talleres largos, que ella no puede dar.
2. **Requisitos cambiantes (C2):** RF-05.3 (pago) y los opcionales se dejan en el backlog y se repriorizan cada semana sin rehacer documentos, a diferencia de RUP.
3. **Equipo de 2 (C1):** asumo el rol de *Product Owner* delegado (analista) y el co-desarrollador el de *Scrum Master*; la propietaria es la *stakeholder* que acepta.
4. **Documentación exigida (C5):** la «definición de terminado» de cada historia de análisis incluye su artefacto UML verificado con la lista de chequeo, lo que cubre la debilidad documental de Scrum frente a RUP.

**Alternativa descartada más cercana:** XP (11 puntos). Se descarta porque su práctica central de cliente en sitio no es posible y porque reduce la documentación de análisis que este proyecto sí necesita.
