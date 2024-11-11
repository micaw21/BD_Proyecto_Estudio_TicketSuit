# Tema 4: Manejo de Tipos de Datos JSON

JSON, que significa JavaScript Object Notation, es un formato de intercambio de datos ampliamente utilizado que se ha vuelto especialmente popular en el desarrollo web y en el manejo de datos en aplicaciones modernas.

SQL cuenta con funciones JSON nativas que permiten analizar documentos JSON con el lenguaje SQL estándar, permitiendo así almacenar documentos JSON en SQL Server y consultar datos JSON como en una base de datos NoSQL.
Una de las principales ventajas de utilizar JSON en bases de datos relacionales es su flexibilidad y capacidad para manejar datos no estructurados o semi estructurados. Esto permite a los desarrolladores almacenar y consultar datos de múltiples estructuras sin tener que preocuparse por esquemas rígidos. Además, JSON es un formato de datos ligero y legible tanto para humanos como para máquinas, lo que facilita su comprensión y manipulación.

## Formato de Almacenamiento JSON
- **Almacenamiento de LOB:** los documentos JSON se pueden almacenar tal cual en las columnas con los tipos de datos json o nvarchar. Esta es la mejor manera para una carga rápida de datos, porque la velocidad de carga coincide con la de las columnas de cadena. Este enfoque podría significar una reducción adicional del rendimiento en tiempo de consulta/análisis si no se realiza la indexación en valores JSON, ya que los documenots JSON sin formato se deben analizar mientras se ejecutan las consultas.
- **Almacenamiento relacional:** los documentos JSON se pueden analizar mientras se insertan en la tabla con las funciones OPENJSON, JSON_VALUE o JSON_QUERY. Es posible almacenar fragmentos de los documentos JSON de entrada en las columnas que contienen subelementos JSON con tipos de datos json o nvarchar. Este enfoque aumenta el tiempo de carga, porque el análisis de JSON se realiza durante la carga. Sin embargo, las consultas coinciden con el rendimiento de las consultas clásicas en los datos relacionales.


# Desarrollo del TEMA 4
- Crear una nueva tabla con una columna JSON
- Agregar un conjunto de datos no estructurados en formato JSON, y realizar operaciones de actualización, agregación y borrado de datos.
- Realizar operaciones de consultas.
- Aproximaciones a la optimización de consultas para estas estructuras

#### Optimización del rendimiento al trabajar con datos JSON:

Para optimizar el rendimiento al trabajar con datos JSON, es importante considerar algunos aspectos clave. Esto incluye indexación adecuada en columnas JSON mediante índices filtrados, que permiten acelerar la recuperación de datos específicos dentro de objetos o matrices JSON.

Además, debemos evitar consultas y operaciones costosas en datos JSON. Es importante evaluar el impacto de las consultas de navegación y filtrado complejas, y crear consultas eficientes utilizando las herramientas y funciones adecuadas proporcionadas por SQL Server.

- Expresar sus conclusiones.
