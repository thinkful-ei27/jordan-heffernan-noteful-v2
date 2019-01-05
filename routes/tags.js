'use strict';

const express = require('express');
const knex = require('../knex');

const router = express.Router();

// GET all tags

router.get('/', (req, res, next) => {
  knex.select('id', 'name')
    .from('tags')
    .then(results => {
      res.json(results);
    })
    .catch*(err => next(err));
});

// GET tag by id

router.get('/:id', (req, res, next) => {
  const id = req.params.id;

  knex.select('id', 'name')
    .from('tags')
    .where('tags.id', id)
    .orderBy('tags.id')
    .then(([results]) => {
      res.json(results);})
    .catch(err => {
      next(err);
    });
});


//UPDATE tag

router.put('/:id', (req, res, next) => {
  const id = req.params.id;

  const updateObj = {};
  const updatableFields = ['name'];

  updatableFields.forEach(field => {
    if (field in req.body) {
      updateObj[field] = req.body[field];
    }
  });

  if(!updateObj.name) {
    const err = new Error('Missing `name` in request body');
    err.status = 400;
    return next(err);
  }

  knex
    .select('id', 'name')
    .from('tags')
    .where('tags.id', id)
    .update(updateObj, ['id', 'name'])
    .then(([item]) => {
      if (item) {
        res.json(item);
      } else {
        next();
      }
    })
    .catch(err => {
      next(err);
    });
});

//Create tag

router.post('/', (req, res, next) => {
  const { name } = req.body;
  const newItem = { name };

  if (!newItem.name) {
    const err = new Error('Missing `name` in request body');
    err.status = 400;
    return next(err);
  }

  knex
    .into('tags')
    .returning(['id', 'name'])
    .insert(newItem)
    .then(([results]) => res.json(results))
    .catch(err => next(err));
});

//Delete tag

router.delete('/:id', (req, res, next) => {
  const id = req.params.id;

  knex
    .from('tags')
    .where('tags.id', id)
    .del()
    .then(res.sendStatus(204))
    .catch(err => next(err));
});

module.exports = router;