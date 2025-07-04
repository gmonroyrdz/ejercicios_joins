# Ejercicios para aplicar los `joins` en SQL

## INNER JOIN

### Ejemplo 1
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


### Ejemplo 2

En nuestro segundo ejemplo, mostraremos los libros junto con sus traductores (es decir, el apellido del traductor). Sólo la mitad de nuestros libros han sido traducidos y, por tanto, tienen un traductor correspondiente. Por lo tanto, ¿cuál sería el resultado de unir las etiquetas **`book`** y **`translator`** utilizando `INNER JOIN`?

~~~sql
SELECT b.id, b.title, b.type, t.last_name AS translator FROM book b  JOIN translator t ON b.translator_id = t.id ORDER BY b.id;
~~~

|   |   |   |   |
|---|---|---|---|
|id|title|type|translator|
|2|Your Trip|translated|Weng|
|5|Oranges|translated|Davies|
|6|Your Happy Life|translated|Green|
|7|Applied AI|translated|Edwards|

La consulta da como resultado sólo los libros que han sido traducidos. He añadido la columna de tipo para que quede claro. El resto de los libros no se han podido emparejar con la tabla **`translator`** tabla y por lo tanto no se muestran. Así es como funciona `INNER JOIN`.

Además, tenga en cuenta que en el segundo ejemplo hemos utilizado `JOIN` en lugar de la palabra clave `INNER JOIN`. No tiene ningún impacto en el resultado porque `INNER JOIN` es el tipo de unión por defecto en SQL.

Bien. Ahora sabemos cómo unir tablas cuando necesitamos que sólo se muestren los registros coincidentes. Pero, ¿qué pasa si queremos mantener todos los libros en el conjunto resultante sin cortar la tabla sólo a los libros traducidos? ¡Es hora de aprender sobre las uniones externas!

## LEFT JOIN

Comenzaremos nuestra visión general de las uniones OUTER con el `LEFT JOIN`. Debería aplicar este tipo de *JOIN SQL* cuando quiera **mantener todos los registros de la tabla izquierda y sólo los registros coincidentes de la tabla** derecha.

### Ejemplo 3

Por ejemplo, digamos que queremos mostrar información sobre el autor y el traductor de cada libro (es decir, sus apellidos). También queremos mantener la información básica de cada libro (es decir, `id`, `title`, y `type`).

Para obtener todos estos datos, tendremos que unir tres tablas **`book`** para la información básica de los libros, **`author`** para los apellidos de los autores, y **`translator`** para los apellidos de los traductores.

Como hemos visto en el ejemplo anterior, el uso de `INNER JOIN` (o de un simple `JOIN`) para unir la tabla **`translator`** hace que se pierdan todos los registros de los libros originales (no traducidos). Eso no es lo que queremos ahora. Así que, para mantener todos los libros en el conjunto de resultados, uniremos el **`book`**, **`author`**y **`translator`** utilizando la tabla `LEFT JOIN`.

~~~sql
SELECT b.id, b.title, b.type, a.last_name AS author, t.last_name AS translator FROM book b LEFT JOIN authors a ON b.author_id = a.id LEFT JOIN translator t ON` `b.translator_id = t.id ORDER BY b.id;
~~~

Observe que empezamos con la tabla **`book`** en la cláusula `FROM`, convirtiéndola en la **tabla de la izquierda**. Esto es porque queremos mantener todos los registros de esta tabla. El orden de las otras tablas no importa.

En nuestra consulta, primero `LEFT JOIN` la tabla **`author`** basándonos en la columna `author_id` de la tabla **`book`** y la columna `id` de la tabla **`author`** de la tabla. A continuación, unimos la tabla **`translator`** tabla basándonos en la columna `translator_id` de la tabla **`book`** y la columna `id` de la tabla **`translator`** tabla.

Esta es la tabla resultante:

|   |   |   |   |   |
|---|---|---|---|---|
|id|title|type|author|translator|
|1|Time to Grow Up!|original|Writer|NULL|
|2|Your Trip|translated|Dou|Weng|
|3|Lovely Love|original|Brain|NULL|
|4|Dream Your Life|original|Writer|NULL|
|5|Oranges|translated|Savelieva|Davies|
|6|Your Happy Life|translated|Dou|Green|
|7|Applied AI|translated|Smart|Edwards|
|8|My Last Book|original|Writer|NULL|

Hemos obtenido todos los libros.

Observe los valores de `NULL` en la columna `translator`. Estos valores de `NULL` corresponden a los registros que no coinciden en la tabla **`translator`** tabla. Estos registros corresponden a libros originales sin traductores.

Esperamos que haya comprendido la intuición que hay detrás de las LEFT JOINs.

Revisemos otro ejemplo de `LEFT JOIN` para consolidar el conocimiento sobre el tema.

### Ejemplo 4

Esta vez, queremos mostrar la información básica del libro (es decir, ID y título) junto con los apellidos de los editores correspondientes. De nuevo, queremos mantener todos los libros en el conjunto de resultados. Entonces, ¿cuál sería la consulta?

~~~sql
SELECT b.id, b.title, e.last_name AS editor FROM book b LEFT JOIN editor e ON b.editor_id = e.id ORDER BY b.id;
~~~

|   |   |   |
|---|---|---|
|id|title|editor|
|1|Time to Grow Up!|Brown|
|2|Your Trip|Johnson|
|3|Lovely Love|Roberts|
|4|Dream Your Life|Roberts|
|5|Oranges|Wright|
|6|Your Happy Life|Johnson|
|7|Applied AI|Evans|
|8|My Last Book|NULL|

Volvemos obtener todos los libros en el conjunto de resultados, incluido el último, que no tiene un editor correspondiente en nuestra base de datos (observe el valor `NULL` en la última fila).

Podemos imaginar que el editor no está presente en la tabla de nuestros editores actuales simplemente porque dejó la editorial después de editar el libro.

¿Y si tenemos algunos editores en el equipo que aún no han publicado ningún libro? Comprobémoslo con el siguiente tipo de join externo

## RIGHT JOIN

`RIGHT JOIN` es muy similar a `LEFT JOIN`. Apuesto a que ha adivinado que la única diferencia es que `RIGHT JOIN` **mantiene todos los registros de la tabla derecha, incluso si no pueden coincidir con la tabla izquierda**. Si lo hizo, ¡está en lo cierto!

### Ejemplo 5

Repitamos nuestro ejemplo anterior, pero esta vez, nuestra tarea será conservar todos los registros de la tabla **`editor`** tabla. Así, tendremos la misma consulta que en _el ejemplo nº 4_, salvo que sustituimos `LEFT JOIN` por `RIGHT JOIN`:

~~~sql
SELECT b.id, b.title, e.last_name AS editor 
FROM book b
RIGHT JOIN editor e ON b.editor_id = e.id 
ORDER BY b.id;
~~~

|   |   |   |
|---|---|---|
|id|title|editor|
|1|Time to Grow Up!|Brown|
|2|Your Trip|Johnson|
|3|Lovely Love|Roberts|
|4|Dream Your Life|Roberts|
|5|Oranges|Wright|
|6|Your Happy Life|Johnson|
|7|Applied AI|Evans|
|NULL|NULL|Jones|
|NULL|NULL|Smith|

Con sólo una palabra cambiada en la consulta, el resultado es muy diferente. Podemos ver que efectivamente tenemos dos editores_(Jones_ y _Smith_) que no tienen libros correspondientes en nuestra base de datos. Parece que hay nuevas contrataciones.

Y ese no es el único cambio. Tampoco tenemos _Mi último libro_ en el conjunto de resultados. Este registro de la tabla izquierda (es decir **`book`**) no se encontró en la tabla de la derecha (es decir **`editor`**) y no llegó al resultado final.

Los RIGHT JOINs son raramente utilizados en la práctica porque normalmente pueden ser reemplazados por los LEFT JOINs que son mucho más comunes.

Por ejemplo, en nuestro caso, podríamos tomar nuestra consulta del ejemplo 4 y simplemente intercambiar **`book`** y **`editor`** poniendo **`editor`** en la cláusula `FROM`, convirtiéndola en la _tabla de la izquierda_, y poniendo **`book`** en la cláusula `LEFT JOIN`, convirtiéndola en la tabla _de_ la derecha. El resultado habría sido el mismo que el de la tabla anterior.

## JOIN COMPLETO

Aquí llegamos al último tipo de join externo, que es `FULL JOIN`. Utilizamos `FULL JOIN` cuando queremos **mantener todos los registros de todas las tablas**, incluso los que no coinciden. Por lo tanto, es como `LEFT JOIN` y `RIGHT JOIN` combinados. Vayamos directamente a los ejemplos para ver cómo funciona en la práctica.

### Ejemplo 6

Para empezar, vamos a unir de nuevo las tablas **`book`** y **`editor`** pero esta vez mantendremos todos los registros de ambas tablas. Simplemente utilizamos `FULL JOIN` como palabra clave de unión, dejando el resto de la consulta sin ningún cambio:

~~~sql
SELECT b.id, b.title, e.last_name AS editor FROM book b FULL JOIN editor e ON b.editor_id = e.id ORDER BY b.id;
~~~


|   |   |   |
|---|---|---|
|id|title|editor|
|1|Time to Grow Up!|Brown|
|2|Your Trip|Johnson|
|3|Lovely Love|Roberts|
|4|Dream Your Life|Roberts|
|5|Oranges|Wright|
|6|Your Happy Life|Johnson|
|7|Applied AI|Evans|
|8|My Last Book|NULL|
|NULL|NULL|Jones|
|NULL|NULL|Smith|

Se ve muy bien. Como era de esperar, conservamos todos los libros, incluso los que no tienen un editor correspondiente. También conservamos todos los editores, incluso los que aún no tienen ningún libro correspondiente.

Tenga en cuenta que **el orden de las tablas no importa con** **`FULL JOIN`**. El resultado sería el mismo si intercambiáramos las tablas poniendo la tabla **`editors`** en la cláusula `FROM` y la tabla **`books`** en la cláusula `FULL JOIN`.

### Ejemplo 7

En nuestro último ejemplo, queremos unir las cuatro tablas para obtener información sobre todos los libros, autores, editores y traductores en una sola tabla. Por lo tanto, utilizaremos `FULL JOIN` en toda nuestra consulta SQL:



~~~sql 
SELECT b.id, b.title, a.last_name AS author, e.last_name AS editor, t.last_name AS translator FROM book b FULL JOIN author a ON b.author a ON b.author_id = a.id 
FULL JOIN editor e ON b.editir_id = e.id FULL JOIN translator t ON b.translator_id = t.id ORDER BY b.id;

~~~

|   |   |   |   |   |
|---|---|---|---|---|
|id|title|author|editor|translator|
|1|Time to Grow Up!|Writer|Brown|NULL|
|2|Your Trip|Dou|Johnson|Weng|
|3|Lovely Love|Brain|Roberts|NULL|
|4|Dream Your Life|Writer|Roberts|NULL|
|5|Oranges|Savelieva|Wright|Davies|
|6|Your Happy Life|Dou|Johnson|Green|
|7|Applied AI|Smart|Evans|Edwards|
|8|My Last Book|Writer|NULL|NULL|
|NULL|NULL|NULL|Jones|NULL|
|NULL|NULL|NULL|Smith|NULL|

Como se ha solicitado, la tabla muestra todos los libros, autores, editores y traductores. Los registros que no coinciden tienen los valores de `NULL`. Esto es un gran resumen de los datos almacenados en nuestra base de datos.
