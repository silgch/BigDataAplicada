# Curso Neo4j
## Práctica 2


Desarrollar las siguientes consultas sobre la Base de Datos


1. Listar todas las personas que hayan nacido en Argentina.   
```
MATCH(p:Persona{pais:'Argentina'})
RETURN p
```

2. Listar los conocimientos cuyo nombre comience con J, sin tener en cuenta mayúsculas / minúsculas.  
```
MATCH(p:Conocimiento)
WHERE p.nombre =~ '(?i)J.*'
RETURN p
```
3. Listar las empresas cuyo rubro sea IT devolviendo sólo Nombre y Tamaño.
```
MATCH(e:Empresa)
WHERE e.rubro = 'IT'
RETURN e.nombre,e.tamano
```
4. Listar las carreras devolviendo el nombre y el nivel, ordenado por Nivel ascendente.
```
MATCH(c:Carrera)
RETURN c.nombre,c.nivel
ORDER BY c.nivel
```
5. Listar las primeras 5 empresas cuyo nombre no sea "Lan" ordenados por Rubro y
nombre Ascendente.
```
MATCH(e:Empresa)
WHERE e.nombre <> 'Lan'
RETURN e
ORDER BY e.nombre,e.rubro
```

6. Paginar de la consulta anterior mostrando de a N el resultado de la consulta, utilizando dos parámetros externos para informar el número de página y la cantidad de
datos a mostrar en cada página.   

Ejecutar primero el seteo de ambos parámetros y después la consulta por separado
```
:param pag => 0;
:param cant => 5;
```

```
MATCH(e:Empresa)
WHERE e.nombre <> 'Lan'
RETURN e
ORDER BY e.nombre,e.rubro
SKIP $pag*$cant
LIMIT $cant
```


7. Listar el nombre y tipo de las instituciones, iniciando la consulta en elementos aleatorios.

```
MATCH (i:Institucion)
RETURN i.nombre,i.tipo
SKIP toInteger(rand()*7)
```

8. Listar de cada empresa nombre, rubro y tamaño, en el caso de las empresas de tamaño grande mostrar "A", en el caso de tamaño Mediana mostrar "B" y para las de
tamaño Chica mostrar "C", este atributo deberá tener un alias Clase. Ordenar el listado por el atributo Clase.
```
MATCH(e:Empresa)
RETURN e.nombre , e.rubro, e.tamano,
CASE e.tamano
WHEN "Grande" THEN "A"
WHEN "Mediana" THEN "B"
ELSE "C"
END AS Clase
ORDER BY Clase
```

9. Obtener el nombre de cada institución, su ubicación y el nombre de cada carrera dictada.

```
MATCH(i:Institucion)<-[r:DICTADA_EN]-(c:Carrera)
RETURN i.nombre , i.ubicacion,c.nombre
```

10. Mostrar el grafo que se obtiene al buscar de la Institución con nombre "UTN FRBA" todas sus carreras buscadas.

```
MATCH(i:Institucion{nombre:"UTNFRBA"}) <-[DICTADA_EN]-(c:Carrera)
RETURN c,i
```

11. Listar el nombre y apellido de las personas; y nombre y Nivel de la Carrera, para los que tengan su estudio con estado COMPLETO y su país de referencia no sea Chile.
```
MATCH(p:Persona)-[r:ESTUDIO]->(c:Carrera)
WHERE r.estado="Completo" AND p.pais <> "Chile"
RETURN p.nombre , p.apellido,c.nombre,c.nivel
```

12. Listar los tipos de relaciones existentes en la Base de Datos. Se pide no repetir relaciones.
```
MATCH ()-[r]-()
RETURN DISTINCT type(r)
```

13. Listar la cantidad de relaciones existentes por cada tipo de relación.
```
MATCH ()-[r]-()
RETURN DISTINCT type(r),COUNT(r)
```
Otra forma:
```
MATCH ()-[r]-()
WITH TYPE(r) AS tipo , COUNT(r) as cantidad
RETURN DISTINCT tipo, cantidad
```

14. Listar la cantidad de nodos existentes por cada etiqueta.
MATCH (a)
RETURN distinct labels(a), COUNT(a)

15. Listar las personas que conocen a la persona con apellido “Lupis” desde antes del año 2000.
```
MATCH (p1:Persona{apellido:"Lupis"})-[r:CONOCE_A]-(p2:Persona)
WHERE r.fechad<'2000'
RETURN p2.nombre
```
Nota: Se destaca que la relación CONOCE_A se marca como bidireccional suponiendo que hay un conocimiento recíproco entre ambas personas

16. Listar los conocimientos que son poseídos por más de una persona. Mostrar el nombre y el id.

```
MATCH (c:Conocimiento)<-[r:POSEE]-(p:Persona)
WITH c,COUNT(p) AS CANTIDAD
WHERE CANTIDAD > 1
RETURN id(c),c.nombre
```


Nota IMPORTANTE: Se destaca que el cálculo de una función de agregación dentro de una operación “WHERE” NO es posible, por lo que la siguiente query FALLA:


```
MATCH (c:Conocimiento)<-[r:POSEE]-(p:Persona)
WHERE COUNT(p) > 1
RETURN id(c),c.nombre
``` 

17. Crear la persona con apellido "Garnica" y nombre "Ana".
```
CREATE (p:Persona{apellido:"Garnica",nombre:"Ana"})
RETURN p
```

18. Listar todas las personas que no posean una propiedad mail.

```
MATCH (p:Persona)
WHERE NOT EXISTS (p.email)
RETURN p
```

19. Listar las Personas que trabajaron en más de 2 empresas.

```
MATCH (p:Persona)-[t:TRABAJO]->(e:Empresa)
WITH p,count(e) as cantidad
WHERE cantidad > 2
RETURN p
```

20. Crear dos personas con la propiedad apellido con los valores APE1 y APE2.

```
CREATE (p1:Persona{apellido:"APE1"})
CREATE (p2:Persona{apellido:"APE2"})
RETURN p1,p2
```

21. Crear dos relaciones POSEE conocimiento "C++" para las personas creadas en el punto anterior.
```
MATCH (p:Persona{apellido:"APE1"}), (c:Conocimiento{nombre:"C++"})
CREATE (p)-[r:POSEE]->(c)
RETURN p, r, c

MATCH (p:Persona{apellido:"APE2"}),
(c:Conocimiento{nombre:"C++"})
CREATE (p)-[r:POSEE]->(c)
RETURN p, r, c
```

22. Crear la relación persona con apellido APE1 CONOCE_A a la persona con apellido APE2
```
MATCH (p1:Persona{apellido:"APE1"}), (p2:Persona{apellido:"APE2"})
CREATE (p1)-[r:CONOCE_A]->(p2)
RETURN p1, p2, r
```

23. Crear dos relaciones TRABAJO en la empresa Lan para las dos personas creadas.
```
MATCH (p:Persona{apellido:"APE1"}), (e:Empresa{nombre:"Lan"})
CREATE (p)-[r:TRABAJO]->(e)
RETURN p, e, r

MATCH (p:Persona{apellido:"APE2"}), (e:Empresa{nombre:"Lan"})
CREATE (p)-[r:TRABAJO]->(e)
RETURN p, e, r
```

24. Listar los id de las personas con apellido que contengan el substring "PE".
```
MATCH (p:Persona)
WHERE p.apellido =~ '.*PE.*'
RETURN id(p)
```

25. Eliminar las relaciones de tipo TRABAJO para las personas con apellido que comience con "APE".
```
MATCH (p:Persona)-[r:TRABAJO]-(c:Empresa)
WHERE p.apellido =~ 'APE.*'
DELETE r
```

26. Eliminar a la persona APE1 y todas sus relaciones.
```
MATCH (p:Persona{apellido:"APE1"})-[r]-()
DELETE p,r
```

27. Eliminar la relación POSEE conocimiento "C++" de la persona con apellido que contenga el substring "PE2".
```
MATCH (p:Persona)-[r:POSEE]-(c:Conocimiento{nombre:"C++"})
WHERE p.apellido =~ '.*PE2.*'
DELETE r
```

28. Eliminar la persona con apellido "APE2". Informe lo sucedido.
```
MATCH (p:Persona{apellido:"APE2"})
DELETE p
```
Se pudo borrar correctamente, porque en el punto 27 se borro la unica relacion que tenia la
persona con apellido APE2


29. Listar la cantidad de personas y el nombre de la carrera que estudian, donde las carreras pertenezcan a alguna de las instituciones que comience con "UTN", siempre y
cuando la cantidad de personas sea mayor que 1.
``` 
MATCH(p:Persona)-[r:ESTUDIO]->(c:Carrera)-[r1:DICTADA_EN]->(i:Institucion)
WITH i,c,count(p) AS cantidad
WHERE i.nombre=~"UTN.*" AND cantidad > 1
RETURN cantidad,c.nombre
```
