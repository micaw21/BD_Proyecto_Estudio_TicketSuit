# Tema 3: Optimizacion de Consultas a Traves de Indices

# Análisis de Índices en SQL Server

Este documento presenta un análisis comparativo de los tiempos de ejecución y costos de las consultas utilizando diferentes índices en la tabla `Compra`. Los escenarios comparados incluyen la ausencia de índices, índices agrupados por `fecha`, índices no agrupados con columnas incluidas y la combinación de ambos tipos de índices.

## Resultados

### 1) **Sin índices agrupados (Primary Key de `id_compra`)**

- **Lecturas lógicas:** 3969
- **Tiempo de CPU:** 219 ms
- **Tiempo total:** 2665 ms

**Interpretación:**
- La consulta realiza un **escaneo más costoso** de las páginas de datos, ya que el índice basado en la clave primaria (`id_compra`) no ayuda en la búsqueda por fecha.
- Aunque los tiempos son razonables para esta cantidad de datos, el costo en términos de lecturas lógicas es elevado.

---

### 2) **Índice agrupado por `fecha`**

- **Lecturas lógicas:** 2876
- **Tiempo de CPU:** 187 ms
- **Tiempo total:** 2687 ms

**Interpretación:**
- El índice agrupado mejora la **eficiencia de las lecturas** al reducir las páginas accedidas, ya que organiza físicamente los datos en el orden de `fecha`. 
- El tiempo total es similar al escenario sin índice agrupado, posiblemente debido a la sobrecarga inicial en el manejo del índice.

---

### 3) **Índice no agrupado con columnas incluidas (`fecha`, `subtotal`, `cantidad`)**

- **Lecturas lógicas:** 4951
- **Tiempo de CPU:** 282 ms
- **Tiempo total:** 2764 ms

**Interpretación:**
- El índice no agrupado tiene un mayor costo en **lecturas lógicas** debido al acceso adicional necesario para resolver las columnas incluidas.
- Aunque incluye las columnas utilizadas en la consulta, la estructura del índice no agrupado es menos eficiente que un índice agrupado para este caso.
- Los tiempos son marginalmente más altos, indicando que este índice es menos óptimo para consultas basadas en `fecha`.

---

### EXTRA) **Índice agrupado por `fecha` + Índice no agrupado (con columnas incluidas)**

- **Lecturas lógicas:** 2876 (idéntico al índice agrupado por fecha)
- **Tiempo de CPU:** 203 ms
- **Tiempo total:** 2697 ms

**Interpretación:**
- Al mantener ambos índices, el motor de SQL eligió utilizar el índice agrupado por `fecha`, ignorando el índice no agrupado.
- Las métricas son prácticamente las mismas que en el escenario 2, confirmando que el índice agrupado es más adecuado para esta consulta.

---

## **Conclusión**

1. **Sin índices agrupados:** Este escenario resulta en un costo de lecturas más alto (3969) debido al escaneo completo de la tabla. No es eficiente para consultas específicas basadas en fechas.
2. **Índice agrupado por `fecha`:** Proporciona el mejor balance en términos de lecturas lógicas y tiempos de CPU para consultas basadas en `fecha`. Es el índice más adecuado para este caso.
3. **Índice no agrupado con columnas incluidas:** Aunque incluye columnas adicionales en el índice, es menos eficiente para consultas como esta, debido a un mayor número de lecturas lógicas (4951).
4. **Índice combinado:** Al combinar ambos índices, el motor opta por el índice agrupado, indicando que un solo índice agrupado por `fecha` es suficiente para optimizar esta consulta.

- **Especificaciones del equipo utilizado para las Pruebas:** CPU: Ryzen 5 3600x, RAM: 16gb 3200Mhz, Toshiba 1TB Disk.
- **Especificaciones del programa:** SSMS 2022.
