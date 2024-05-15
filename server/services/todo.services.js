const TodoModel = require('../model/Todo.model');

class TodoServices{
    static async createTodo(userId,title,description){
        const createTodo = new TodoModel({userId,title,description});
        return await createTodo.save();
    }

    static async getUserTodo(userId){
        const todoData = await TodoModel.find({userId});
        return todoData;
    }
}

module.exports = TodoServices;