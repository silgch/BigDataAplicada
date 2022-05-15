# Curso Intro Big Data  

## Práctica Clase Hive DML


1. Obtener las coordenadas geográficas de las estaciones y sus nombres.
```
USE curso13;
SELECT nombre, latitud, longitud
FROM estaciones_orc
LIMIT 10
```

2. Obtener la cantidad de usuarios diferentes que tienen algún recorrido registrado. Nombrar la columna usuarios_activos
```
USE curso13;
SELECT count(DISTINCT userid) usuarios_activos
FROM recorridos_orc
```

3. Obtener la cantidad de ciclistas y el promedio redondeado de sus edades. Las columnas deben llamarse cant_ciclistas y edad_promedio respectivamente..
```
USE curso13;
SELECT count(*) cant_ciclistas, round(avg(edad)) edad_promedio
FROM ciclistas_orc
```

4. Obtener la edad mínima y máxima de los ciclistas.
```
USE curso13;
SELECT min(edad) edad_minima, max(edad) edad_maxima
FROM ciclistas_orc
```

5. Obtener los apellidos de los ciclistas entre 30 y 40 años.

```
USE curso13;
SELECT apellido
FROM ciclistas_orc
WHERE edad >= 30 AND edad < 40
```
6. Listar los recorridos, en caso de que la duración o la fecha de destino sean NULL, mostrar el texto “Desconocida” en su columna.

```
USE curso99;
SELECT userid, estacionorigenid, fechaorigen, estaciondestinoid,
CASE WHEN fechadestino IS NULL THEN 'Desconocida'
  ELSE cast(fechadestino as STRING)
END AS fechadestino,
CASE WHEN duracion IS NULL THEN 'Desconocida'
  ELSE cast(duracion AS STRING)
END AS duracion
FROM recorridos_orc
```

7. Indicar la cantidad de ciclistas que se llamen Jose (primer o segundo nombre).   
```
USE curso13;
SELECT count(*)
FROM ciclistas_orc
WHERE nombre LIKE '%Jose%'
```
8. Obtener la sumatoria de la duración ordenado descendentemente de los recorridos para cada uno de los ids de estación origen.
```
USE curso13;
SELECT estacionorigenid, sum(duracion) duracion
FROM recorridos_orc
GROUP BY estacionorigenid
ORDER BY duracion DESC
LIMIT 10
```

9. Idem punto anterior pero devolver solo los que tengan duracion total entre 4000 y 20000.   

```
USE curso13;
SELECT estacionorigenid, sum(duracion) duracion
FROM recorridos
GROUP BY estacionorigenid
HAVING duracion >= 4000 AND duracion < 20000
ORDER BY duracion DESC
LIMIT 10
```

10. Idem punto 8 pero devolver el nombre de la estación origen en vez del id.   

```
USE curso13;
SELECT e.nombre, sum(r.duracion) duracion
FROM recorridos r JOIN estaciones e
ON r.estacionorigenid = e.id
GROUP BY e.nombre
ORDER BY duracion DESC
LIMIT 10
```

11. Obtener los nombres y apellidos de los ciclistas junto con la duración máxima de entre sus recorridos.

```
USE curso13;
SELECT c.nombre, c.apellido, max(r.duracion) duracion
FROM recorridos r JOIN ciclistas c
ON r.userid = c.id
GROUP BY c.id, c.nombre, c.apellido
LIMIT 10
```

12. Obtener el nombre, apellido y duración del ciclista con la máxima duración de recorrido.

```
USE curso13;
SELECT c.nombre, c.apellido, max(r.duracion) duracion
FROM recorridos r JOIN ciclistas c
ON r.userid = c.id
GROUP BY c.id, c.nombre, c.apellido
ORDER BY duracion DESC
LIMIT 1
```

13. Obtener nombre y apellido de las personas y el nombre de las estaciones destino que tuvieron sus recorridos, junto con la cantidad de veces que se dirigieron allí. recorridos, junto con la cantidad de veces que se dirigieron allí.

```
USE curso13;
SELECT c.nombre, c.apellido, e.nombre, count(*) cant
FROM recorridos r
JOIN ciclistas c ON r.userid = c.id
JOIN estaciones e ON r.estaciondestinoid = e.id
GROUP BY c.apellido, c.nombre, e.nombre;
```

14. Ejecutar los puntos 12 y 13 de la práctica, con el motor de procesamiento MAP REDUCE
  ● Obtener los nombres y apellidos de los ciclistas junto con la duración máxima de entre sus recorridos.

```
SET hive.execution.engine=mr;
SELECT c.nombre, c.apellido, max(r.duracion) duracion
FROM recorridos r JOIN ciclistas c
ON r.userid = c.id
GROUP BY c.id, c.nombre, c.apellido
ORDER BY duracion DESC
LIMIT 1;
```
  ● Obtener el nombre, apellido y duración del ciclista con la máxima duración de recorrido.
```
SET hive.execution.engine=mr;
SELECT c.nombre, c.apellido, e.nombre, count(*) cant
FROM recorridos r
JOIN ciclistas c ON r.userid = c.id
JOIN estaciones e ON r.estaciondestinoid = e.id
GROUP BY c.apellido, c.nombre, e.nombre;
```

15. Ejecutar el ejercicio 14 de la práctica con ORDER BY, SORT BY, DISTRIBUTED BY y CLUSTER BY.    

● Obtener nombre y apellido de las personas y el nombre de las estaciones destino que tuvieron sus recorridos, junto con la cantidad de veces que se dirigieron allí. Ordenado por nombre y apellido de las personas.
apellido de las personas.
```
USE curso99;
SELECT c.nombre, c.apellido, e.nombre, count(*) cant
FROM recorridos r
JOIN ciclistas c ON r.userid = c.id
JOIN estaciones e ON r.estaciondestinoid = e.id
GROUP BY c.apellido, c.nombre, e.nombre
ORDER BY c.apellido, c.nombre;

SELECT c.nombre, c.apellido, e.nombre, count(*) cant
FROM recorridos r
JOIN ciclistas c ON r.userid = c.id
JOIN estaciones e ON r.estaciondestinoid = e.id
GROUP BY c.apellido, c.nombre, e.nombre
SORT BY c.apellido, c.nombre;

SELECT c.nombre, c.apellido, e.nombre, count(*) cant
FROM recorridos r
JOIN ciclistas c ON r.userid = c.id
JOIN estaciones e ON r.estaciondestinoid = e.id
GROUP BY c.apellido, c.nombre, e.nombre
DISTRIBUTE BY c.apellido, c.nombre
SORT BY c.apellido, c.nombre;

SELECT c.nombre, c.apellido, e.nombre, count(*) cant
FROM recorridos r
JOIN ciclistas c ON r.userid = c.id
JOIN estaciones e ON r.estaciondestinoid = e.id
GROUP BY c.apellido, c.nombre, e.nombre
CLUSTER BY c.apellido, c.nombre;
```



