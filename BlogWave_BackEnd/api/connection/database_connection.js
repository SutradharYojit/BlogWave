// Import Sequelize library
const Sequelize = require('sequelize');

// Create a new Sequelize instance for the database connection
const sequelize = new Sequelize('blog_app', 'postgres', '123456', {
    host: 'localhost', // Database server host
    port: '5432', // Port for the database connection
    dialect: 'postgres', // Dialect (PostgreSQL in this case)
    logging: false // Disable logging of SQL queries
});

module.exports = sequelize; // Export the configured Sequelize instance for use in other parts of the application
