const sqConnect = require('../connection/database_connection')
const userModel = require('./users_model');
const blogModel = require('./blog_model');

const Sequelize = require('sequelize');


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


userModel.hasMany(commentTable, {
    foriegnKey: {
        allowNull: false
    }
})

commentTable.belongsTo(userModel);

module.exports=commentTable;