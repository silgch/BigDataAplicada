# Curso Neo4j
## Práctica 3

Desarrollar las siguientes consultas sobre la Base de Datos.  

1.Crear en un solo paso un nodo con label Empresa con la propiedad nombre BIGNEO, y dos relaciones Persona con apellido Lupis TRABAJO en la empresa BIGNEO y la
persona con apellido Ferreira TRABAJO en la empresa BIGNEO.   

```
MATCH (b:Persona {apellido:"Lupis"}),
(c:Persona {apellido:"Ferreira"})
CREATE (a:Empresa {nombre:"BIGNEO"}),
(b)-[r:TRABAJO]->(a),
(c)-[r1:TRABAJO]->(a)
RETURN a
```

a. Tratar de eliminar el nodo con la operación DELETE.   

`MATCH (a:Empresa {nombre:"BIGNEO"}) DELETE a`

b. Eliminar el nodo con la operación DETACH DELETE.   
`MATCH (a:Empresa {nombre:"BIGNEO"}) DETACH DELETE a`



2. Agregar una etiqueta de Empleado a todos los nodos que TRABAJEN en alguna empresa.

`MATCH (a:Persona)-[TRABAJO]->() SET a:Empleado`


3. Agregar la propiedad edad 51 a la persona con apellido “Corrado”.

```
MATCH (a:Persona {apellido:'Corrado'}) SET a.edad=51
RETURN a
```

4. Agregar la propiedad puesto “Gerente Financiero” a la Relaciones TRABAJO de la persona con apellido "López"

```
MATCH (a:Persona {apellido:'López'})-[r:TRABAJO]->() SET
r.puesto="Gerente Financiero" RETURN a,r
````

5. Modificar la propiedad puesto “Jefe de Finanzas” para la Relación TRABAJO de la persona con apellido "López" en la empresa “Carrefour”.  

```
MATCH (a:Persona {apellido:'López'})-[r:TRABAJO]->(e:Empresa {nombre:"Carrefour"})
SET r.puesto="Jefe de Finanzas"
```

6. Eliminar la etiqueta Empleado para las Personas que no sean argentinas.  
```
MATCH (a:Persona)-[TRABAJO]->() WHERE a.pais <> 'Argentina' REMOVE a:Empleado
```

7. Listar los apellidos de las Personas que no son Empleados.  

```
MATCH (a:Persona) WHERE NOT a:Empleado RETURN a.apellido
```

8. Eliminar la propiedad edad de todos los nodos que tengan más de 3 relaciones salientes.    

```
MATCH (a:Persona)-[r]->(b) WITH a, count(type(r)) AS cantRelaciones WHERE cantRelaciones>=3 REMOVE a.edad
```

9. Crear la Institución "UTN FRSF", si la institución ya existe agregar o modificar la propiedad fechaModificacion con el TimeStamp del momento, si la institución no existe crearla con la propiedad fechaCreacion y el timeStamp del momento.

```
MERGE (i:Institucion {nombre:"UTN FRSF"})
ON CREATE SET i.tsCreacion=timestamp()
ON MATCH SET i.tsModificacion=timestamp()
```

10.Crear la Persona con apellido”Toro” y nombre “Ramiro” que CONOCE a otra persona con apellido “Corrado” y TRABAJO en la empresa DBlandIT. La instrucción deberá
tener en cuenta si existe o no cada nodo Toro y las relaciones asociadas.

```
MATCH (p2:Persona {apellido:"Corrado"})
MERGE (p2)-[r1:CONOCE_A]->(p1:Persona {apellido:"Toro", nombre:"Ramiro"})-[r2:TRABAJO]->(e:Empresa {nombre:"DBlandIT"})
RETURN p1,e,p2,r2
```

11.Devolver una lista con los apellidos de las personas que son contactos directos o indirectos de la Persona con apellido “Corrado”.

```
MATCH (p:Persona{ apellido: 'Corrado' })
RETURN [(p)-[r:CONOCE_A*]->(e) WHERE e:Persona | e.apellido] AS listaConocidos
```

12.Devolver la lista de la consulta anterior en sentido inverso.

```
MATCH (p:Persona{ apellido: 'Corrado' })
WITH [(p)-[r:CONOCE_A*]->(e) WHERE e:Persona | e.apellido] AS listaConocidos
RETURN reverse(listaConocidos)
```

13.Devolver la lista de la consulta anterior, con los tres primeros elementos.

```
MATCH (p:Persona{ apellido: 'Corrado' })
WITH [(p)-[r:CONOCE_A*]->(e) WHERE e:Persona | e.apellido] AS listaConocidos
RETURN listaConocidos[..3]
```

14. Devolver una lista de Personas con conocimientos de Java.   

```
MATCH (c:Conocimiento {nombre: 'Java' })
RETURN [(p)-[r:POSEE*]->(c) WHERE p:Persona | p.apellido] AS javaBoys
```

15.Devolver la lista del comando anterior, sin el primer elemento, o sea a partir del 2do elemento.   

```
MATCH (c:Conocimiento {nombre: 'Java' })
WITH [(p)-[r:POSEE*]->(c) WHERE p:Persona | p.apellido] AS javaBoys
RETURN tail(javaBoys)
```

16.Devolver un camino la lista de conocidos indirectos de tercer nivel para la Persona de apellido Mendez. (Tomar el concepto de CONOCIDO sin tener en cuenta la dirección
de la relación).  

`MATCH camino=(p:Persona {apellido:"Mendez"})-[r:CONOCE_A*3..]-() RETURN camino`

17.Tomar la consulta del punto anterior y devolver sólo las relaciones del Camino.   

```
MATCH camino=(p:Persona {apellido:"Mendez"})-[r:CONOCE_A*3..]-()
RETURN relationships(camino)
```

18.Tomar la consulta del punto 16 y devolver sólo los nodos.   

```
MATCH camino=(p:Persona {apellido:"Mendez"})-[r:CONOCE_A*3..]-()
RETURN nodes(camino)
````

19.Tomar la consulta del anterior y filtrar los elementos que no contengan “/196” en la fecha de nacimiento.

```
MATCH camino=(p:Persona {apellido:"Mendez"})-[r:CONOCE_A*3..]-()
WITH nodes(camino) AS listaNodos
RETURN [elem IN listaNodos WHERE NOT elem.fechanac CONTAINS '/196' | elem]
```

20.Tomar la consulta del punto 18 y extraer una lista con la propiedad emails de todos los elementos.   

```
MATCH camino=(p:Persona {apellido:"Mendez"})-[r:CONOCE_A*3..]-()
WITH nodes(camino) AS listaNodos
RETURN extract(elem IN listaNodos| elem.email) AS listaExtraida
```

21.Devolver un camino la lista de conocidos indirectos de tercer nivel para la Persona de apellido Mendez. Listar el camino si solo si todos los elementos tienen mail de gmail
(Tomar el concepto de CONOCIDO sin tener en cuenta la dirección de la relación).  

```
MATCH camino=(p:Persona {apellido:"Mendez"})-[r:CONOCE_A*3..]-()
WHERE ALL (elem IN nodes(camino) WHERE elem.email CONTAINS "@gmail")
RETURN camino
```

22.Devolver un camino la lista de conocidos indirectos de tercer nivel para la Persona de apellido Mendez. Listar el camino si solo si alguno de los elementos tienen mail de
gmail (Tomar el concepto de CONOCIDO sin tener en cuenta la dirección de la relación).  

```
MATCH camino=(p:Persona {apellido:"Mendez"})-[r:CONOCE_A*3..]-()
WHERE ANY (elem IN nodes(camino) WHERE elem.email CONTAINS "@gmail")
RETURN camino
```

23. Listar todos las Personas en las que no exista la propiedad email.  

```
MATCH (n:Persona)
WHERE not exists(n.email)
RETURN n.nombre, n.apellido
```

24.Actualizar o agregar la propiedad email con valor “no posee” para las personas que no posean mail. Devolver nombre, apellido y email.

```
MATCH (n:Persona)
WHERE not exists(n.email)
SET n.email="No Posee"
RETURN n.nombre, n.apellido,n.email
```

25.Listar todas los Tipos de Relaciones con la cantidad de relaciones por cada uno, ordenado por cantidad de forma descendente.

```
MATCH ()-[r]->()
RETURN type(r) AS tipoRelacion, count(r) AS cantRelaciones ORDER BY cantRelaciones
DESC
```

26.Devolver un mapa con el apellido de cada persona y la cantidad de conocimientos, la cantidad de contactos y la cantidad de trabajos que tuvo.  

```
MATCH (p:Persona)-[:POSEE]->(c:Conocimiento),(p)-[CONOCE_A]->(o:Persona),(p)-[TRABAJO]->(e:Empresa)
WITH p, count(c) AS cantConocimientos, count(o) AS cantContactos, count(e) AS cantEmpresas
RETURN p {.apellido, cantConocimientos, cantContactos, cantEmpresas}
```

27.Listar el apellido y nombre de cada persona y la empresa en la que trabajo. En el caso de no haber trabajado en ninguna empresa mostrar nulo.   

```
MATCH (p:Persona)
OPTIONAL MATCH (p)-[TRABAJO]->(e:Empresa)
RETURN p.apellido,p.nombre,e.nombre
```

28.Listar el nombre de cada empresa y la cantidad de empleados para las empresas cuyo nombre tiene más de 5 caracteres y la cantidad de empleados sea mayor que uno.
Ordenar todo por cantidad de empleados DESC.   

```
MATCH (e:Empresa)<--()
WHERE size(e.nombre) >5
WITH e, count(*) AS cantEmpleados
WHERE cantEmpleados > 1
RETURN e.nombre, cantEmpleados
ORDER BY cantEmpleados DESC
```

29.Devolver una lista de todos los nombres de las instituciones cargada en la base de datos.   

```
MATCH (i:Institucion)
RETURN COLLECT(i.nombre) AS listaInstituciones
```

30.Retornar un camino para las relaciones CONOCE_A de nivel mayor a 2 que tiene la persona de apellido Corrado. Por cada relación en el camino actualizar la propiedad
status con valor ‘activo’

```
MATCH lista=(p1:Persona {apellido:"Corrado"})-[r:CONOCE_A*2..]->(p2:Persona)
FOREACH (elem IN relationships(lista)| SET elem.status= 'activo')
```
