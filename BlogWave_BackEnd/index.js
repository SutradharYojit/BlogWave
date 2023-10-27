const http = require('http')
// const Sequelize = require('sequelize')
const app = require('./server')
const sqConnect=require('./api/connection/database_connection')
const eseHe=require('./api/model/project_model');

const port = process.env.PORT || 1234;

// const sequelize = new Sequelize('blog_app', 'postgres', '123456', {
//     host: 'localhost',
//     port_1: '5432',
//     dialect: 'postgres',
//     logging: false
// })


async function connect() {
    try {
        await sqConnect.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}
connect();

const server = http.createServer(app)


sqConnect.sync().then(() => {
    server.listen(port, () => { 
        console.log(`Server running on port ${port}`);
    });
});

