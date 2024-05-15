const router = require('express').Router();
const TodoController = require('../controller/todo.controller');

router.post('/createTodo', TodoController.createTodo);

router.post('/getTodo',TodoController.getUserTodo);

module.exports = router;