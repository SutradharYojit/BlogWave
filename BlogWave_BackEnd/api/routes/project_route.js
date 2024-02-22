const express = require('express')
const router = express();
const checkAuth = require('../middleware/check_auth');
const projectCtrl = require('../controller/project_ctrl');



// Get user Projects
router.get('/getproject', checkAuth, projectCtrl.getproject);

// GWET get user Projects
router.get('/userProjects/:userId', checkAuth, projectCtrl.userProject);

// POST api to update project
router.post('/updateProject', checkAuth, projectCtrl.updateProject);

// POST api to create new project
router.post('/createproject', checkAuth, projectCtrl.addProject);

// DELETE api to delete project
router.delete('/deleteProject/:projectId', checkAuth, projectCtrl.deleteProject);


module.exports = router;
