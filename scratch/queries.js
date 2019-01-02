const knex = require('../knex');

let searchTerm = '';
knex
  .select('notes.id', 'title', 'content')
  .from('notes')
  .modify(function (queryBuilder) {
    if (searchTerm) {
      queryBuilder.where('title', 'like', `%${searchTerm}%`);
    }
  })
  .orderBy('notes.id')
  .then(results => {
    console.log(JSON.stringify(results, null, 2));
  })
  .catch(err => {
    console.error(err);
  });

// Get Note By Id accepts an ID. It returns the note as an object not an array

const id = 1006
knex
  .select('notes.id', 'title', 'content')
  .from('notes')
  .where('notes.id', id)
  .then(([results]) => {
    console.log(JSON.stringify(results))
  })

// Update Note By Id accepts an ID and an object with the desired updates. 
  // It returns the updated note as an object

const updateData = {
  title: 'Cats are the greatest',
  content: 'They are fluffy and soft and glorious'
}

knex 
  .select('notes.id', 'title', 'content')
  .from('notes')
  .where('notes.id', id)
  .update(updateData, ['id', 'title', 'content'])
  .then(([results]) => console.log(JSON.stringify(results)))

// Create a Note accepts an object with the note properties and inserts it in the DB. 
  // It returns the new note (including the new id) as an object.

const newNote = {
  title: 'Big Cat\'s big day out',
  content: 'Finds a mouse in a house and has a grand joust'
}

knex
  .into('notes')
  .returning(['id', 'title', 'content'])
  .insert(newNote)
  .then(([results]) => console.log(JSON.stringify(results)))

  // Delete Note By Id accepts an ID and deletes the note from the DB.

  const deleteID = 1001

  knex
    .from('notes')
    .where('notes.id', deleteID)
    .del()