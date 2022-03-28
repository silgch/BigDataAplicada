# Curso Intro Big Data

## Práctica Clase Ambari 

1. Ingresar a Ambari Views con su usuario y visualizar su carpeta dentro de HDFS.  

En el margen superior derecho, Seleccionar **FilesView**.
Luego, debemos navegar a nuestra carpeta de usuario: user/miUsuario.   


2. Eliminar todo archivo ya existente en este directorio, si lo hay. 

Dentro de nuestra carpeta de usuario, hacemos click en el boton **Select All** y luego **Delete**.   


3. Crear un Directorio en Ambari Views en el directorio de su usuario (/user/<usuario>) llamado dirAView.  
  
 Hacemos click en el boton **New Folder** en el sector superior derecho. Elegimos el nombre "dirAView" y hacemos click en "add".  

  
4. Realizar un upload del archivo recorrido-bicis.csv desde su Windows al directorio dirAView creado en el punto anterior. 

  En el margen superior derecho, hacer click en el boton **Upload*+. Luego hacer click en la nube para buscar el archivo a subir, o bien arrastrar y soltarlo desde nuestro sistema operativo.     
  
  
5. Una vez cargado, visualizar el contenido del mismo.  
  
  Dentro de Ambari --> click sobre el archivo--> click sobre *open*. Podremos previsualizar el archivo.     
  
  
6. Renombrar el archivo recorrido-bicis.csv a recorrido-total.csv y luego descargarlo. 
  
  Dentro de Ambari --> click sobre el archivo--> click sobre *rename* --> cambio el nombre por "recorrido-total.csv" --> hago click en rename.    
  
  Para descargarlo, seleccionar el archivo y hacer click en **download**.  
  
  
7. Copiar los archivos estaciones-bicis.csv, recorrido-bicis.csv y maestro-ciclistas.csv al directorio dirAView.  
  
 Como aun  no tenemos archivos en HDFS y queremos copiarlos desde nuestra PC:  
  `hdfs dfs -copyFromLocal dirLocal/*.csv  dirAView`
   
  
8. Copiar todos los archivos exceptuando recorrido-total.csv a un nuevo directorio llamado dirAViewcopia.     
  
Primero creamos una carpeta haciendo click en el margen superior derecho **New Folder** y la llamamos *dirAViewcopia*.  
  
Luego, ubicados en la carpeta donde se encuentran los archivos que queremos copiar, seleccionamos los archivos (podemos usar ctr o cmd para seleccionar varios) y luego hacemos click en **Copy**. Navegamos hasta la carpeta donde queremos colocar la copia de los archivos y luego hacemos click en **copy**. 
 
  
9. Listar todos los archivos que tengan “csv” en su nombre ordenados por tamaño.  
  
Ubicados en la carpeta donde queremos buscar, escribimos "csv" en el cuadro de busqueda, Luego hacemos click en *Size* para ordenar por tamaño.   
  
El equivalente a esta acción por linea de comandos es:  `hdfs dfs -ls -S dirAViewcopia`.  
  
  
10. Mover el archivo recorrido-total.csv del directorio dirAView a dirAViewcopia.    
  
 Ubicados en la carpeta donde se encuentra el archivo, lo seleccionamos. Luego, hacemos click en **Move** y buscamos la carpeta destino. Una vez elegida hacemos click en el boton *Move*
  
El equivalente por consola es:   `hdfs dfs  -mv dirAView/recorrido-total.csv dirAViewcopia/recorrido-total.csv`
  
11. Cambiarle los permisos al directorio dirAViewcopia, dejar únicamente Read y Execute para el Usuario. Esto se debe aplicar también para todos sus archivos.     
  
 Seleccionamos la carpeta *dirAViewcopia*  hacemos click en  Permission y luego elegimos los permisos *Read* y *Execute* para el *User* y hacemos click en *Save* 
  
 Por consola: `hdfs dfs -chmod -R 500 dirAViewcopia`
  
  
12. Intentar crear un archivo en su Windows local e importarlo al directorio dirAViewcopia.    
  
  Desde Ambari hacemos click en **Upload** y elegimos el archivo. El sistema no nos permitira, arrojando un error:  ** Permission denied **.  
  
  Si intentamos por consola, obtendremos el mismo error:   
  `touch dirLocal/pruebaAmbari.txt`.  
  `hdfs dfs -copyFromLocal dirLocal/pruebaAmbari.txt dirAViewcopia`.  
  No se logra, debido a que los permisos de usuario para la carpeta no lo permiten.   
  Error: copyFromLocal: Permission denied: user=curso13, access=WRITE, inode="/user/curso13/dirAViewcopia/pruebaAmbari.txt._COPYING_":curso13:hdfs:dr-x------
  
13. Garantizar todos los permisos (777) en el directorio dirAViewcopia.   
  
  Desde Ambari: Seleccionamos la carpeta, clickeamos en   **Permission** y seleccionamos todos los permisos para usuario, grupo y otros.    
  
  El equivalente por consola es: 
  `hdfs dfs -chmod 777 dirAViewcopia` 
