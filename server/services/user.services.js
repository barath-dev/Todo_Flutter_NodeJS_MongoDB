const UserModel = require('../model/User.model');
const jwt = require('jsonwebtoken');

class UserServices{

    static async registerUser(email, password){
        try {
            const createUser = new UserModel({email,password});
            return await createUser.save();
        } catch (err) {
           throw err
        }
    }

    static async checkUserExists(email){
        try {
            const userExists =  UserModel.findOne({email});
           return userExists? userExists:null;
        } catch (err) {
           throw err
        }
    }

    static async generateToken(tokenData, secretKey, jwt_expiry){
        return jwt.sign(tokenData,secretKey,{expiresIn: jwt_expiry});
    }
}

module.exports = UserServices;