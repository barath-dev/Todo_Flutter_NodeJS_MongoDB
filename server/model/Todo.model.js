const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');
const UserModel = require('../model/User.model');

const {Schema, model} = mongoose;

const todoSchema = new  Schema({
    userId:{
        type:Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    title:{
       type:String,
       required:true,

    },
    description: {
        type : String,
        required:true,
    },
});

const todoModel = model('Todo',todoSchema);

module.exports = todoModel;