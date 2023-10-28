const sqConnect = require('../connection/database_connection')
const userModel = require('./users_model');

const Sequelize = require('sequelize');

// Define the "COMMENTS" table using Sequelize

const commentTable = sqConnect.define('comments', {
    id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false,
        primaryKey: true,
    },
    description: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    blogId: {
        type: Sequelize.UUID,
        allowNull: false
    },

});

// Establish a relationship between the "comments" table and the "users" table
userModel.hasMany(commentTable, {
    foriegnKey: {
        allowNull: false
    }
})

commentTable.belongsTo(userModel);

module.exports=commentTable;