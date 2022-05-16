# Curso Intro Big Data
## Práctica  HIVE

1. Crear una tabla particionada por anioMes como Entero y clusterizada por user_id en 32 buckets, la
tabla deberá estar almacenada como ORC y los campos serán:   

userid.  
apellido.  
nombre.  
edad.  
estacionOrigenId.  
estacionOrigenNombre.  
fechaOrigen   
estacionDestinoId.  
estacionDestinoNombre.  
fechaDestino.  
duración.  


Respetando los tipos de datos originales salvo el definido para la partición.   

2. Ver la estructura interna de la tabla recorridosPart
3. Insertar los datos referidos a la partición 201209
4. Insertar los datos referidos a la partición 201210
5. Insertar los datos referidos a la partición 201211
6. Insertar los datos referidos a la partición 201212
7. Listar las particiones de la tabla recorridosPart.
8. Realizar la siguiente consulta con EXPLAIN.
```
EXPLAIN SELECT apellido, estacionOrigenNombre, duracion
FROM recorridosPart
WHERE edad > 20
```
9. Realizar la siguiente consulta con EXPLAIN.
```
EXPLAIN SELECT apellido, estacionOrigenNombre, duracion
FROM recorridosPart
WHERE anioMes=201212 AND edad > 20
```
10. Realizar la siguiente consulta con VISUAL EXPLAIN.
```
SELECT user_id, apellido,c.nombre, edad, estacion_origen_id, e1.nombre
estacionOrigenNombre, fecha_origen, estacion_destino_id, e2.nombre
estacionDestinoNombre, fecha_destino, duracion FROM ciclistas c JOIN recorridos r ON c.id=r.user_id
JOIN estaciones e1 ON estacion_destino_id=e1.id
JOIN estaciones e2 ON estacion_origen_id=e2.id
WHERE CAST(CONCAT(substring(fecha_origen,1,4),substring(fecha_origen,6,2) )
AS INT)
```
  
