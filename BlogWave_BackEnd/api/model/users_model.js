const sqConnect=require('../connection/database_connection')

const Sequelize = require('sequelize');

// const sequelize = new Sequelize('blog_app', 'postgres', '123456', {
//     host: 'localhost',
//     port_1: '5432',
//     dialect: 'postgres',
//     logging: false
// })

const UserTable = sqConnect.define('users', {
    id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false,
        primaryKey: true,
    },
    userName: {
        type: Sequelize.TEXT,
        allowNull: false,
    },
    email: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    password: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    profileUrl:{
        type: Sequelize.TEXT,
    },
    bio:{
        type: Sequelize.TEXT,
    },
});

console.log("Creating user database Table");

module.exports=UserTable;