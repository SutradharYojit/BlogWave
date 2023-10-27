const sqConnect = require('../connection/database_connection')
const userModel = require('./users_model');
const Sequelize = require('sequelize');


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


userModel.hasMany(blogTable, {
    foriegnKey: {
        allowNull: false
    }
})

blogTable.belongsTo(userModel);

module.exports=blogTable;