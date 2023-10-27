const express = require("express");
const router = express();
const checkAuth=require('../middleware/check_auth');
const mailCtrl=require('../controller/send_mail_ctrl');



router.post('/sendEmail', checkAuth,mailCtrl);



module.exports=router;