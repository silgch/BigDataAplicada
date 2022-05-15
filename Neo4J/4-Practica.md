# Curso Neo4j
## Práctica 4

Desarrollar las siguientes consultas sobre la Base de Datos

1. Obtener un listado de las etiquetas, relaciones de la base de datos.   


2. Obtener el esquema de la base de datos.


3. Obtener la lista de todas las propiedades existentes en la base de datos.


4. Obtener por cada Empresa el promedio de sueldos de sus empleados. Informar nombre de la empresa y promedio de sueldos.


5. Obtener por cada rubro de empresa el promedio de sueldos de sus empleados. Informar rubro, promedio de sueldos y cantidad de empleados.


6. Obtener por cada rubro de empresa el promedio de sueldos de sus empleados. Informar rubro, promedio de sueldos y cantidad de empleados.


7. Indicar la edad mínima y máxima de cada persona calculándola en función a su año de nacimiento, informar además el promedio de conocimientos por persona.


8. Listar por empresa y puesto la suma de sueldos, ordenado por nombre de empresa y puesto.


9. Listar de cada Persona, apellido, nombre, fecha de nacimiento, día, mes y año, para las personas cuya fecha de nacimiento no es nula.


10. Listar el apellido, el estado y la fecha de estudio como esta cargado y como entero de la forma aaaammdd de las personas que estudiaron alguna carrera en la 'UTN'.


11. Crear en una sola instrucción dos nodos con etiqueta "Informe" con la propiedad "fechaInforme" en formato entero y propiedad "nroInforme" en formato entero.   
{fechaInforme:20180430, nroInforme:17} y {fechaInforme:20180503, nroInforme:18}


12. Asociar el nodo con nroInforme=17 creado en el punto anterior a nodos de un Arbol de Fechas, si no existen los nodos y relaciones del árbol, deberán crearse.


13. Idem punto anterior para el Informe con nroInforme 18.


14. Crear un árbol de fechas para los años 2019 y 2020, tomando el script de la presentación.


15. Listar el camino entre los nros. de días existentes entre el 15/04/2019 y el 10/05/2019.


16. Crear una restricción (constraint) de UNIQUE para la propiedad nombre de las Instituciones.


17. Listar los constraints existentes en la Base de Datos.


18. Listar los índices existentes en la Base de Datos. ¿Qué índices observa? ¿Cómo se creó?


19. Crear un índice compuesto para las personas por apellido y nombre


20. Crear un índice compuesto para las personas por fecha de nacimiento


21. Realice un EXPLAIN para evaluar la búsqueda de personas con fechanac "01/08/1966". ¿Qué observa?


22. Eliminar el índice por fecha de nacimiento


23. Realice un EXPLAIN para evaluar la búsqueda de personas con fechanac "01/08/1966". ¿Qué observa?


24. Realice un PROFILE para evaluar la búsqueda de personas que hayan cursado carreras de la institución con nombre UTN FRBA.


25. Realice un PROFILE para evaluar la búsqueda de personas que hayan cursado carreras de la institución con nombre UTN FRBA, utilizando un SCAN HINT por Institución.


26. Realice un PROFILE para evaluar la búsqueda de personas que hayan cursado carreras de la institución con nombre UTN FRBA y el apellido de las personas comience con “Cor”, utilizando un SCAN HINT por Institución y un SCAN HINT por Persona. Que cantidad de db hints observa.


27. Realice un PROFILE para evaluar la búsqueda de personas que hayan cursado carreras de la institución con nombre UTN FRBA y el apellido de las personas comience con “Cor”, utilizando un INDEX HINT por Institución y otro INDEX HINT por Persona. Qué cantidad de db hints observa.


28. Realice un PROFILE para evaluar la búsqueda de personas que hayan cursado carreras de la institución con nombre UTN FRBA y el apellido de las personas comience con “Cor” sin utilizar los SCAN HINTS. Qué cantidad de db hints observa.


29. Evaluando los PROFILES de los puntos 26, 27 y 28. Cuál de las opciones es más performante.


30. Obtener el paso más corto entre la Persona con apellido Corrado y la persona con apellido López.


31. Crear una relación de CONOCE_A entre la persona con apellido “Mendez” y la persona con apellido “López”. Obtener todos los pasos más cortos.
