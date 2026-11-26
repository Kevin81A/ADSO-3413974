# 4. Matriz requisito → caso de uso

Fuente de los requisitos: [`00-insumo-requisitos-srs.md`](00-insumo-requisitos-srs.md) (SRS v2.1). Solo se trazan **requisitos funcionales**; los no funcionales (RNF-01 a RNF-11) son restricciones de calidad y no generan casos de uso.

| Requisito funcional | Caso(s) de uso | ¿Cubierto? |
|---|---|---|
| RF-01 Página de inicio | CU-01 | Sí |
| RF-02.1 Listar productos | CU-01 | Sí |
| RF-02.2 Filtrar por categoría | CU-01 | Sí |
| RF-02.3 Buscar por texto | CU-01 | Sí |
| RF-02.4 Mostrar cantidad encontrada | CU-01 | Sí |
| RF-03.1 Datos del producto | CU-02 | Sí |
| RF-03.2 Seleccionar variante | CU-02 | Sí |
| RF-03.3 Mostrar disponibilidad | CU-02 | Sí |
| RF-03.4 Agregar al carrito desde la ficha | CU-04 | Sí |
| RF-03.5 Descargar ficha técnica PDF | CU-03 | Sí |
| RF-04.1 Agregar, modificar, eliminar del carrito | CU-04 | Sí |
| RF-04.2 Total en tiempo real | CU-05 (incluido por CU-04) | Sí |
| RF-04.3 Conservar carrito en la sesión | CU-04 | Sí |
| RF-04.4 Contador de artículos | CU-04 | Sí |
| RF-05.1 Datos de envío y facturación | CU-06 | Sí |
| RF-05.2 Resumen antes de confirmar | CU-05 (incluido por CU-06) | Sí |
| RF-05.3 Método de pago | CU-06, CU-07 | Sí |
| RF-05.4 Número de pedido y confirmación | CU-08 | Sí |
| RF-06.1 Registrar cliente | CU-09 | Sí |
| RF-06.2 Iniciar y cerrar sesión | CU-10 | Sí |
| RF-06.3 Recuperar contraseña | CU-11 | Sí |
| RF-06.4 Historial de pedidos | CU-12 | Sí |
| RF-06.5 Compra como invitado | CU-06 (iniciado por Visitante) | Sí |
| RF-07 Página «Nosotros» | CU-13 | Sí |
| RF-08.1 Dirección, horarios, teléfonos | CU-13 | Sí |
| RF-08.2 Mapa embebido | CU-13 | Sí |
| RF-08.3 Enlace a WhatsApp | CU-13 | Sí |
| RF-08.4 Redes sociales | CU-13 | Sí |
| RF-08.5 Formulario de contacto | CU-14 | Sí |
| RF-09.1 Pedir visita o diagnóstico | CU-15 | Sí |
| RF-09.2 Datos de la solicitud | CU-15 | Sí |
| RF-09.3 Registro y estados de la solicitud | CU-21 | Sí |
| RF-10.1 Acceso restringido por rol | CU-10 | Sí |
| RF-10.2 Gestionar productos | CU-18 | Sí |
| RF-10.3 Gestionar categorías | CU-19 | Sí |
| RF-10.4 Gestionar pedidos | CU-20 | Sí |
| RF-10.5 Gestionar solicitudes de servicio | CU-21 | Sí |
| RF-10.6 Ver mensajes de contacto | CU-22 | Sí |
| RF-10.7 Estadísticas básicas | CU-23 | Sí |
| RF-11 Navegación global y pie de página | — | **No (justificado)** |
| RF-12 Solicitar cotización | CU-16 | Sí |
| RF-13 Reportar contadores de renting | CU-17 | Sí |

## Cobertura

- Requisitos funcionales: **42**. Cubiertos por al menos un caso de uso: **41**. **Cobertura: 41 / 42 = 97,6 %** (≥ 90 %).
- **RF-11 no cubierto, justificación:** describe elementos de interfaz que aparecen en **todas** las páginas (menú, contador del carrito, pie de página). No es un objetivo que un actor persiga ni tiene inicio y fin propios; modelarlo como caso de uso crearía un caso «Navegar sitio» asociado a todo. Se trata como **requisito de interfaz** y se verifica en el prototipo (todas las pantallas del producto 2 muestran cabecera y pie).

## Revisión en sentido inverso (caso de uso → requisito)

Todos los casos CU-01 a CU-23 traen al menos un requisito. CU-16 y CU-17 quedaron sin requisito en la primera versión de la matriz; en lugar de borrarlos, porque son funciones reales del sistema, se agregaron RF-12 y RF-13 al SRS (v2.1).
