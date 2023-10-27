const express = require('express')
const router = express();
const checkAuth=require('../middleware/check_auth');
const commentCtrl=require('../controller/commet_ctrl');


// API to add new comments on BLogs 
router.post('/addComment', checkAuth,commentCtrl.addComment);

//API to get Comments on specific blogs
router.get('/getComment', checkAuth,commentCtrl.getComment);

module.exports = router;