# Curso Intro Big Data

## Práctica Clase Ambari


1. Crear un rdd "ciclistaRDD", leyendo el archivo "MaestroCiclistas.csv".  
`val ciclistaRDD = sc.textFile("/user/curso30/MaestroCiclistas.csv")`.  

2. Contar la cantidad de elementos en "ciclistaRDD".  
`ciclistaRDD.count()`

3. Imprimir en pantalla los primeros 10 elementos de "ciclistaRDD".  
`ciclistaRDD.take(10).foreach(println)`

4. Crear un rdd "estacionesRDD", leyendo el archivo "estaciones-bicis.csv".  
`val estacionesRDD =sc.textFile("/user/curso30/estaciones-bicis.csv")`

5. Imprimir en pantalla los primeros 10 elementos de "estacionesRDD".  
`estacionesRDD.take(10).foreach(println)`

6. Crear un rdd "recorridosRDD", leyendo el archivo "recorridoBicis.csv".  
`val recorridosRDD = sc.textFile("/user/curso30/recorridoBicis.csv")`

7. Imprimir en pantalla los primeros 10 elementos de "recorridosRDD".   
`recorridosRDD.take(10).foreach(println)`

8. Crear un rdd "ciclistaArray" transformando "ciclistaRDD" (RDD de string) a un RDD de Arrays.   
`val ciclistaArray = ciclistaRDD.map( x => x.split('|'))`

9. Crear un rdd "ciclistaTupla" transformando "ciclistaArray" (RDD de arrays) a un RDD de tupla (String,String,String,String).   
`val ciclistaTupla = ciclistaArray.map(x => (x(0),x(1),x(2),x(3)))`

10. Crear un df "ciclistaDF" con nombres de campo "id","apellido","nombre","edad" , transformando "ciclistaTupla".  
`val ciclistaDF = ciclistaTupla.toDF("id","apellido","nombre","edad")`

11. Registrar el df "ciclistaDF" como tabla "ciclistas".  
`ciclistaDF.registerTempTable("ciclistas")`

12. Seleccionar todos los registros en la tabla temporal "ciclistas" y mostrarlos en pantalla.   
`val sqlContext = new org.apache.spark.sql.SQLContext(sc)`. 
`sqlContext.sql("select * from ciclistas").show()`

13. Crear un rdd "recorridosTupla" transformando "recorridosRDD" (RDD de string) a un RDD de tupla (String,String,String,String,String,String).   
`val recorridoTupla = recorridosRDD.map( x=> x.split('|')).map( x => (x(0),x(1),x(2),x(3),x(4),x(5)))`

14. Crear un df "recorridosDF" con nombres de campo "ciclistaId","estacionOrigenId","fechaOrigen","estacionDestinoId","fechaDestino","tiempoUso" , transformando "recorridosTupla".   
`val recorridoDF = recorridoTupla.toDF("ciclistaId","estacionOrigenId","fechaOrigen","estacionDestinoId","fechaDestino","tiempoUso")`

15. Registrar el df "recorridosDF" como tabla "recorridos".   
`recorridoDF.registerTempTable("recorridos")`

16. Crear un RDD "recorridosTabla" seleccionando todos los registros en la tabla temporal "recorridos".   
`val recorridosTabla = sqlContext.sql("select * from recorridos").rdd`

17. Guardar "recorridosTabla" en una carpeta en el directorio local.   
`recorridosTabla.saveAsTextFile("/user/curso9/tabla")`

18. Guardar en un solo archivo "ciclistaArray" en una carpeta en el directorio local.   
`ciclistaArray .coalesce(1).saveAsTextFile("/user/curso9/tabla_repart")`

