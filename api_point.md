## API Description

1. **Sign Up**:
   - HTTP Method: POST
   - Endpoint: `http://10.1.86.45:1234/user/signUp`
   - Request Body: JSON containing user information (username, email, password).

2. **Login**:
   - HTTP Method: POST
   - Endpoint: `http://10.1.86.45:1234/user/login`
   - Request Body: JSON containing user login information (email, password).

3. **Update User Profile**:
   - HTTP Method: POST
   - Endpoint: `http://10.1.86.45:1234/Portfolio/updateProfile`
   - Request Body: JSON with user profile information (user ID, username, email, bio, profile URL).

4. **Get User**:
   - HTTP Method: GET
   - Endpoint: `http://10.1.86.45:1234/Portfolio/getUser`
   - Authorization: Bearer Token
   - Request Body: JSON with the user's ID.

5. **Get All User**:
   - HTTP Method: GET
   - Endpoint: `http://10.1.86.45:1234/Portfolio/getUserAll`
   - Request Body: JSON with the user's ID.

6. **Get User Project**:
   - HTTP Method: GET
   - Endpoint: `http://10.1.86.45:1234/Project/userProjects`
   - Request Body: JSON with the project's ID.

7. **Update Project**:
   - HTTP Method: POST
   - Endpoint: `http://10.1.86.45:1234/Project/updateProject`
   - Request Body: JSON containing project information (title, description, technologies, project URL, and project ID).

8. **Create Project**:
   - HTTP Method: POST
   - Endpoint: `http://10.1.86.45:1234/Project/createproject`
   - Request Body: JSON with project details (title, description, technologies, project URL, and user ID).

9. **Delete Project**:
   - HTTP Method: DELETE
   - Endpoint: `http://10.1.86.45:1234/Project/deleteProject`
   - Request Body: JSON with the project's ID.

10. **Create Blog**:
    - HTTP Method: POST
    - Endpoint: `http://10.1.86.45:1234/blog/createBlog`
    - Request Body: JSON with blog details (title, description, categories, tags, and blog image URL).

10. **Delete Blog**:
    - HTTP Method: DELETE
    - Endpoint: `http://10.1.86.45:1234/blog/deleteBlog`
    - Request Body: JSON with blog details (id).

10. **Edit Blog**:
    - HTTP Method: POST
    - Endpoint: `http://10.1.86.45:1234/blog/updateBlog`
    - Request Body: JSON with blog details (title, description, categories, tags, and blog image URL,id).


 Here's a table summarizing the API endpoints :

| Request Type | Endpoint                  | Description                       |
|--------------|---------------------------|-----------------------------------|
| POST         | http://10.1.86.45:1234/user/signUp     | Sign Up                           |
| POST         | http://10.1.86.45:1234/user/login      | Login                             |
| POST         | http://10.1.86.45:1234/Portfolio/updateProfile | Update User Profile            |
| GET          | http://10.1.86.45:1234/Portfolio/getUser | Get User                           |
| GET          | http://10.1.86.45:1234/Portfolio/getUserAll | Get All User                     |
| GET          | http://10.1.86.45:1234/Project/userProjects | Get User Project                |
| POST         | http://10.1.86.45:1234/Project/updateProject | Update Project               |
| POST         | http://10.1.86.45:1234/Project/createproject | Create Project                  |
| DELETE       | http://10.1.86.45:1234/Project/deleteProject | Delete Project               |
| POST         | http://10.1.86.45:1234/blog/createBlog   | Create Blog                       |
| POST         | http://10.1.86.45:1234/blog/updateBlog   | Update Blog                       |
| DELETE         | http://10.1.86.45:1234/blog/deleteBlog   | Delete Blog                       |


This table includes the request type (e.g., POST, GET, DELETE), the endpoint URL, and a brief description of the purpose of each API endpoint in your documentation.

These are the various API endpoints and their respective details for actions like user management, project management, and creating blogs in the BlogWave application. To interact with these endpoints, you need to use an HTTP client or library in your chosen programming language. Make sure to replace `<token>`, `<user_id>`, and other placeholders with actual values when making API requests.