const router = require('express').Router();
const userCtrl = require('../controller/user_registe_ctrl')
const checkToken = require('../middleware/check_auth')

// POST api to register user
router.post('/signUp', userCtrl.signUpUser);

// POST api to login user
router.post('/login', userCtrl.loginUser);

// POST api to check token
router.post('/checkToken', checkToken);

module.exports = router;