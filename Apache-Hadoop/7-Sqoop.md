# Curso Intro Big Data
## Práctica Clase Sqoop

1. Conectarse al Server 101.   
User: xxxxxx passw: xxxxxxx  

2. Listar  herramientas útiles de Sqoop
`
export.  
import.  
list-database.   
list-tables.  
eval.  

3. Listar  argumentos generales

connect.  
help.  
username.  
password.  
verbose.  

4. Que versión de Sqoop está instalada   
`sqoop-version` o `sqoop version`

5. Listar todas las bases de datos de PostgreSQL.  
`sqoop-list-databases --connect jdbc:postgresql://hadoop06.xxxx/ --username xxxxx --password xxxxxx`

6. Listar todas las tablas de la base de datos "curso" PostgreSQL.  
`sqoop-list-tables --connect jdbc:postgresql://hadoop06.xxxx/curso --username xxxxx --password xxxxx`

7. Con el comando eval, mostrar el registro correspondiente al ID 4 de la tabla empleados de PostgreSQL.  
`sqoop-eval --connect jdbc:postgresql://hadoop06.xxxx/curso \. --username xxxxx --password xxxxx \ --query "SELECT * FROM EMPLEADOS WHERE ID = 4"`

8. Crear un archivo con los datos de conexión para PostgreSQL y utilizarlo en algún comando.  
`sqoop-eval --options-file ./option-file.txt \ --query "SELECT * FROM empleados WHERE ID = 4"`

9. Importar los datos de la tabla "provincias" de PostgresSQL al directorio de Hadoop "/user/hue/curso-sqoop/provincias" y mostrarlo a través de linux.  
```
sqoop-import --connect jdbc:postgresql://hadoop06.xxxx/curso \
--username xxxxx --password xxxxx --table provincias\
--target-dir "/user/cursoXX/provincias" -m 1 --direct
hdfs dfs -cat /user/cursoXX/provincias/part-m-*
```

10. Importar un subset de datos de la tabla "provincias" de PostgresSQL al directorio de Hadoop "/user/curso99/provincias-sub-set" y mostrarlo a través de linux.  
```
sqoop-import --connect jdbc:postgresql://hadoop06.xxxxx/curso \
--username xxxxx --password xxxxx --table provincias \
--target-dir "/user/cursoXX/provincias-sub-set" -m 1 \
--where "nombre LIKE 'S%'"
hdfs dfs -cat /user/cursoXX/provincias-sub-set/part-m-*
```

11. Importar todas las tablas de PostgresSQL al directorio de Hadoop.  

```
sqoop-import-all-tables --connect jdbc:postgresql://hadoop06.xxxxx/curso \
--username xxxxx --password xxxxx --warehouse-dir /user/cursoXX/db_curso \
-m 1 --direct
hdfs dfs -cat /user/cursoXX/db_curso/empleados/part-m-*
```
`hdfs dfs -cat /user/cursoXX/db_curso/provincias/part-m-*`

12. Mediante Sqoop:

a. Crear una tabla provincias_curso99 en PostgreSQL con la siguiente estructura:

- ID : Int NOT NULL
- nombre : VARCHAR(30)
- Abreviatura : CHAR(2)
- Fecha : VARCHAR(50)

b. Exportar el directorio "/user/curso99/provincias" de HDFS en la tabla anteriormente creada y mostrar los datos.  

```
sqoop-eval --connect jdbc:postgresql://hadoop06.xxxxx/curso \ --username xxxxx --password xxxxx \
--query "CREATE TABLE provincias_cursoXX(provinciaId integer NOT NULL, NOMBRE character varying(30) NULL, abreviatura CHAR(2), fecha VARCHAR(50))"
sqoop-export --connect jdbc:postgresql://hadoop06.xxxxx/curso --username xxxxx --password xxxxx --table provincias_cursoXX --export-dir "/user/cursoXX/db_curso/provincias"
sqoop-eval --connect jdbc:postgresql://hadoop06.xxxxx/curso \ --username xxxxx --password xxxxx --query "SELECT * FROM provincias_cursoXX"
```

13. Crear en Hive una tabla provincias_cursoXX con la misma estructura de la tabla provincias de PostgreSQL pero con formato de archivo ORC.
  
  a. Ver la descripción de la tabla provincias de postgresql.   

```
sqoop-eval --connect jdbc:postgresql://hadoop06.xxxxx/curso --username xxxxx --password xxxxx --query " SELECT ordinal_position, column_name, data_type, character_maximum_length FROM information_schema.COLUMNS WHERE TABLE_NAME = 'provincias'"
```

  b. Crear la tabla provincias_cursoXX en HIVE con formato de archivo ORC.
  
  c. Importar los datos de la tabla provincias de la BD PostgreSQL a la tabla en Hive provincias_cursoXX con formato ORC vía Sqoop.

```
sqoop-import --connect jdbc:postgresql://hadoop06.xxxxx/curso --username xxxxx --password xxxxx --table provincias --hcatalog-database cursoXX --hcatalog-table provincias_cursoXX
```

  d. Consultar la tabla provincias_cursoXX en Hive.   
  
  






