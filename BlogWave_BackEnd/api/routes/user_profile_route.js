const router = require('express').Router();
const checkAuth=require('../middleware/check_auth');
const profileCtrl=require('../controller/user_profile_ctrl');


router.post('/updateProfile',checkAuth,profileCtrl.updateProfile );

router.get('/getUser',checkAuth ,profileCtrl.getUser);

router.get('/getUserAll',checkAuth,profileCtrl.getUserAll);

module.exports = router;