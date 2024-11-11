# Tema 4: Manejo de Tipos de Datos JSON

JSON, que significa JavaScript Object Notation, es un formato de intercambio de datos ampliamente utilizado que se ha vuelto especialmente popular en el desarrollo web y en el manejo de datos en aplicaciones modernas.

SQL cuenta con funciones JSON nativas que permiten analizar documentos JSON con el lenguaje SQL estándar, permitiendo así almacenar documentos JSON en SQL Server y consultar datos JSON como en una base de datos NoSQL.
Una de las principales ventajas de utilizar JSON en bases de datos relacionales es su flexibilidad y capacidad para manejar datos no estructurados o semi estructurados. Esto permite a los desarrolladores almacenar y consultar datos de múltiples estructuras sin tener que preocuparse por esquemas rígidos. Además, JSON es un formato de datos ligero y legible tanto para humanos como para máquinas, lo que facilita su comprensión y manipulación.

## Formato de Almacenamiento JSON
- **Almacenamiento de LOB:** los documentos JSON se pueden almacenar tal cual en las columnas con los tipos de datos json o nvarchar. Esta es la mejor manera para una carga rápida de datos, porque la velocidad de carga coincide con la de las columnas de cadena. Este enfoque podría significar una reducción adicional del rendimiento en tiempo de consulta/análisis si no se realiza la indexación en valores JSON, ya que los documenots JSON sin formato se deben analizar mientras se ejecutan las consultas.
- **Almacenamiento relacional:** los documentos JSON se pueden analizar mientras se insertan en la tabla con las funciones OPENJSON, JSON_VALUE o JSON_QUERY. Es posible almacenar fragmentos de los documentos JSON de entrada en las columnas que contienen subelementos JSON con tipos de datos json o nvarchar. Este enfoque aumenta el tiempo de carga, porque el análisis de JSON se realiza durante la carga. Sin embargo, las consultas coinciden con el rendimiento de las consultas clásicas en los datos relacionales.


# Desarrollo del TEMA 4
- Crear una nueva tabla con una columna JSON

![tabla_JSON](/script/tema04_manejo_de_tipos_de_datos_JSON/tema04_img/tabla_JSON.png) 

- Agregar un conjunto de datos no estructurados en formato JSON, y realizar operaciones de actualización, agregación y borrado de datos.

![datos_JSON](/script/tema04_manejo_de_tipos_de_datos_JSON/tema04_img/datos_JSON.png) 


- Realizar operaciones de consultas.
  
![consultas_JSON](/script/tema04_manejo_de_tipos_de_datos_JSON/tema04_img/consultas_JSON.png) 


- Aproximaciones a la optimización de consultas para estas estructuras

#### Optimización del rendimiento al trabajar con datos JSON:

Para optimizar el rendimiento al trabajar con datos JSON, es importante considerar algunos aspectos clave. Esto incluye indexación adecuada en columnas JSON mediante índices filtrados, que permiten acelerar la recuperación de datos específicos dentro de objetos o matrices JSON.

Además, debemos evitar consultas y operaciones costosas en datos JSON. Es importante evaluar el impacto de las consultas de navegación y filtrado complejas, y crear consultas eficientes utilizando las herramientas y funciones adecuadas proporcionadas por SQL Server.

Supongamos la tabla Ciudad posee 1 millón de registros, y solo queremos encontrar las ciudades donde la población (dentro del JSON en detalles) es mayor a 400,000. Sin un índice, SQL Server tendría que leer cada fila, extraer el valor de poblacion desde el JSON y verificar la condición en cada caso. Esto sería lento. 
Con un índice en poblacion_calculada, SQL Server hace lo siguiente:
Utiliza el índice para localizar las filas que cumplen con poblacion_calculada > 400000 sin tener que leer cada fila de la tabla, y, una vez localizadas, SQL Server accede directamente a las filas y obtiene sus datos.
Esto mejora el rendimiento de la consulta porque el índice permite localizar rápidamente los valores deseados sin revisar todos los registros, lo cual es especialmente útil para tablas grandes.

![optimizacion_JSON](/script/tema04_manejo_de_tipos_de_datos_JSON/tema04_img/optimizacion_JSON.png) 

- Expresar sus conclusiones.

Como conclusión podemos afirmar que está claro que el manejo de datos JSON en SQL Server es una herramienta poderosa que permite un fácil manejo de datos no estructurados o semi estructurados, pero no son tan eficientes como los datos estructurados.
La indexación a través de columnas calculadas no es tan eficiente como los índices convencionales, especialmente en tablas con muchos registros. Además, si el campo JSON tiene una gran cantidad de campos internos, resulta poco práctico crear índices para cada uno.
