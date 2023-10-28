const router = require('express').Router();
const checkAuth=require('../middleware/check_auth');
const profileCtrl=require('../controller/user_profile_ctrl');

// POST api to update user profile
router.post('/updateProfile',checkAuth,profileCtrl.updateProfile );

// GET api to get user profile info
router.get('/getUser',checkAuth ,profileCtrl.getUser);

// GEt api to fetch all users profile
router.get('/getUserAll',checkAuth,profileCtrl.getUserAll);

module.exports = router;