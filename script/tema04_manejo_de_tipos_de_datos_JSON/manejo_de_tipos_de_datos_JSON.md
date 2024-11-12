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

Pude observar que las consultas que manejan datos en formato JSON tienden a tener una ligera sobrecarga de tiempo en comparación con las que no usan JSON, como se puede observar en la imagen. 

![optimizacion_JSON](/script/tema04_manejo_de_tipos_de_datos_JSON/tema04_img/optimizacion_JSON.png) 

No presentan diferencia cuando se realizan consultas simples, pero al utilizar JOIN en las consultas y además teniendo muchos registros en las tablas, se observa el tiempo extra que tarda
la tabla con JSON en ejecutar dicha consulta, a diferencia de la tabla que no posee JSON.

- Expresar sus conclusiones.

Como conclusión podemos afirmar que está claro que el manejo de datos JSON en SQL Server es una herramienta poderosa que permite un fácil manejo de datos no estructurados o semi estructurados, pero no son tan eficientes como los datos estructurados, al menos no para una base de datos con muchas tablas que poseen muchos registros ni para realizar consultas complejas, ya que se observa la sobrecarga de tiempo en la ejecución.

