# Curso Intro Big Data
## Práctica Clase PIG

1. Listar toda la información de 5 ciclistas.

```
a = LOAD 'maestro-ciclistas.csv' USING PigStorage(';') AS (id,apellido,nombre,edad);
b = LIMIT a 5;
DUMP b;
```

2. Listar sólo la edad de 5 ciclistas.

```
a = LOAD 'maestro-ciclistas.csv' USING PigStorage(';') AS
(id,apellido,nombre,edad);
b = LIMIT a 5;
c = FOREACH b GENERATE edad;
DUMP c;
```

3. Ídem el punto anterior, pero guardar la información en el directorio “edades”.

```
a = LOAD 'maestro-ciclistas.csv' USING PigStorage(';') AS
(id,apellido,nombre,edad);
b = LIMIT a 5;
c = FOREACH b GENERATE edad;
STORE c INTO 'edades';
```

4. Obtener las coordenadas geográficas de las estaciones y sus nombres y almacenarlo en “coordenadas”.

```
a = LOAD 'estaciones-bicis.csv' USING PigStorage(',')
AS (id:int, nombre:chararray, lat:double, lon:double);
co = FOREACH a GENERATE nombre, lat, lon;
STORE co INTO 'coordenadas' USING PigStorage(',');
```

5. Obtener los apellidos de los ciclistas entre 30 y 40 años.
```
a = LOAD 'maestro-ciclistas.csv' USING PigStorage(';')
AS (id:int, apellido:chararray, nombre:chararray, edad:int);
cic = FILTER a BY edad >= 30 AND edad < 40;
DUMP cic;
```

6. Listar como máximo 500 recorridos que hayan durado menos de 30 minutos.

```
a = LOAD 'recorrido-bicis.csv' USING PigStorage(',')
AS (cic:int, estOr:int, fecOr:datetime, estDes:int, fecDes:
datetime, dur: int);
cicDif = FILTER a BY dur < 30;
cicDif500 = LIMIT cicDif 500;
DUMP cicDif;
```

7. Listar como máximo 1000 recorridos de los ciclistas que tengan id menor a 100.

```
a = LOAD 'recorrido-bicis.csv' USING PigStorage(',')
AS (cic:int, estOr:int, fecOr:datetime, estDes:int, fecDes:
datetime, dur: int);
cicDif = FILTER a BY cic < 100;
cicDif1000 = LIMIT cicDif 1000;
DUMP cicDif;
```

8. Ídem el punto anterior pero guardar el resultado en el directorio “recorridos-idciclista100”.

```
a = LOAD 'recorrido-bicis.csv' USING PigStorage(',')
AS (cic:int, estOr:int, fecOr:chararray, estDes:int, fecDes:
chararray, dur: int);
b = FOREACH a GENERATE cic, estOr, ToDate(fecOr, 'yyyy-MM-dd
HH:mm:ss.SSS') AS fecOr, estDes, ToDate(fecDes, '
yyyy-MM-dd HH:mm:ss.SSS') AS fecDes;
cicDif = FILTER b BY cic < 100;
cicDif1000 = LIMIT cicDif 1000;
STORE cicDif1000 INTO 'recorridos-idciclista100' USING
PigStorage(',');
```

9. Obtener la cantidad de usuarios diferentes que tienen algún recorrido registrado.

```
a = LOAD 'recorrido-bicis.csv' USING PigStorage(',')
AS (cic:int, estOr:int, fecOr:datetime, estDes:int, fecDes:
datetime, dur: int);
cicDif = GROUP a BY cic;
groupCant = GROUP cicDif ALL;
cant = FOREACH groupCant GENERATE COUNT(cicDif);
DUMP cant;
```

10. Obtener la edad mínima y máxima de los ciclistas.
`a = LOAD 'maestro-ciclistas.csv' USING PigStorage(';')`

