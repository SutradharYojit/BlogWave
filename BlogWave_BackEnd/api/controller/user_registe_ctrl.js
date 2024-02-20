const userModel = require('../model/users_model')
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken')

const signUpUser = (req, res, next) => {
    const body = req.body;
    userModel.count({ where: { email: req.body.email } }).then(count => {
        console.log(count);
        if (count > 0) {
            return res.status(403).json({ message: "User Alredy Exist", success: false });
        } else {
            try {
                bcrypt.hash(body.password, 10, function l̥(err, hash) {

                    if (err) {
                        return res.status(400).json({ message: "Bad Request", success: false, });
                    }
                    if (hash) {
                        const jwtToken = jwt.sign({ email: req.body.email }, "secret");
                        userModel.create({ userName: body.userName, email: body.email, password: hash })
                            .then((result) => {
                                return res.status(201).json({ message: "SignUp succesfully", success: true, userId: result.id, token: jwtToken });
                            });
                    }
                });
            } catch (err) {
                console.log("Error Inserting user " + err.message);
                return res.status(500).json({ message: "Insertation failed", Error: err.message });
            }
        }

    });

}

const loginUser = async (req, res, next) => {
    try {
        userModel.findOne({ where: { email: req.body.email } }).then((result) => {

            bcrypt.compare(req.body.password, result.password, function (err, passSuccess) {
                if (err) {
                    return res.status(403).json({ message: "Failed ", success: false, Error: err.message });
                }
                if (passSuccess) {
                    const jwtToken = jwt.sign({ email: req.body.email }, "secret");

                    return res.status(201).json({ message: "Login Successfully", success: true, userId: result.id, token: jwtToken });
                }
                return res.status(401).json({ message: "UnAuthorised User", success: false });

            });
        });

    } catch (err) {
        console.log("Error logging user " + err.message);
        res.status(500).json({ message: "Login failed", Error: err.message });
    }
}

module.exports = { signUpUser, loginUser }