# Prueba de funcionamiento

Ingrese a [GraphiQL](http://localhost:3001/graphql)  
**Cree una nota, con la siguiente llamada**

```
mutation Mutation{
  createNote(input: {
    title: "Note 1",
    content: "This is note 1"
  }){
    id,
    title,
    content
  }
}
```

**Si la aplicación funciona correctamente, la llamada devolverá la nota antes creada**

**Para probar que las notas quedan guardadas correctamente consulte con la siguiente llamada**  
Sustituya ? por la id de la nota que ustedes crearon

```
query Query{
  notes{
    id,
    title,
    content
  }
  noteById(id:"?"){
    title,
    content
  }
}
```

