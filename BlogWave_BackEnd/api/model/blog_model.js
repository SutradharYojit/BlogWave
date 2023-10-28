const sqConnect = require('../connection/database_connection')
const userModel = require('./users_model');
const Sequelize = require('sequelize');

// Define the "blogs" table using Sequelize
const blogTable = sqConnect.define('blogs', {
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
    categories: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    tags: {
        type: Sequelize.ARRAY(Sequelize.TEXT),
        defaultValue: []
    },
    blogImgUrl: {
        type: Sequelize.TEXT,
    },
});

// Establish a relationship between the "blogs" table and the "users" table
userModel.hasMany(blogTable, {
    foriegnKey: {
        allowNull: false
    }
})

blogTable.belongsTo(userModel);

module.exports=blogTable;