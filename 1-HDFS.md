# Curso Intro Big Data 
## Práctica Clase HDFS

1. Crear un Directorio Local en el directorio de su usuariollamado dirLocal.  
`mkdir dirLocal`
2. Crear un Directorio HDFS en el directorio de su usuario llamado dirHDFS.  
`hdfs dfs -mkdir dirHDFS`
3. Listar los archivos presentes en el directorio de su usuario.  
`ls`
4. Copiar el archivo recorrido-bicis.csv dentro del mismo directorio poniendole recorrido-bicis2.csv como nombre.  
`cp recorrido-bicis.csv recorrido-bicis2.csv`
5. Mover los archivos del Directorio Local de su usuario al directorio llamado dirLocal.  
`mv *.csv dirLocal`
6. Crear un archivo vacío en HDFS llamado archivoHDFS.csv en el directorio dirHDFS. 
`hdfs dfs -touchz dirHDFS/archivoHDFS.csv`
o
`hadoop fs -touchz dirHDFS/archivoHDFS.csv`
7. Copiar el recorrido-bicis.csv del dirLocal al directorio dirHDFS.  
`hdfs dfs -copyFromLocal dirLocal/recorrido-bicis.csv dirHDFS`
8. Copiar el estaciones-bicis.csv y el maestro-ciclistas.csv del dirLocal al directorio dirHDFS. 
`hdfs dfs -copyFromLocal dirLocal/estaciones-bicis.csv dirHDFS`
`hdfs dfs -copyFromLocal dirLocal/maestro-ciclistas.csv dirHDFS`
9. Mover el recorrido-bicis2.csv del dirLocal al dirHDFS. 
`hdfs dfs -moveFromLocal dirLocal/recorrido-bicis2.csv dirHDFS`
10. Listar los archivos y directorios del directorio dirHDFS.  
`hdfs dfs -ls dirHDFS`
11. Agregar el contenido del archivo local recorrido-bicis.csv al archivo existente en HDFS llamado archivoHDFS.csv de la carpeta dirHDFS.  
`hdfs dfs -appendToFile dirLocal/recorrido-bicis.csv dirHDFS/archivoHDFS.csv`
12. Copiar del dirHDFS el archivoHDFS.csv al dirLocal.  
`hdfs dfs -get dirHDFS/archivoHDFS.csv dirLocal`
o  
`hdfs dfs -copyToLocal dirHDFS/archivoHDFS.csv dirLocal`
13. Agregar al archivo de HDFS llamado archivoHDFS.csv los archivos locales recorrido-bicis.csv y estaciones-bicis.csv  
`hdfs dfs -appendToFile dirLocal/recorrido-bicis.csv dirLocal/estaciones-bicis.csv dirHDFS/archivoHDFS.csv`
14. Listar del dirHDFS todos los archivos que contengan HDFS en su nombre  
`hdfs dfs -ls dirHDFS/*HDFS*`
15. Listar el archivo archivoHDFS.csv del directorio dirHDFS.  
`hdfs dfs -ls dirHDFS/archivoHDFS.csv`
16. Cambiar los permisos del archivo archivoHDFS.csv del directorio dirHDFS a RWX (777).  
`hdfs dfs -chmod 777 dirHDFS/archivoHDFS.csv`
17. Listar el archivo archivoHDFS.csv del directorio dirHDFS para corroborar el cambio.  
`hdfs dfs -ls dirHDFS/archivoHDFS.csv`
18. Informar del directorio dirHDFS su cantidad de subdirectorios, archivos y bytes.  
`hdfs dfs -count dirHDFS`
19. Dentro del directorio dirHDFS copiar el archivo maestro-ciclistas.csv y ponerle maestro-ciclistas2.csv como nombre.  
`hdfs dfs -cp dirHDFS/maestro-ciclistas.csv dirHDFS/maestro-ciclistas2.csv`
20. Ver el contenido del archivo maestro-ciclistas2.csv.  
`hdfs dfs -cat dirHDFS/maestro-ciclistas2.csv`
21. Cambiar el archivo archivoHDFS.csv al grupo curso.  
`hdfs dfs -chgrp curso dirHDFS/archivoHDFS.csv`
22. Listar los archivos del dirHDFS para corroborar el cambio realizado.  
`hdfs dfs -ls dirHDFS`
23. Obtener la concatenación de todos los archivos dentro del dirHDFS en el archivo archivoLocal.csv dentro del dirLocal.  
`hdfs dfs -getmerge dirHDFS dirLocal/archivoLocal.csv`
24. Mover el archivo archivoHDFS.csv del directorio dirHDFS a su carpeta personal dentro de HDFS.  
`hdfs dfs -mv dirHDFS/archivoHDFS.csv .`
25. Listar todos los archivos y directorios dentro de su carpeta personal dentro de HDFS, incluyendo los archivos en los subdirectorios.  
`hdfs dfs -ls -R`
26. Eliminar el archivo maestro-ciclistas2.csv en HDFS.  
`hdfs dfs -rm dirHDFS/maestro-ciclistas2.csv`
27. Ver sólo la última parte del archivo archivoHDFS.csv.  
`hdfs dfs -tail archivoHDFS.csv`
28. Borrar el directorio dirHDFS junto con todo su contenido.  
`hdfs dfs -rm -R dirHDFS`
29. Listar el contenido de su papelera de reciclaje de HDFS.  
`hdfs dfs -ls .Trash/Current/user/curso/dirHDFS`
30. Recuperar el archivo recorrido-bicis.csv.  
`hdfs dfs -mv .Trash/Current/user/curso/dirHDFS/recorrido-bicis.csv .`
31. Vaciar la papelera de reciclaje.  
`hdfs dfs -expunge`
32. Copiar las últimas lineas del archivo recorrido-bicis.csv en el archivo ultimos.csv.  
`hdfs dfs -tail recorrido-bicis.csv | hdfs dfs -put - ultimos.csv`
33. Volver a agregarle las mismas lineas al archivo ultimos.csv.  
`hdfs dfs -tail recorrido-bicis.csv | hdfs dfs -appendToFile - ultimos.csv`
34. Borrar los archivos que contengan la palabra “bicis” en su nombre.  
`hdfs dfs -rm "*bicis*"`
