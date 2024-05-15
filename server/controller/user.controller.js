const UserServices = require("../services/user.services");


exports.register = async(req, res, next)=>{
    try {
        const {email,password} = req.body;

        const response = await UserServices.registerUser(email,password);

        if(!response){
            res.status(401).json({
                message: "User not created",
            });
        }else{
            res.status(200).json({
                user:response
            });
        }
        
        
    } catch (error) {
        throw error
    }
}

exports.login = async(req, res, next)=>{
    try {
        const {email,password} = req.body;


        const user = await UserServices.checkUserExists(email);

        if(!user){
            res.status(404).json({
                message: "User not found",
            });
        }

        await user.comparePassword(password).then(async (result) => {
            if(!result){
                res.status(401).json({
                    message:"Incorrect password", 
                });
            }else{
                let tokenData = {_id:user._id,email:user.email }
        
                const token = await UserServices.generateToken(tokenData, "secret key",'1h');
        
                res.status(200).json({token:token});
            }
        }).catch((err) => {
            res.status(500).json({message:err});
        });

       

        
    } catch (error) {
        throw error
    }
}