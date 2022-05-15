# Curso Intro Big Data
## Práctica Clase Zookeeper–Kafka–Flume


1. Conectarse al server 192.168.1.101 por ssh (Putty) y ejecutar un Producer de Kafka para que envíe lo que se ingresa por teclado a un topic que tenga el nombre de su usuario
como nombre.

```
/usr/hdp/current/kafka-broker/bin/kafka-console-producer.sh
--broker-list hadoop01.xxxxx:6667 --topic curso13
```

2. Mediante zookeeper-client buscar en el file system de zookeeper los distintos znodes.  

```
zookeeper-client
ls /
```

3. Obtener la lista de topics mediante el zookeeper-client y el kafka-topics.   

```
zookeeper-client
ls /brokers/topics
```

```
/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper
hadoop01.xxxxx:2181,hadoop02.xxxxx:2181,hadoop03.xxxxx:2
181 --list
```

4. Conectarse al server 192.168.1.101 por ssh (Putty) en otra consola y ejecutar un Consumer de Kafka para que lea y escriba por consola todo lo referente al topic que
tenga el nombre de su usuario como nombre.
```
/usr/hdp/current/kafka-broker/bin/kafka-console-consumer.sh
--zookeeper
hadoop01.xxxxx:2181,hadoop02.xxxxx:2181,hadoop03.xxxxx:2
181 --topic curso13
```

5. Corroborar que lo enviado por el Producer Kafka es recibido por el Consumer.
6. Cerrar el Consumer y crear uno nuevo escuchando el topic de un compañero de curso e intercambiar mensajes.
```
/usr/hdp/current/kafka-broker/bin/kafka-console-producer.sh
--broker-list hadoop01.xxxxx:6667 --topic curso13
```
7. Instalar Aginity en su equipo.

8. Configurar acceso a Hive Server, Hive Metastore y HDFS.

9. Listar los archivos en HDFS que poseen la data almacenada por Flume y consultar algunos de estos archivos.

10. Crear una tabla externa ‘flume_data_curso13’ en hive que permita mostrar los datos grabados desde Flume en HDFS.

```
CREATE EXTERNAL TABLE flume_data_curso13(texto string)
LOCATION '/user/curso13/curso13';
```

11. Consultar los datos de la tabla creada.   

`SELECT * FROM flume_data_curso13;`

12. Realizar un DROP de la tabla flume_data_curso13.   
`DROP TABLE flume_data_curso13;`

13. Que sucedió con los datos existentes en HDFS?   
Al dropear la table solo se borra la Metadata del MetaStore pero no los arhivos a los que hacía referencia.  

14. Crear la misma tabla en HIVE que no sea externa.
```
CREATE TABLE flume_data_curso13(texto string)
ROW FORMAT DELIMITED
LINES TERMINATED BY '\n'
STORED AS textfile;
```

15. Realizar un load de los archivos de flume.
```
LOAD DATA INPATH '/user/curso13/curso13/FlumeData.1480679914012'
INTO TABLE flume_data_curso13;
```
16. Hacer un SELECT de la tabla.   
`SELECT * FROM flume_data_curso13;`

17. Realizar un DROP de la tabla.   
`DROP TABLE flume_data_curso13;`

18. Qué sucedió con los datos existentes en HDFS.   
Borra todos los archivos de HDFS al momento de hacer el load y los pasa a la table. Cuando se hace el drop, los datos de los archivos cargados se borrar automáticamente.

