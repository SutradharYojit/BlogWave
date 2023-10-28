// Import required modules
const express = require('express');
const app = express();
const bodyParser = require('body-parser'); // Middleware for parsing request bodies
const morgan = require('morgan'); // Middleware for logging HTTP requests
const userRoute = require('./api/routes/create_user_route'); // Import user-related routes
const updateUserRoute = require('./api/routes/user_profile_route'); // Import user profile routes
const projectRoute = require('./api/routes/project_route'); // Import project-related routes
const blogRoute = require('./api/routes/blog_route'); // Import blog-related routes
const commentRoute = require('./api/routes/commets_route'); // Import comment-related routes
const emailRoute = require('./api/routes/email_route'); // Import email-related routes

app.use(bodyParser.json()); // Middleware for parsing JSON data in request body
app.use(bodyParser.urlencoded({ extended: false })); // Middleware for parsing URL-encoded data
app.use(morgan('dev')); // Use morgan for HTTP request logging

// Define routes for various resources
app.use('/user', userRoute); // User-related routes
app.use('/Portfolio', updateUserRoute); // User profile routes
app.use('/Project', projectRoute); // Project-related routes
app.use('/blog', blogRoute); // Blog-related routes
app.use('/comment', commentRoute); // Comment-related routes
app.use('/mail', emailRoute); // Email-related routes

// Error handling middleware
app.use((req, res, next) => {
    const error = new Error('Not Found');
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message
        }
    });
});

module.exports = app; // Export the Express app for use in other files
