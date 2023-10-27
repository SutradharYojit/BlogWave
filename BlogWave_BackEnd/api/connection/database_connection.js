
const Sequelize = require('sequelize');

const sequelize = new Sequelize('blog_app', 'postgres', '123456', {
    host: 'localhost',
    port_1: '5432',
    dialect: 'postgres',
    logging: false
})


module.exports = sequelize;
