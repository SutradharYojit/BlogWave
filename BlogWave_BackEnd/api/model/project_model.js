const sqConnect = require('../connection/database_connection')
const userModel = require('./users_model');
const Sequelize = require('sequelize');

// Define the "PROJECT TABLE" table using Sequelize

const projectTable = sqConnect.define('projects', {
    id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false,
        primaryKey: true,
    },
    title: {
        type: Sequelize.TEXT,
        allowNull: false,
    },
    description: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    technologies: {
        type: Sequelize.ARRAY(Sequelize.TEXT),
        defaultValue: []
    },
    projectUrl: {
        type: Sequelize.TEXT,
    },
});

// Establish a relationship between the "projects" table and the "users" table
userModel.hasMany(projectTable, {
    foriegnKey: {
        allowNull: false
    }
})

projectTable.belongsTo(userModel);


module.exports = projectTable;