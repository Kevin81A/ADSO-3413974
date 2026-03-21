```mermaid
flowchart LR
    A([🔵 Inicio]) --> B[📌 Definir problema de investigación]
    B --> C[❓ Formular preguntas e hipótesis]

    C --> D[🧠 Elegir tipo de investigación]
    D --> D1{¿Qué tipo?}
    D1 -->|Cuantitativa| E[📊 Datos numéricos]
    D1 -->|Cualitativa| F[🧾 Datos descriptivos]

    E --> G[🧩 Seleccionar instrumento]
    F --> G

    %% Instrumentos
    G --> G1[1. Encuestas]
    G --> G2[2. Entrevistas]
    G --> G3[3. Observación]
    G --> G4[4. Grupos focales]
    G --> G5[5. Análisis documental]

    %% Aplicación
    G1 --> H[📋 Aplicar cuestionarios]
    G2 --> I[🎤 Realizar entrevistas]
    G3 --> J[👀 Observar comportamientos]
    G4 --> K[👥 Realizar discusión grupal]
    G5 --> L[📚 Revisar documentos]

    %% Recolección de datos
    H --> M[📥 Recolección de datos]
    I --> M
    J --> M
    K --> M
    L --> M

    %% Validación
    M --> N[🛠️ Verificar calidad del instrumento]
    N --> N1[✔ Validez]
    N --> N2[✔ Confiabilidad]
    N --> N3[✔ Objetividad]
    N --> N4[✔ Claridad]

    %% Análisis
    N --> O[📊 Análisis de datos]
    O --> P[📈 Interpretación de resultados]

    %% Resultado final
    P --> Q[✅ Conclusiones]
    Q --> R[📚 Toma de decisiones]
    R --> S([🏁 Fin])

    %% Estilos
    style A fill:#2E7D32,color:#fff
    style S fill:#2E7D32,color:#fff
    style D1 fill:#1565C0,color:#fff
    style G fill:#6A1B9A,color:#
