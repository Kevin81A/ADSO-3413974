# Ingeniería Inversa Aplicada: "SENA — Gestión de Horarios" (Mockup)

**Material de clase.** Este documento explica, paso a paso y sin tecnicismos innecesarios, cómo se hizo ingeniería inversa sobre un proyecto web real. La idea es que cualquier estudiante que apenas está empezando pueda leerlo y entender no solo *qué* se descubrió, sino *cómo* se llegó a descubrirlo.

**Proyecto analizado:** `code-sena/design-software-mockup`
**Link para probarlo ustedes mismos:** `https://code-sena.github.io/design-software-mockup/app/index.html#/`

---

## 0. Primero lo primero: ¿qué es "hacer ingeniería inversa"?

Imagínate que te regalan un carro armado, sin planos, sin manual, y te dicen: *"averigua cómo funciona por dentro"*. Puedes hacer dos cosas:

1. Manejarlo, observar cómo se comporta (acelera, frena, prende luces) — sin abrir el motor.
2. Abrir el capó, mirar cada pieza, seguir los cables, entender cómo se conecta todo.

**Eso exactamente es la ingeniería inversa aplicada a software**: agarrar algo que *ya existe y ya funciona*, y en vez de construirlo desde cero, ir hacia atrás para entender cómo lo armaron. No estás inventando nada nuevo, estás **investigando lo que ya está hecho**.

Hay dos formas de hacer esto, dependiendo de qué tanto acceso tengas:

- **Sin ver el código (caja negra):** solo usas la página como usuario normal, y con lo que ves en pantalla vas armando teorías de cómo está hecha por dentro. Es como manejar el carro sin abrir el capó.
- **Viendo el código (caja blanca):** tienes acceso a los archivos reales del proyecto (en este caso, están públicos en GitHub), así que puedes leer exactamente cómo está construido, sin adivinar. Es como abrir el capó y ver los cables de verdad.

En este ejercicio hicimos **las dos cosas, en ese orden**: primero usamos la página como cualquier persona la usaría, y después bajamos el código y lo leímos con calma. Vamos a repetir ese mismo orden en este documento, porque así es como se debe hacer siempre: **primero observar, después leer el código**.

---

## 1. Paso 1 — Usar la página como usuario normal (sin mirar código todavía)

Antes de tocar una sola línea de código, lo primero que se hace siempre es **usar la aplicación como la usaría cualquier persona**, y anotar todo lo raro o interesante que se note.

Al entrar a la página del SENA y jugar un rato con ella, esto es lo que cualquiera notaría:

- La página **nunca recarga completamente** cuando cambias de sección. Cuando le das clic a "Horarios" o "Disponibilidad", el contenido cambia pero el navegador no hace ese parpadeo típico de cuando cargas una página nueva. Eso es una pista importante: significa que **todo pasa dentro del mismo archivo HTML**, y es JavaScript el que va cambiando lo que se ve.
- La dirección en la barra del navegador siempre tiene un símbolo `#` (por ejemplo `#/horarios`). Eso también es una pista: ese tipo de direcciones normalmente significa "aquí no hay una página nueva de verdad, es solo una marca para que la propia página sepa qué mostrar".
- El login **no valida nada de verdad**. Puedes poner cualquier contraseña y te deja entrar. Eso te dice que no hay un servidor real revisando usuarios y contraseñas — es una simulación.
- Dependiendo del correo que escribas en el login, entras como un tipo de usuario distinto (coordinador, instructor, aprendiz, etc.), y cada uno ve un menú diferente.
- Hay un menú para "cambiar de rol" sin necesidad de cerrar sesión — algo que una aplicación real casi nunca tendría, porque es una función pensada para que el profesor o el revisor pueda ver rápido las distintas vistas.

**¿Por qué anotar esto antes de ver el código?** Porque así, cuando después abramos el código fuente, no vamos a estar leyendo a ciegas: ya vamos a tener una idea de qué buscar, y vamos a poder *confirmar o corregir* lo que pensábamos. Es más fácil entender un código cuando ya sabes, aunque sea a grandes rasgos, qué se supone que hace.

---

## 2. Paso 2 — Buscar dónde está el código real del proyecto

Como esta página está hecha con tecnologías web comunes (HTML, CSS y JavaScript), en teoría **todo el código que hace funcionar la página se le envía al navegador**, así que técnicamente siempre se podría ver algo con las herramientas de desarrollador del navegador (clic derecho → "Inspeccionar").

Pero en este caso tuvimos más suerte: el proyecto es un trabajo académico y su código está **publicado abiertamente en GitHub** (una plataforma donde los programadores guardan y comparten su código). Así que en vez de andar mirando pedacito por pedacito desde el navegador, simplemente **descargamos una copia completa del proyecto** a la computadora:

```bash
git clone https://github.com/code-sena/design-software-mockup.git
```

Esto es como si, en vez de espiar el motor del carro por una rendija, alguien te prestara el manual técnico completo con todos los planos. A partir de acá ya no estamos adivinando: estamos **leyendo directamente lo que el programador escribió**.

> **Nota para cuando no tengan tanta suerte:** si el código de un proyecto no es público, todavía se puede investigar bastante desde el navegador, con la pestaña "Elementos" o "Sources" de las herramientas de desarrollador. Solo que ahí tienes que armar el rompecabezas con piezas sueltas, en vez de tener el mapa completo de una vez.

---

## 3. Paso 3 — Mirar cómo están organizadas las carpetas (antes de leer nada de lógica)

Antes de ponerte a leer código, lo primero que conviene hacer es **mirar cómo están organizadas las carpetas y archivos del proyecto**, igual que cuando entras a una casa nueva y primero recorres cuáles son las habitaciones antes de empezar a abrir cajones.

Así se ve el "mapa de la casa" de este proyecto:

```text
design-software-mockup/
└── app/
    ├── index.html            ← la "puerta de entrada" de toda la página
    ├── README.md              ← documento donde explican el proyecto
    ├── assets/                ← colores, estilos, iconos, piezas visuales reutilizables
    ├── data/                  ← los "datos falsos" que usa la página (no hay base de datos real)
    ├── shell/                 ← el "cascarón": el menú, la barra de arriba, y quién decide qué se muestra
    ├── iam/, scheduling/, academic/, environment/, actors/,
    │   document/, monitoring/, audit/, reference/     ← una carpeta por cada "tema" del sistema
    ├── tools/                 ← scripts para comprobar que nada esté roto
    └── screenshots/           ← capturas de pantalla guardadas como evidencia
```

Solo con ver esto, **ya podemos sacar conclusiones sin haber leído una sola línea de código todavía**:

- Hay una carpeta por cada "tema" del sistema (horarios, usuarios, documentos, auditoría, etc.), no por tipo de archivo. Eso quiere decir que el proyecto está pensado como si cada tema fuera casi un mini-programa aparte, y no como una sola bolsa gigante de archivos mezclados. Es como si en una casa, en vez de tener "el cuarto de los muebles" y "el cuarto de la ropa", tuvieras un cuarto completo por persona, con su propia ropa y sus propios muebles adentro.
- Hay una carpeta `shell/` que parece ser el "esqueleto" que sostiene a todas las demás — como el pasillo de la casa que conecta todas las habitaciones.
- Hay una carpeta `tools/` con algo para "comprobar que nada esté roto" — eso nos dice que quien hizo esto se preocupó por verificar su propio trabajo, no solo por que "se viera bien".

---

## 4. Paso 4 — Encontrar por dónde arranca todo, y en qué orden se prende cada pieza

Todo programa tiene un punto de partida: el primer archivo que se ejecuta. En una página web casi siempre es el archivo `index.html`. Ahí adentro, el HTML le dice al navegador: *"antes de mostrar algo, primero carga estos archivos de JavaScript, en este orden exacto"*.

Ese orden **no es casualidad, es una lista de dependencias**: es como una receta de cocina donde primero tienes que picar la cebolla antes de poder sofreírla. Si un archivo necesita usar algo que otro archivo define, ese segundo archivo tiene que cargarse primero.

Siguiendo el orden real en el que este proyecto carga sus archivos, encontramos esta "receta":

```text
1º  Se cargan los iconos (los dibujitos que se usan en toda la página).
2º  Se cargan los "datos falsos" (la información inventada de horarios, usuarios, etc.).
3º  Se cargan las "piezas reutilizables" (tablas, botones, tarjetas) — porque estas piezas
    usan los iconos del paso 1, así que necesitan que ya existan.
4º  Se carga el mapa de rutas/direcciones de la página.
5º  Se cargan, una por una, las pantallas de cada tema (horarios, usuarios, documentos...).
6º  Se carga el "cascarón" — el menú de arriba y el de al lado — porque necesita usar
    los datos falsos y las piezas reutilizables que ya se cargaron antes.
7º  Al final se carga el "director de orquesta": el que decide qué mostrar según la
    dirección que escribiste en el navegador.
```

**Analogía sencilla:** es como armar una hamburguesa. Primero tienes que tener listo el pan, la carne y las verduras (los "ingredientes base"), y solo al final las juntas y armas la hamburguesa completa (el "director de orquesta"). Si intentas armar la hamburguesa antes de tener los ingredientes, no tienes nada que armar.

Un detalle interesante: **este proyecto no usa ningún framework moderno** (como React o Angular, que seguro escucharon nombrar). Está hecho con JavaScript "puro", cargado directamente con etiquetas `<script>`, sin ningún paso extra de "compilación". Esto es una decisión a propósito: como es un mockup para revisar (no una app que va a estar en producción con miles de usuarios), lo importante era que cualquiera pudiera abrirlo fácil, sin instalar nada complicado.

---

## 5. Paso 5 — Entender las 3 piezas más importantes: el "director de orquesta", los datos falsos, y quién ve qué

Toda la lógica del proyecto gira alrededor de tres piezas. Vamos a explicarlas con analogías antes de mostrar el código, para que quede clarísimo qué hace cada una.

### 5.1 El "director de orquesta" (el router)

Imagínate un **recepcionista de un edificio con varios pisos y varias oficinas**. Cada vez que alguien llega y dice "quiero ir a tal oficina", el recepcionista hace tres cosas:

1. Revisa si esa oficina existe. Si no existe, te dice "esa oficina no existe" (eso es lo que en programación se llama un error **404**).
2. Revisa tu carnet/gafete para saber si tienes permiso de entrar a esa oficina. Si no tienes permiso, te dice "no puedes entrar aquí" (eso es un error **403**).
3. Si todo está bien, te acompaña hasta la oficina correcta y prende las luces.

Ese recepcionista, en este proyecto, es un archivo llamado `app.js`. Cada vez que cambias de sección en la página (cada vez que cambia lo que hay después del `#` en la dirección), este archivo:

- Lee hacia dónde quieres ir.
- Revisa si esa "oficina" (pantalla) existe.
- Revisa qué **rol** tienes (coordinador, instructor, aprendiz, etc.) — y ese rol se guarda en la memoria del navegador (algo llamado `localStorage`, que es literalmente como un cajón donde el navegador guarda notitas que no se borran aunque cierres la pestaña).
- Si tu rol no tiene permiso para esa pantalla, te muestra un letrero de "no tienes acceso" (el 403).
- Si sí tienes permiso, te muestra la pantalla correcta, y además le pone alrededor el mismo "marco" de siempre: el menú de arriba y el menú lateral.

Aquí está el pedacito de código real que hace justo eso — no hace falta entenderlo letra por letra, solo mira cómo cada línea de comentario que pusimos al lado coincide con lo que explicamos arriba:

```js
function route(){
  const parsed = parseHash();              // ¿a dónde quiere ir el usuario?
  const activeRole = role();                 // ¿qué rol tiene guardado?
  const found = matchRoute(parsed.path);     // ¿esa pantalla existe?

  if (!found) { renderSystem(ctx, '404'); return; }  // no existe -> mostrar error 404

  if (!found.route.public && !found.route.roles.includes(activeRole)) {
    renderSystem(ctx, '403'); return;        // existe, pero no tienes permiso -> error 403
  }

  const screen = M.screens[found.route.screen]; // buscar la pantalla correcta
  const content = screen(ctx);                   // "construir" esa pantalla
  root.innerHTML = M.renderShell(ctx, content);   // ponerla en pantalla con su marco
}
```

**Un detalle curioso:** cuando abres una ventanita (un modal) o el panel de notificaciones, eso también queda guardado en la dirección del navegador (por ejemplo `?modal=session`). Esto tiene una ventaja genial: si le mandas esa dirección exacta a un compañero, a él se le va a abrir la página **con esa misma ventanita ya abierta**. Es un truco simple pero muy inteligente.

### 5.2 El mapa de "quién puede ir a dónde" (las rutas y los roles)

Siguiendo con la analogía del edificio: en algún lado tiene que existir **una lista maestra** que diga "la oficina 301 es de Recursos Humanos, y solo pueden entrar los empleados de RRHH". Esa lista, en este proyecto, vive en un archivo llamado `routes.js`.

Ahí hay una lista con las **53 pantallas** del sistema, cada una con su nombre, a qué tema pertenece, y qué rol puede verla. Por ejemplo:

- El **Coordinador** puede ver "Horarios", "Disponibilidad" y "Fichas".
- El **Instructor** solo ve "Mi horario" y "Mi disponibilidad".
- El **Aprendiz** solo ve "Mi horario" y "Notificaciones".
- El **Director** ve "Indicadores", "Usuarios" y "Parametrización".

Esto es exactamente el mismo concepto que un colegio: un estudiante no puede entrar a la sala de profesores, aunque ambos estén en el mismo edificio. El "carnet" (el rol) determina qué puertas se abren para ti.

### 5.3 Los "datos falsos" (la base de datos que en realidad no existe)

Aquí viene algo importante de entender: **esta página no tiene un servidor de verdad guardando información**. Todo lo que ves —los horarios, los nombres de instructores, las notificaciones— **está escrito directamente dentro de un archivo de JavaScript**, como si fuera una lista fija que alguien escribió a mano.

Es literalmente como si, en vez de tener una base de datos de verdad, alguien hubiera escrito en un papel:

```
Horario 1: Ficha 2874412, "ADSO — Trimestre III", Borrador
Horario 2: Ficha 3011550, "Contabilidad básica", En revisión
...
```

Y ese "papel" (el archivo `mock-data.js`) es lo único que la página consulta cuando necesita mostrar información. No hay internet de por medio, no hay una base de datos real: todo vive dentro del mismo archivo que ya se descargó al navegador desde el principio.

**¿Por qué hacerlo así?** Porque este proyecto es un **mockup**, es decir, una *maqueta* — algo para mostrar cómo se vería y se comportaría el sistema final, sin tener que construir de verdad todo lo complicado (servidores, bases de datos, seguridad real). Es como las maquetas de arquitectura: se ven como una casa, pero no tienen tuberías de verdad por dentro.

---

## 6. Paso 6 — Descubrir el "molde" que se repite en todas las pantallas

Cuando un proyecto tiene 53 pantallas distintas, sería una locura leerlas todas una por una. El truco de un desarrollador con experiencia es: **leer solo una o dos pantallas completas, con atención, para descubrir el "molde" que seguramente se repite en todas las demás.**

Al leer con calma una sola pantalla (la del panel principal del Coordinador), se nota que **todas las pantallas siguen exactamente los mismos 4 pasos**:

1. **Preguntarse:** "¿me pidieron mostrar algo especial, como una pantalla de carga o de error?" Si sí, mostrar eso y ya.
2. **Buscar en los "datos falsos"** la información que esa pantalla necesita (por ejemplo, la lista de conflictos pendientes).
3. **Armar el contenido** usando siempre las mismas "piezas de lego" reutilizables: una tabla, una tarjeta, un botón, una etiqueta de estado — nunca inventando una tabla nueva desde cero.
4. **Entregar el resultado** como un pedazo de HTML, que el "director de orquesta" (el router) se encarga de poner en pantalla.

Es exactamente como armar con bloques de LEGO: si tienes 20 piezas base (una tabla, un botón, una tarjeta), puedes construir 53 modelos distintos combinándolas de formas distintas, sin tener que inventar una pieza nueva cada vez. Eso es justo lo que hace este proyecto con sus "componentes reutilizables" — y por eso, aunque hay 53 pantallas, **todas se ven visualmente coherentes entre sí**: usan los mismos botones, los mismos colores, las mismas tablas.

---

## 7. Paso 7 — Buscar pruebas de que el sistema realmente funciona (no solo confiar en lo que dicen)

Cuando alguien te dice "mi proyecto funciona perfecto", lo sano es no creerle de inmediato, sino **buscar evidencia**. En este proyecto encontramos algo muy valioso: un archivito (`validate-routes.js`) que **agarra las 53 pantallas, una por una, y las manda a construir automáticamente**, para comprobar que ninguna se rompa ni quede vacía.

Es como si, antes de entregar 53 puertas recién instaladas en un edificio, alguien pasara por cada una **abriéndola y cerrándola de verdad** para comprobar que ninguna esté trabada, en vez de solo mirarlas de lejos y asumir que funcionan.

Esto se puede ejecutar así, y muestra en la pantalla si alguna pantalla falló:

```bash
node tools/validate-routes.js
```

**Lección importante:** cuando un documento (como el README) *dice* que algo funciona, siempre es mejor buscar si hay una forma de comprobarlo de verdad, en vez de creerlo a ciegas. Aquí sí existe esa forma, y por eso podemos confiar más en esa afirmación.

---

## 8. Paso 8 — Anotar lo que quedó "a medias" (y no fingir que todo está resuelto)

Algo que distingue una buena investigación de una apurada es **no barrer bajo la alfombra las cosas que no están completas**. En el propio README del proyecto, sus autores fueron honestos y dejaron anotado que hay 4 cosas que **no terminaron de resolver de verdad**, y que en vez de inventar una solución falsa, dejaron una notita tipo "pendiente" (`TODO`) en el código:

- La sección de auditoría no tiene, en el fondo, una forma real de conectarse a un sistema externo para traer esos datos.
- Un permiso específico para que el aprendiz consulte su propia información no quedó del todo conectado.
- El seguimiento que hace el instructor necesitaría un permiso más alto del que el sistema define hoy.
- No existe todavía una forma consolidada de consultar qué instructores están disponibles.

**¿Por qué esto es importante para nosotros como investigadores?** Porque alguien que revise la página por encima podría pensar "ah, esta función ya existe" solo porque ve una pantalla bonita para eso. Pero al leer el código con cuidado, uno se da cuenta de que **la pantalla existe, pero por debajo la lógica está incompleta a propósito**. Diferenciar "lo que se ve" de "lo que realmente funciona por debajo" es, quizás, la habilidad más importante de todo este ejercicio.

---

## 9. Resumen de la arquitectura reconstruida

```
┌─────────────────────────────────────────────────────────┐
│                     index.html (entry)                   │
└───────────────────────┬───────────────────────────────────┘
                         │ carga en orden
                         ▼
  icons.js → mock-data.js → components.js → routes.js →
  [9 módulos de dominio]/screens.js → shell/screens.js →
  shell/shell.js → shell/app.js (router, arranca al final)
                         │
                         ▼
        window.Mockup = { icon, data, Components,
                           inventory, routeDefinitions,
                           navByRole, screens, renderShell,
                           homeForRole }
                         │
         evento `hashchange` / `DOMContentLoaded`
                         ▼
                  app.js → route()
       ┌─────────────┴─────────────┐
       │ 1. parsear hash            │
       │ 2. resolver rol (localStorage)
       │ 3. hacer match de ruta (regex)
       │ 4. aplicar guard RBAC (403/404)
       │ 5. ejecutar screen(ctx) → HTML string
       │ 6. envolver con shell (topbar+sidebar) si aplica
       │ 7. inyectar en <div id="app"> vía innerHTML
       │ 8. re-bindear listeners de eventos
       └────────────────────────────┘
```

**Patrones de arquitectura identificados (con nombre técnico):**
- **Hash-based SPA Router** implementado a mano.
- **RBAC (Role-Based Access Control)** con guard centralizado.
- **Micro-frontend-like** (organización por dominio, "screens registry" compartido).
- **Design Token System** (CSS custom properties centralizadas).
- **Componentes puros basados en funciones** (`ctx → HTML string`), análogo conceptual a componentes de React/Vue sin el framework.
- **Estado en URL** para UI efímera (modales, paneles, overlays) en vez de estado en memoria.
- **Mock data layer** en memoria, sin persistencia real, simulando un backend inexistente.

---

## 10. ¿Qué se le podría añadir SIN romper lo que ya existe?

Esta sección es la más importante desde el punto de vista de "desarrollador que llega a un proyecto ajeno": identificar **puntos de extensión seguros**, es decir, cambios que aprovechan la arquitectura ya existente sin tocar sus contratos internos (`M.screens`, `M.routeDefinitions`, `M.Components`, `M.data`).

### 10.1 Extensiones de bajo riesgo (aditivas, no tocan código existente)

| # | Qué añadir | Por qué es seguro | Cómo encaja en la arquitectura actual |
|---|---|---|---|
| 1 | **Nueva pantalla de dominio** (ej. "Reportes") | Solo agrega una entrada nueva a `M.screens`, `M.routeDefinitions` y `M.inventory`; no modifica ninguna existente | Crear `reports/screens.js` siguiendo el mismo patrón `(ctx) => html string`, cargarlo como script adicional |
| 2 | **Nuevo rol** (ej. "Auxiliar administrativo") | El sistema RBAC ya está parametrizado por arrays de roles en cada ruta; añadir un rol es agregar strings a esos arrays, no reescribir el guard | Añadir entrada en `userByRole`, `navByRole`, y sumar el nuevo rol a los arrays `roles:[...]` de las rutas que deba ver |
| 3 | **Nuevo componente UI** (ej. gráfico de barras simple en SVG) | `M.Components` es un objeto abierto; agregar una función nueva no afecta las 15 que ya existen | Añadir `M.Components.barChart(...)` en `components.js` o en un archivo nuevo que extienda el mismo objeto |
| 4 | **Modo oscuro (dark mode)** | Todo el color pasa por `tokens.css`; nunca hay colores hardcodeados en las pantallas | Agregar un segundo bloque `[data-theme="dark"] { --color-background: ...; }` y un botón que alterne un atributo en `<html>` |
| 5 | **Persistencia real en `localStorage`** para las acciones (crear horario, resolver conflicto) | El README ya dice que las acciones "no persisten fuera de localStorage del rol activo" — es decir, la intención de usar `localStorage` como capa de persistencia ligera ya está prevista | Interceptar los `submit` de formularios y escribir/leer arrays en `localStorage`, sin tocar el router |
| 6 | **Internacionalización (i18n)** básica (ES/EN) | Todo el texto está en template strings dentro de funciones — se podría envolver en un diccionario `t('key')` sin cambiar la estructura del router | Crear `assets/i18n.js` con un mapa de textos y una función `M.t(key)`; ir reemplazando strings literales progresivamente, pantalla por pantalla |
| 7 | **Búsqueda global (Ctrl+K / command palette)** | Es una funcionalidad nueva que solo necesita leer `M.inventory` (ya existe) para listar destinos navegables | Un modal nuevo que filtra `M.inventory` por texto y navega con `location.hash = ...` |
| 8 | **Modo "solo lectura para auditores"** (rol de solo consulta transversal) | El campo `ctx.readonly` ya existe y se usa para ocultar botones de acción (ver `director`) | Extender la condición `ctx.readonly` para incluir el nuevo rol, sin tocar la lógica de renderizado de cada pantalla |
| 9 | **Exportar el inventario de 53 pantallas a PDF/CSV** | Es solo transformar `M.inventory` (ya es un array plano de objetos) a otro formato | Botón nuevo en `#/inventory` que serialice el array a CSV con `Blob` y dispare una descarga |
| 10 | **Tests automatizados de accesibilidad** (axe-core) sobre cada pantalla | `tools/validate-routes.js` ya prueba que cada pantalla renderiza; se puede añadir una segunda pasada que analice el HTML resultante | Extender el mismo script para correr un linter de accesibilidad sobre el HTML generado, sin modificar el router ni las pantallas |

### 10.2 Extensiones de riesgo medio (requieren tocar código compartido, pero de forma controlada)

- **Conectar a un backend real**: reemplazar `M.data` estático por llamadas `fetch()` async. Riesgo: las funciones de pantalla hoy son **síncronas** (`ctx => string`), así que habría que introducir estados de carga reales (ya existe `C().state('loading')` como placeholder visual, pero no hay manejo de promesas). Es factible pero toca el contrato de `M.screens`.
- **Migrar a un framework** (React/Vue) conservando la lógica de negocio: los `screens.js` ya separan "cómo se ve" (JSX-like strings) de "qué datos necesita" — la migración sería mecánica pantalla por pantalla, pero de todas formas es una reescritura, no una extensión.

### 10.3 Lo que **no** se debería tocar sin muchísimo cuidado

- **`shell/app.js`** (el router): es el punto de mayor acoplamiento — cualquier cambio ahí afecta las 53 pantallas simultáneamente.
- **La forma de `ctx`** (los campos que recibe cada pantalla): todas las funciones de `M.screens` asumen esa forma exacta; cambiarla rompe todo a la vez.
- **`tokens.css`**: cambiar el *nombre* de una variable (no su valor) rompe silenciosamente cualquier CSS que la referencie.

---

## 11. Checklist para replicar este ejercicio con otro proyecto (para el salón)

Cuando les toque hacer esto con un proyecto distinto, sigan este orden y no se salten pasos:

- [ ] Navegar el producto terminado como usuario final, sin ver código, y tomar notas de comportamiento observable.
- [ ] Encontrar y clonar el código fuente (o, si no es público, inspeccionar vía DevTools: Sources + Network).
- [ ] Mapear el árbol de carpetas antes de leer lógica — la organización ya cuenta una historia.
- [ ] Identificar el punto de entrada y el orden real de carga de scripts/módulos.
- [ ] Leer primero el núcleo (router/estado/datos), no las pantallas — el núcleo explica las reglas que las pantallas solo aplican.
- [ ] Leer una unidad representativa de cada capa repetida (una pantalla, un componente) para inferir el patrón general; no hace falta leer las 53.
- [ ] Buscar y ejecutar cualquier evidencia automatizada (tests, scripts de validación) — es más confiable que la documentación.
- [ ] Anotar explícitamente qué es real y qué es simulado/mock — no dar por hecho que "si hay pantalla, hay backend".
- [ ] Documentar huecos, TODOs y contradicciones encontradas.
- [ ] Solo al final, proponer extensiones — y clasificarlas por riesgo según qué tan acopladas estén al núcleo.

---

## 12. Glosario rápido usado en este documento

- **SPA (Single Page Application):** aplicación web que carga un solo HTML y reescribe su contenido con JavaScript en vez de navegar a páginas nuevas.
- **Hash routing:** técnica de enrutar usando la parte de la URL después de `#` (no requiere configuración de servidor).
- **RBAC (Role-Based Access Control):** modelo de permisos donde el acceso se decide según el rol del usuario.
- **Mock data:** datos falsos, fijos en el código, que simulan lo que vendría de un backend real.
- **Design tokens:** valores de diseño (colores, espaciados, tipografía) centralizados en variables reutilizables.
- **Guard (en routing):** función que se ejecuta antes de mostrar una ruta para decidir si el usuario tiene permiso de verla.
- **Namespace global:** un único objeto (`window.Mockup`) usado como contenedor para evitar contaminar el `window` global con muchas variables sueltas.

---

*Documento generado a partir de la lectura directa del código fuente del repositorio `code-sena/design-software-mockup` (rama principal, estado al 08/08/2026). Todas las citas de código corresponden a archivos reales del repo, no a suposiciones.*
