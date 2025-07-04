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