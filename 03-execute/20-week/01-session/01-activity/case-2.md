# PRD — Control de mascotas y medicamentos (veterinaria)

## Contexto de negocio

Una clínica veterinaria necesita controlar las mascotas y su historial médico: un
propietario tiene una o varias mascotas, se agendan citas, si la atención se
realiza se registra una consulta, de la consulta salen diagnósticos, de cada
diagnóstico un tratamiento, y cuando se requiere medicación una prescripción que
referencia un medicamento del catálogo y su lote. El sistema debe permitir
consultar, entre otras cosas, las citas que **no** derivaron en consulta.

## Usuarios

- **Recepcionista/veterinario** (rol único del MVP): inicia sesión y gestiona
  propietarios, mascotas, citas, consultas, diagnósticos, tratamientos,
  prescripciones, medicamentos y lotes, y consulta reportes. El sistema arranca con
  un administrador sembrado.

## Entidades (modelo de dominio)

1. **owner** — id: document · name, phone. 1..N mascotas.
2. **pet** — id: clinical_code · name, birth_date. Historial independiente por mascota.
3. **appointment** — id: code · date, reason. **Puede no derivar en consulta.**
4. **veterinarian** — id: professional_card · name, specialty. Asignado a la cita.
5. **consultation** — id: sequential · date, weight. **Existe solo si la atención se
   realiza** (relación 1:1 opcional con appointment).
6. **diagnosis** — id: code · description, severity_level. **1..N por consulta.**
7. **treatment** — derivado del diagnóstico · start_date, duration, instructions.
8. **prescription** — derivada del tratamiento · dose, frequency, administration_route.
   **Opcional** (solo cuando se requiere medicación).
9. **medication** — id: code · name, concentration. Catálogo referenciado.
10. **lot** — **entidad débil** respecto a medication: lot_number + medication_code ·
    expiration_date, available_quantity.

## Puntos de modelado a resolver (obligatorios)

- **consultation** con **participación opcional 1:1** respecto a appointment: la
  ausencia de consulta identifica las citas no atendidas.
- **treatment** derivado de **diagnosis**, y **prescription** derivada de
  **treatment** (cadena de dependencia).
- **prescription** **opcional** (no todo tratamiento medica).
- **lot** es **entidad débil / id compuesto** respecto a medication.

## Requisitos funcionales

1. El usuario inicia sesión con credenciales válidas y recibe un token; las
   inválidas se rechazan con un error claro.
2. El usuario crea y lista propietarios (documento, nombre, teléfono).
3. El usuario crea mascotas asociadas a un propietario y las lista.
4. El usuario agenda citas para una mascota, con veterinario y motivo, y las lista.
5. El usuario registra una consulta a partir de una cita atendida (1:1 opcional),
   con peso.
6. El usuario registra 1..N diagnósticos por consulta, con nivel de gravedad.
7. El usuario registra el tratamiento de un diagnóstico y, opcionalmente, una
   prescripción que referencia un medicamento del catálogo y su lote.
8. El usuario gestiona el catálogo de medicamentos y sus lotes (con vencimiento y
   cantidad disponible).
9. El usuario consulta el reporte de **citas que no derivaron en consulta**.

## Requisitos no funcionales

- **security**: rutas de escritura con token válido; contraseñas hasheadas.
- **reliability**: una prescripción no puede referenciar un lote vencido; la
  consulta existe a lo sumo una vez por cita; operaciones atómicas.
- **performance**: consultas de listado bajo 500 ms para hasta 10.000 mascotas.
- **maintainability**: backend, frontend y base de datos como proyectos separados;
  identificadores técnicos en inglés y singular.
- **usability**: mensajes al usuario en español; fechas con formato local.

## Criterios de aceptación

- Un usuario inicia sesión, crea un propietario y una mascota, agenda una cita,
  registra la consulta con diagnóstico y tratamiento, y consulta el reporte de
  citas sin consulta correctamente.
- El despliegue arranca con `docker compose` (backend, frontend, base de datos con
  administrador sembrado) y **la aplicación queda arriba y navegable**.
- Existe evidencia de pruebas automatizadas de backend y frontend.

## Stack

- Backend: Go · Frontend: Angular · Base de datos: PostgreSQL · Operación: Docker Compose
