const TodoServices = require('../services/todo.services');
const TodoSertvices = require('../services/todo.services');

exports.createTodo = async(req, res, next)=>{
    try {
        const {userId, title, description} = req.body;

        let todo = await TodoServices.createTodo(userId, title, description);

        
        if(!todo){
            res.status(401).json({
                message: "Todo not created",
            });
        }else{
            res.status(200).json({
                message: "Todo created",
                load:todo
            });
        }
        
    } catch (err) {
        next(err);
    }
}

exports.getUserTodo = async(req, res, next)=>{
    try {
        const {userId} = req.body;

        let todoList = await TodoServices.getUserTodo(userId);

        if(!todoList){
            res.status(401).json({
                message: "No todo found",
            });
        }
        else{
            res.status(200).json({
                message: "Todo found",
                data:todoList
            });
        }
        
    } catch (err) {
        next(err);
    }
}