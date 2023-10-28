const jwtToken =require('jsonwebtoken');

checkAuth = (req, res, next) => {
    const token = req.headers.authorization.split(' ')[1];
    // Extract the JWT token from the request's "Authorization" header.

    console.log(token);

    try {
        const tokenVerify = jwtToken.verify(token, "secret");
        // Verify the JWT token using the "secret" as the secret key. Change "secret" to your actual secret key.

        console.log(tokenVerify);

        if (tokenVerify) {
            next();
            // If the token is verified, call the next middleware or route handler.
        } else {
            return res.status(401).send({
                message: 'Invalid Token',
                success: false
            });
            // If the token verification fails, respond with a status code of 401 and an "Invalid Token" message.
        }
    } catch {
        return res.status(401).send({
            message: 'Auth Failed',
            success: false
        });
        // If there is an exception (error) during token verification, respond with a status code of 401 and an "Auth Failed" message.
    }
};


module.exports=checkAuth;