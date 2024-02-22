const express = require('express')
const router = express();
const checkAuth=require('../middleware/check_auth');
const blogCtrl=require('../controller/blog_ctrl');
// API to create a new blog
router.post('/createBlog', checkAuth,blogCtrl.createBlog);

//API to Get Blogs
router.get('/getBlogs', checkAuth, blogCtrl.getBlog);

// API update BLOGS 
router.post('/updateBlog',checkAuth,blogCtrl.updateBlogs );

// Api Delete Blog
router.delete('/deleteBlog/:blogId',checkAuth, blogCtrl.deleteBlogs);

module.exports = router;