# Curso Intro Big Data
## Práctica Clase HIVE DDL

1. Crear una base de datos con el nombre Curso13  en el directorio UPBcurso dentro del directorio de usuario en HDFS y luego conectarse a ella.   
```
CREATE DATABASE IF NOT EXISTS Curso13    
LOCATION "/user/curso13/UPBcurso";     
USE Curso99;
```


2. Crear la base de datos de nombre Test13  con el comentario “base de datos de prueba” en el directorio Test en el directorio de su usuario en HDFS.
```
CREATE DATABASE Test13
COMMENT "base de datos de prueba"
LOCATION "/user/curso13/Test"
```

3. Listar las bases de datos existentes con prefijo UPB.  

`SHOW DATABASES LIKE 'UPB*';`

4. Obtener todos los datos incluidos en la creación de la bd Test13   
`DESCRIBE DATABASE Test13;`

5. Borrar la base de datos Test13

`DROP DATABASE Test13;`

6. Crear la estructura de la tabla para los 3 archivos de datos disponibles (maestro-ciclistas.csv, estaciones-bicis.csv, recorrido-bicis.csv) dentro de la BD Curso99. Las tablas deben llamarse ciclistas, estaciones y recorridos y deben tener comentarios. Tener en cuenta los delimitadores que tiene cada csv para separar los campos. Usar tipos de datos acordes a los datos brindados por los archivos csv. Para ciclistas y estaciones tomar los nombres de campos de la primera fila del archivo csv. Para recorridos tomar los siguientes nombres de campos: userid, estacionorigenid, fecha_desde, estaciondestinoid, fecha_hasta, duracion

```
USE Curso13;
CREATE TABLE ciclistas (id INT, apellido STRING, nombre STRING,
edad INT)
COMMENT 'Informacion de los ciclistas'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

CREATE TABLE estaciones (id INT, nombre STRING, latitud DOUBLE,
longitud DOUBLE)
COMMENT 'Estaciones de bicis'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

CREATE TABLE recorridos (userId INT, estacionOrigenId INT,
fechaOrigen TIMESTAMP, estacionDestinoId INT, fechaDestino
TIMESTAMP, duracion INT)
COMMENT 'Recorridos de los usuarios'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;
```

7. Ver la estructura de la tabla recorridos.

```
USE Curso13;
DESCRIBE recorridos;
```

8. Crear una tabla con la misma estructura que recorridos llamada recorridos_nuevo.

```
USE Curso13;
CREATE TABLE recorridos_nuevo
LIKE recorridos;
```
9. Cambiar el tipo de dato de las columnas fechaOrigen y fechaDestino de la tabla recorridos_nuevo.
```
USE Curso13;
ALTER TABLE recorridos_nuevo
CHANGE fechaOrigen fechaOrigen STRING;
ALTER TABLE recorridos_nuevo
CHANGE fechaDestino fechaDestino STRING;
```

10. A la tabla recorridos_nuevo agregarle las columnas zona STRING y bici_id INT.

```
USE Curso13;
ALTER TABLE recorridos_nuevo
ADD COLUMNS (zona STRING, bici_id INT)
```


11. Cambiar el nombre de la tabla recorridos_nuevo a recorridos_futura.

```
USE Curso13;
ALTER TABLE recorridos_nuevo RENAME TO recorridos_futura;
```

12. Realizar un upload con Ambari File View de los archivos provistos a la su carpeta de usuario en Hadoop.

13. Cargar los datos de los archivos csv en las tablas y verificar que se visualizan los datos.
```
USE Curso13;
LOAD DATA INPATH '/user/curso99/recorridoBicis.csv'
INTO TABLE recorridos;
LOAD DATA INPATH '/user/curso99/estaciones-bicis.csv'
INTO TABLE estaciones;
LOAD DATA INPATH '/user/curso99/MaestroCiclistas.csv'
INTO TABLE ciclistas;
```



14. Crear una tabla almacenada en formato orc por cada una de las tablas del ejercicio anterior con sus datos. Llamarlas ciclistas_orc, recorridos_orc y estaciones_orc.

```
USE Curso13;
CREATE TABLE ciclistas_orc STORED AS orc
AS SELECT * FROM ciclistas;
CREATE TABLE recorridos_orc STORED AS orc
AS SELECT * FROM recorridos;
CREATE TABLE estaciones_orc STORED AS orc
AS SELECT * FROM estaciones;
```

15. Crear la tabla ciclistas60 con los ciclistas de más de 60 años.

```
USE Curso13;
CREATE TABLE ciclistas60
AS SELECT *
FROM ciclistas
WHERE edad >= 60;
```


16. A la tabla ciclistas60 agregarle también los ciclistas entre 50 y 60 años. Luego cambiarle el nombre a ciclistas50.

```
USE Curso13;
INSERT INTO TABLE ciclistas60
SELECT *
FROM ciclistas
WHERE edad >= 50 AND edad < 60;
ALTER TABLE ciclistas60 RENAME TO ciclistas50;
```


17. Crear una nueva tabla llamada recorridos_particionados, particionada por ‘anio’ y que además tenga las columnas user_id, estacionOrigenId, estacionDestinoId y duracion.

```
USE Curso13;
CREATE TABLE reco_part_anio(userId INT,
estacionOrigenId INT,
estacionDestinoId INT,
duracion INT)
PARTITIONED BY (anio INT)
STORED AS ORC;
```

18. Cargar los datos correspondientes al año 2011 de la tabla recorridos dentro de ésta tabla, respetando el particionamiento definido. La columna ‘anio’ será generada en base al año de la
columna fecha_desde de la tabla recorridos.

```
USE Curso13;
set hive.exec.dynamic.partition.mode=nonstrict;
insert into table reco_part_anio partition(anio)
select userId, estacionOrigenId, estacionDestinoId,
duracion, YEAR(fechaOrigen) as anio
from recorridos WHERE YEAR(fechaOrigen)=2011;
```

19. Cargar los datos correspondientes al año 2012 de la tabla recorridos dentro de ésta tabla, respetando el particionamiento definido. La columna ‘anio’ será generada en base al año de la columna fecha_desde de la tabla recorridos.
```
USE Curso13;
set hive.exec.dynamic.partition.mode=nonstrict;
insert into table reco_part_anio partition(anio)
select userId, estacionOrigenId, estacionDestinoId,
duracion, YEAR(fechaOrigen) as anio
from recorridos WHERE YEAR(fechaOrigen)=2012;
```


