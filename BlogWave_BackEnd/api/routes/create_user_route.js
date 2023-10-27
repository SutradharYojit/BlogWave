const router = require('express').Router();
const userCtrl = require('../controller/user_registe_ctrl')
const checkToken = require('../middleware/check_auth')

router.post('/signUp', userCtrl.signUpUser);

router.post('/login', userCtrl.loginUser);

router.post('/checkToken', checkToken);

module.exports = router;