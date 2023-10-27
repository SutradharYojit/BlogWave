const jwtToken =require('jsonwebtoken');

checkAuth=(req,res,next)=>{

    const token = req.headers.authorization.split(' ')[1];
    console.log(token);
    try{
        const tokenVerfiy =jwtToken.verify(token,"secret");
        console.log(tokenVerfiy);
        if(tokenVerfiy){
            next();

        }else{
            return  res.status(401).send({
                message: 'Invalid Token',
                sucess: false

            });
        }
    }catch{
        return  res.status(401).send({
            message: 'Auth Failed third',
            sucess: false
        });
    }
}

module.exports=checkAuth;