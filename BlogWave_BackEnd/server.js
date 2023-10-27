const express =require('express')
const app =express();
const bodyParser=require('body-parser');
const morgan=require('morgan');
const userRoute=require('./api/routes/create_user_route');
const updateUserRoute=require('./api/routes/user_profile_route');
const projectRoute=require('./api/routes/project_route');
const blogRoute=require('./api/routes/blog_route');
const commentRoute=require('./api/routes/commets_route');
const emailRoute=require('./api/routes/email_route');



app.use(bodyParser.json());// show that which type of data in coming from body 
app.use(bodyParser.urlencoded({ extended: false }));
app.use(morgan('dev'));

// Routes
app.use('/user',userRoute);
app.use('/Portfolio',updateUserRoute);
app.use('/Project',projectRoute);
app.use('/blog',blogRoute);
app.use('/comment',commentRoute);
app.use('/mail',emailRoute);



//  Error handlling middleware

app.use((req, res, next) => {
    const error = new Error('not found');
    error.status = 404;
    next(error)
});

app.use((error, req, res, next) => {
    res.status(error.status || 500)
    res.json({
        error: {
            message: error.message
        }
    });
});

module.exports=app