// Import required modules
const http = require('http');
const app = require('./server'); // Import the 'server.js' file
const sqConnect = require('./api/connection/database_connection'); // Import database connection setup

const port = process.env.PORT || 1234; // Define the server port

// Function to establish a connection to the database
async function connect() {
    try {
        await sqConnect.authenticate();
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}
connect(); // Call the 'connect' function to establish the database connection

// Create an HTTP server using the 'app' defined in 'server.js'
const server = http.createServer(app);

// Synchronize the database and start the server on the specified port
sqConnect.sync().then(() => {
    server.listen(port, () => { 
        console.log(`Server running on port ${port}`);
    });
});
