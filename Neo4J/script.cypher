CREATE (p:Persona {nombre: 'Antonio', apellido: 'Margheriti'});

CREATE (p:Persona {nombre: 'Maria', apellido: 'Bentu'});

CREATE (p:Persona {nombre: 'Agustin', apellido: 'Lopez'});

CREATE (p:Persona {nombre: 'Jose', apellido: 'Garcia'});

CREATE (p:Persona {nombre: 'Carolina', apellido: 'Lamitri'});

CREATE (p:Persona {nombre: 'Gonzalo', apellido: 'Pini'});

CREATE (f:Fabricante {nombre: 'Plastic SA'});

CREATE (c:Categoria {descripcion: 'Deporte'});

CREATE (p:Producto {id: 1, nombre: 'Zapatillas'});

CREATE (p:Producto {id: 2, nombre: 'Pelota de futbol'});

CREATE (p:Producto {id: 3, nombre: 'Raqueta'});

CREATE (p:Producto {id: 4, nombre: 'Arco'});

CREATE (r:Review {id: 1, ranking: 5});

CREATE (r:Review {id: 2, ranking: 4});

CREATE (r:Review {id: 3, ranking: 2});

MATCH (p:Producto {id: 1}), (c:Categoria {descripcion: 'Deporte'})
CREATE (p)-[r:PERTENECE]->(c);

MATCH (pe:Persona {nombre: 'Jose'}), (pr:Producto {id: 1})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Jose'}), (pr:Producto {id: 2})
CREATE (pe)-[r:VIO]->(pr);

MATCH (pe:Persona {nombre: 'Agustin'}), (pr:Producto {id: 1})
CREATE (pe)-[r:VIO]->(pr);

MATCH (pe:Persona {nombre: 'Maria'}), (pr:Producto {id: 3})
CREATE (pe)-[r:VIO]->(pr);

MATCH (pe:Persona {nombre: 'Maria'}), (pr:Producto {id: 1})
CREATE (pe)-[r:VIO]->(pr);

MATCH (pe:Persona {nombre: 'Agustin'}), (pr:Producto {id: 2})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (p:Producto {id: 1}), (f:Fabricante {nombre: 'Plastic SA'})
CREATE (p)<-[r:FABRICA]-(f);

MATCH (p:Producto {id: 3}), (f:Fabricante {nombre: 'Plastic SA'})
CREATE (p)<-[r:FABRICA]-(f);

MATCH (pe:Persona {nombre: 'Jose'}), (pr:Producto {id: 3})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Maria'}), (pr:Producto {id: 3})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Maria'}), (pr:Producto {id: 1})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Agustin'}), (pr:Producto {id: 1})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Gonzalo'}), (pr:Producto {id: 1})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Carolina'}), (pr:Producto {id: 4})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Carolina'}), (pr:Producto {id: 2})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (pe:Persona {nombre: 'Carolina'}), (pr:Producto {id: 3})
CREATE (pe)-[r:COMPRO]->(pr);

MATCH (p:Producto {id: 3}), (r:Review {ranking: 5})
CREATE (p)-[rel:TIENE]->(r);

MATCH (p:Producto {id: 2}), (r:Review {ranking: 4})
CREATE (p)-[rel:TIENE]->(r);

MATCH (p:Producto {id: 1}), (r:Review {ranking: 2})
CREATE (p)-[rel:TIENE]->(r);

MATCH (p:Persona {nombre: "Maria"}), (p2:Persona {nombre: "Carolina"})
CREATE (p)-[rel:CONOCE]->(p2);

MATCH (p:Persona {nombre: "Carolina"}), (p2:Persona {nombre: "Gonzalo"})
CREATE (p)-[rel:CONOCE]->(p2);

MATCH (p:Persona {nombre: "Gonzalo"}), (p2:Persona {nombre: "Agustin"})
CREATE (p)-[rel:CONOCE]->(p2);

MATCH (p:Persona {nombre: "Maria"}), (p2:Persona {nombre: "Jose"})
CREATE (p)-[rel:CONOCE]->(p2);
