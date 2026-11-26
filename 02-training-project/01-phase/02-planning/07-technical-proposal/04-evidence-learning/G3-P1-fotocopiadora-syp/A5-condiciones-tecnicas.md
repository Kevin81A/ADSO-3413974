# A5 · Estimación de condiciones técnicas

Derivadas de la variante A y del caso. Las mismas cifras se usan en las fichas ([A1-A2](A1-A2-fichas-tecnicas.md)), las licencias ([A4](A4-licencias.md)) y los costos ([A6](A6-estimacion-economica.xlsx)).

| # | Parámetro | Valor | Fórmula o supuesto |
|---|---|---|---|
| 1 | Usuarios totales / concurrentes | 60 / 15 | Variante A. Concurrencia = 25 % de los usuarios (60 × 0,25 = 15) |
| 2 | Almacenamiento inicial | ≈ 120 MB → se contratan **2 GB** de disco | Imágenes: 200 productos × 300 KB = 60 MB · fichas PDF: 50 × 1 MB = 50 MB · base de datos inicial ≈ 10 MB · más 10 copias de respaldo locales; 2 GB es el mínimo práctico con holgura |
| 3 | Crecimiento anual de almacenamiento | ≈ 70 MB/año | Pedidos: 60 clientes × 4 pedidos/mes × 12 = 2.880 pedidos × ≈ 5 KB (con detalles) ≈ 15 MB · solicitudes y mensajes ≈ 5 MB · imágenes nuevas: 150 × 300 KB ≈ 45 MB · ≈ 0,07 GB/año: los 2 GB alcanzan para más de 3 años |
| 4 | Ancho de banda mensual | ≈ **7,2 GB/mes** | 60 usuarios × 20 sesiones/mes × 8 páginas × 1,5 MB = 14,4 GB, menos 50 % por caché del navegador y del service worker = 7,2 GB (supera los 5 GB incluidos: se pagan 2,2 GB extra) |
| 5 | Disponibilidad objetivo | **99,0 % mensual** (≤ 7,3 h de caída al mes) | Variante A: 730 h × (1 − 0,99) = 7,3 h |
| 6 | Tiempo de respuesta | Páginas ≤ 3 s (p95) · API ≤ 800 ms (p95) con 15 concurrentes | RNF-03 del SRS y capacidad de 1 instancia (A4) |
| 7 | RPO / RTO de las copias de seguridad | **RPO 24 h · RTO 4 h** | Copia diaria a las 02:00 (se pierde como máximo un día) · restaurar el archivo de base y reiniciar el servicio toma < 1 h; se dejan 4 h de margen para fallas del proveedor |
| 8 | Correos transaccionales | ≈ 600/mes | (240 pedidos × 2 correos: confirmación y cambio de estado) + 60 solicitudes de servicio + 60 recuperaciones de contraseña |

**Coherencia con las fichas:** FT-HW-01 exige ≥ 2 GB de disco y ≥ 8 GB/mes de transferencia (por encima de 7,2); FT-SW-01 exige 15 concurrentes y 99,0 %; FT-SW-02 exige ≥ 1.000 correos/mes (por encima de 600).
