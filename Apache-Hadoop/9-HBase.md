# Curso Intro Big Data
## Práctica Clase HBase


1. Conectarse al NameNode por ssh (Putty) y ejecutar hbase shell para ingresar a la consola de HBase.

2. Listar las tablas presentes.  

`list`

3. Escanear la tabla recorridoBicis   

`scan 'recorridoBicis'`

4. Hacer uso del comando `help 'scan' `para conocer cómo realizar un `scan` que devuelva sólo las columnas estacionOrigenID y estacionDestinoID, con un limit de 5 filas
empezando por la fila con row-key de 10.  
```
scan 'recorridoBicis', {COLUMNS => ['cf1:estacionOrigenID',
'cf2:estacionDestinoID'], LIMIT => 5, STARTROW => '10'}
```
5. Contar la cantidad de filas de la tabla recorridoBicis con count.  
`count 'recorridoBicis' `

6. Contar la cantidad de filas de la tabla por medio del RowCounter   
`hbase org.apache.hadoop.hbase.mapreduce.RowCounter recorridoBicis`

7. Se quiere crear una tabla para almacenar las notas de los alumnos de un curso. Crear la tabla con el nombre notas_por_materia13 con 1 column family cf1.

`create 'notas_por_materia00', 'cf1'`

8. Ingresar las notas de un alumno (legajo 100) para las materias (columnas) algebra y matematica. El row-key contendrá el número de legajo del alumno.
```
put 'notas_por_materia13','100','cf1:algebra','5'
put 'notas_por_materia13','100','cf1:matematica','9'
```

9. Ingresar las notas de otro alumno con legajo 2 para las materias (columnas) historia y matematica.
```
put 'notas_por_materia13','2','cf1:historia','10'
put 'notas_por_materia13','2','cf1:matematica','9'
```
