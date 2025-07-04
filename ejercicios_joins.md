# Ejercicios para aplicar los `joins` en SQL

1.  Crear un esquema de base de datos (modelo lógico) que contenga información de una organización editorial.
- La base de datos contendrá 4 tablas:
    - `book`, `author`, `editor`, `translator`

- La tabla `book` tiene los atributos:
    - id
    - title
    - type
    - author_id
    - editor_id
    - translator_id
- La tabla `author` tiene los atributos:
    - id
    - first_name
    - last_name
- La tabla `editor` tiene los atributos:
    - id
    - first_name
    - last_name
- La tabla `traslator` tiene los atributos:
    - id
    - first_name
    - last_name

2. Queremos mostrar los titulos de los libros junto con sus autores (es decir, el nombre y el apellido  del autor). Los títulos de los libros se almacenan en la tabla `book` y los nombres de los autores en la tabla `author`.

~~~sql
SELECT b.id, b.title, a.first_name, a.last_name
FROM book b INNER JOIN author a ON b.author_id = a.id
ORDER BY b.id;
~~~

En la sentencia `SELECT`, enumeramos las columnas que se mostrarán: id del libro, título del libro, nombre y apellido del autor. En la cláusula `FROM`, especificamos la primera tabla a unir (también denominada tabla izquierda). En la cláusula `INNER JOIN`, especificamos la segunda tabla a unir (también denominada tabla derecha).

A continuación, utilizaremos la palabra clave `ON` para indicar a la base de datos qué columnas deben utilizarse para cotejar los registros (es decir, la columna `author_id` de la tabla `book`y la columna `id`de la tabla `author` de la tabla).

Se debe tener en cuenta, también, que estamos utilizando *alias* para los nombres de las tablas (es decir `b` para `book` y `a` para `author`).

Asignamos los alias en las cláusulas `FROM` e `INNER JOIN` y las utilizamos en toda la consulta. Los alias de tabla reducen la escritura y hacen que la consulta sea más legible.

Tenga en cuenta que **el orden de las tablas no importa con el INNER JOIN**, o el simple JOIN. El conjunto de resultados sería exactamente el mismo si pusiéramos la tabla **`author`** en la cláusula `FROM` y la tabla **`book`** en la cláusula `INNER JOIN`.

`INNER JOIN` sólo muestra los registros que están disponibles en ambas tablas. En nuestro ejemplo, todos los libros tienen un autor correspondiente y todos los autores tienen al menos un libro correspondiente. Veamos qué ocurre si algunos de los registros no coinciden.

