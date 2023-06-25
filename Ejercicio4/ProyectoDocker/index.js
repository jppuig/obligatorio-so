const express = require('express');
const { graphqlHTTP } = require('express-graphql');
const { buildSchema } = require('graphql');
const mongoose = require('mongoose');


mongoose.connect('mongodb://mongo:27017/notes', { useNewUrlParser: true, useUnifiedTopology: true });
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));


const noteSchema = new mongoose.Schema({
  title: { type: String, required: true },
  content: { type: String, required: true },
});


const Note = mongoose.model('Note', noteSchema);


const schema = buildSchema(`
  type Note {
    id: ID!
    title: String!
    content: String!
  }

  type Query {
    notes: [Note!]!
    noteById(id: ID!): Note
  }

  input NewNoteInput {
    title: String!
    content: String!
  }

  type Mutation {
    createNote(input: NewNoteInput!): Note!
  }
`);

const root = {
  notes: async () => {
    return await Note.find();
  },
  noteById: async ({ id }) => {
    return await Note.findById(id);
  },
  createNote: async ({ input }) => {
    const newNote = new Note({
      title: input.title,
      content: input.content,
    });
    await newNote.save();
    return newNote;
  },
};

const app = express();


app.use('/graphql', graphqlHTTP({
  schema: schema,
  rootValue: root,
  graphiql: true, 
}));


const port = process.env.PORT || 3001;
app.listen(port, () => {
  console.log(`Running a GraphQL API server at http://localhost:${port}/graphql`);
});