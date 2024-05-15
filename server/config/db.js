const mongoose = require('mongoose');

const connection  = mongoose.connect('mongodb+srv://admin:admin@flutter.h7wszxg.mongodb.net/?retryWrites=true&w=majority&appName=Flutter');

connection.then(()=>{
    console.log('Connected to MongoDB');
}).catch((err)=>{
    console.log('Error: ', err);
});

module.export  = connection