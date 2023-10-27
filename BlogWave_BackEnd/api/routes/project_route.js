const express = require('express')
const router = express();
const checkAuth=require('../middleware/check_auth');
const projectCtrl=require('../controller/project_ctrl');



// Get user Projects
router.get('/getproject', checkAuth,projectCtrl.getproject);

router.get('/userProjects', checkAuth,projectCtrl.userProject);

router.post('/updateProject', checkAuth,projectCtrl.updateProject);

router.post('/createproject', checkAuth,projectCtrl.addProject);

router.delete('/deleteProject', checkAuth,projectCtrl.deleteProject);


module.exports = router;
