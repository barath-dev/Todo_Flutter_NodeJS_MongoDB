const express = require('express');
const app = express();
const db = require("./config/db");
const UserModel = require('./model/User.model');
const TodoModel = require('./model/Todo.model');
const body_parser = require('body-parser');
const userRoute = require("./routers/user.route");
const todoRoute = require("./routers/todo.route");


app.use(body_parser.json());
app.use('/',userRoute);
app.use('/',todoRoute);


const PORT = 3001;

app.get('/',(req,res)=>{
    res.send("Hey your server routes are wokring");
});

app.listen(PORT,()=>{
    console.log("server running on " +PORT);
});

