# Curso Neo4j
## Práctica 1  


Un supermercado online desea tener un sistema en el que se encuentre cargada toda la información necesaria para dar recomendaciones de productos a sus clientes y realizar otras
consultas de análisis de datos.   

- Las personas tienen un id y de ellas se conocen su nombre y apellido.     
- Algunas personas pueden conocer también a otras personas.   
- También existen los productos, y fabricantes de productos.   
- Los productos podrán ser agrupados en categorías.    
- De todo lo que sea modelado como entidad tendrá un nombre y id numérico.   


En base a esta información armar el modelado del grafo, decidiendo cómo almacenar la información disponible entre entidades, relaciones, propiedades y tipos para que tenga un sentido
práctico, pudiendo en un futuro realizar recomendaciones de productos a clientes similares y que permita resolver las siguientes consultas:



1. Listar todos los productos con su nombre.

```
MATCH (p:Producto)
RETURN p
```

2. Listar los productos (id y nombre) de la categoría con nombre “Deporte”.

```
MATCH (p:Producto)-[r:PERTENECE]->(c:Categoria {descripcion: 'Deporte'})
RETURN p.id, p.nombre
```

3. Listar las personas que compraron algún producto con id 1.

```
MATCH (pe:Persona)-[r:COMPRO]->(pr:Producto {id: 1})
RETURN pe.nombre, pe.apellido
```

4. Listar productos comprados por una persona de nombre Agustín.

```
MATCH (pe:Persona {nombre: 'Agustin'})-[r:COMPRO]->(pr:Producto)
RETURN pr.nombre
```

5. Listar todas las personas con sus productos comprados y el nombre de su fabricante

```
MATCH (pe:Persona)-[r:COMPRO]->(pr:Producto)
OPTIONAL MATCH (pr)<-[f:FABRICA]-(fa:Fabricante)
RETURN pe.nombre, pe.apellido, pr.id, pr.nombre, fa.nombre
```

6. Listar todas las vistas que tuvieron los productos junto con el nombre y apellido de la persona que los vio.

```
MATCH (pe:Persona)-[r:VIO]->(pr:Producto)
RETURN pe.nombre, pe.apellido, pr.nombre
```

7. Listar todos los productos cuyas review tienen un ranking mayor a 3.

```
MATCH (p:Producto)-[:TIENE]->(r:Review)
WHERE r.ranking > 3
RETURN p.nombre, r.ranking
```

8. Realizar una recomendación a una persona, p1, de un producto a comprar. La recomendación para p1 debe ser un producto que haya sido comprado por otras personas
que compraron algún producto que compro p1.

```
MATCH (p:Persona{nombre:"Gonzalo"})-[r:COMPRO]->(pr:Producto)<-[re:COMPRO]-(pe:Persona)-[rel:COMPRO]->(prod:Producto)
WHERE NOT (p:Persona)-[:COMPRO]->(prod:Producto)
RETURN DISTINCT (pe.nombre) AS Recomienda, (p.nombre) AS Recomendado,
(prod.nombre) AS Producto_Recomendado
ORDER BY pe.nombre
```

Bonus: Ordenar descendentemente los productos recomendados por un score. El score es la cantidad de personas que compran el producto que compro p1 y el producto
recomendado.


```
MATCH (p:Persona{nombre:"Gonzalo"})-[:COMPRO]->(pr1:Producto)<-[:COMPRO]-(op:Persona)-[:COMPRO]->(prod:Producto)
WHERE NOT (p:Persona)-[:COMPRO]->(prod:Producto)
RETURN prod.nombre as `Recomendacion`,count(op) as `Score`
ORDER BY count(op) DESC
```


9. Listar posibles amigos de una persona, p1, es decir personas a las que conocidos de p1 conocen.

```
MATCH (p:Persona {nombre:"Maria"})-[:CONOCE*2]->(p1:Persona)
RETURN p1.nombre as `Posible amigo`
```

Se deberá armar el modelo del grafo y las instrucciones que permitan crear dicho grafo.

(Ver script)
