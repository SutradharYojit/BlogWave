# Personal Portfolio & Blog Platform App with Flutter and NodeJS

<img src="https://firebasestorage.googleapis.com/v0/b/blogapp-53499.appspot.com/o/usersProfile%2F276e63d2-a0dc-43fb-9327-67a2c9e294a8%2Fv-r3ix0SpIdFr6YajxGrbGzxNdY%3D?alt=media&token=62e3392a-d30b-49cb-94c5-363db5f793fc" width="400">


## Table of Contents

- Project Overview
- Objective
- Features
- Technologies
- Project Structure
- Getting Started
- User Authentication & Profile
- Portfolio Section
- Blogger Details
- Blog Section
- Blog Details
- Contact Form
- API Integration
- Version Control with Git
- Scrum Methodology
- Resources  

## Project Overview

Welcome to the Personal Portfolio & Blog Platform, mobile application designed to showcase your skills, projects, and writings.This platform integrates frontend, backend, and various technologies, providing a comprehensive solution to create, manage, and share your personal and professional journey with the world.


## Objective

The primary objective of this project is to demonstrate the integration of various technologies.
This BlogWave will serve as a showcase of your skills, projects, and writings. The key goals include:
 -  Creating a user-friendly and responsive web and mobile application.
- Implementing user authentication, allowing users to register, log in, and log out securely.
- Enabling users to create and manage their profiles, complete with a bio, profile picture, and contact details.
- Building a portfolio section to showcase personal projects with descriptions, technologies used, and links to demos or GitHub repositories.
- Developing a blog section with rich-text formatting, image embedding, and the ability to manage blog posts.
- Integrating a comment section for blog posts and the option to categorize or tag them.
- Implementing a contact form to allow visitors to send messages, which will be forwarded to your email.
- Ensuring secure backend APIs and deploying the platform on cloud services for accessibility.

## Features

1. **User Authentication & Profile:**
    - Register, login, and logout functionality.
    - User profile page with a bio, profile picture, and contact details.
    - Password encryption and JWT token generation.

2. **Portfolio Section:**
    - Display a list of personal projects with descriptions, technologies used, and links to live demos or GitHub repositories.
    - CRUD operations to add, update, or delete projects.

3. **Blog Section:**
    - Write, edit, and delete blog posts.
    - Support for rich-text formatting and image embedding.
    - Comment section for each blog post.
    - Categories or tags for blog posts.

4. **User Profile Section:**
    -  Alloq user to Write and edit his profile
    - Create Projects and Blogs
    - Logout from App

5. **Contact Form:**
    - Allow visitors to send a message through a contact form.
    - Backend service to receive and forward these messages to the user's email.

6. **Platform Devices:**
    - Native mobile application views for iOS and Android.

7. **API Integration:**
    - Connect the Flutter frontend with the Node.js backend.
    - Secure API endpoints.

8. **Version Control with Git:**
    - Regular commits with clear commit messages.
    - Use branches for different features or sections.

9. **Scrum Methodology:**
    - Break the project into smaller tasks or user stories.
    - Track progress using a tool like Trello or GitHub Projects.


## Technologies

In the development of Blog Wave, you'll leverage a variety of technologies and tools:

1. **Node.js and Express.js"**
    - Building a RESTful API with Node.js and Express.js.
    - To Store user data project used PostgreSQL.
2. **Flutter:**
    - Flutter is user to build multiple platforms Applications.

3. **Git & Version Control:**
    - Git is used for managing the project code.

## Getting Started

To get started with the  BlogWave follow these steps:

- Clone the project repository to your local machine.
- Set up the backend and frontend as described in their respective README files.
- Configure the necessary environment variables for security and functionality.
- Start the backend and frontend servers.
- Begin customizing your platform by adding projects, blog posts, and personal - information.

   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo

## User Authentication & Profile


The user authentication and profile functionality ensures a secure and personalized experience for users. This includes the ability to register, log in, and log out, as well as maintaining a user profile with essential details.

## Portfolio Section


The Portfolio Section allows you to showcase your personal projects with descriptions, technologies used, and links to live demos or GitHub repositories. You can easily manage your projects through CRUD operations.

## Blog Section


The Blog Section empowers you to write, edit, and delete blog posts. It supports rich-text formatting and image embedding and includes a comment section for each blog post. You can categorize or tag your blog posts for easier navigation.


## Contact Form


The Contact Form feature lets visitors send you messages through a user-friendly form. These messages are received and forwarded to your email via the backend service.

## API Endpoints

Certainly! Here's a table summarizing the API endpoints you provided:


## Authorization

| Method | EndPoint | Description | Auth token required |
| -------- | -------- | -------- | -------- |
| POST      | user      | signUp |  NO      |
| POST      | user      | login  |  NO   |


## Portfolio

| Method | EndPoint | Description | Auth token required |
| -------- | -------- | -------- | -------- |
| POST      | Portfolio      | getUser |  YES      |
| GET      | Portfolio      | updateProfile  |  YES   |
| GET      | Portfolio      | getUserAll  |  YES   |


## Project

| Method | EndPoint | Description | Auth token required |
| -------- | -------- | -------- | -------- |
| GET      | Portfolio      | getproject |  YES      |
| GET      | Portfolio      | userProjects  |  YES   |
| POST      | Portfolio      | updateProject  |  YES   |
| POST      | Portfolio      | createproject  |  YES   |
| DELETE      | Portfolio      | deleteProject  |  YES   |


## Blogs

| Method | EndPoint | Description | Auth token required |
| -------- | -------- | -------- | -------- |
| POST      | blog      | createBlog |  YES      |
| GET      | blog      | getBlogs  |  YES   |
| POST      | blog      | updateBlog  |  YES   |
| DELETE      | blog      | deleteBlog  |  YES   |

## Comment

| Method | EndPoint | Description | Auth token required |
| -------- | -------- | -------- | -------- |
| POST      | comment      | addComment |  YES      |
| GET      | comment      | getComment  |  YES   |


## Send Mail

| Method | EndPoint | Description | Auth token required |
| -------- | -------- | -------- | -------- |
| POST      | mail      | sendEmail |  YES      |

[Click Here](api_point.md). For more APi information


### Screenshots
<p align="center">
<img src="screenshots/splash_screen.png" width="231" height="500" align="left">
<img src="screenshots/login_screen.png" width="231" height="500" align="center">
<img src="screenshots/signup_screen.png" width="231" height="500" align="right">
</p>
<br>
<p align="center">
<img src="screenshots/portfolio_screen.png" width="231" height="500" align="left">
<img src="screenshots/blogger_details_screen.png" width="231" height="500" align="center">
<img src="screenshots/contact_screen.png" width="231" height="500" align="right">
</p>
<br>
<p align="center">
<img src="screenshots/blog_screen.png" width="231" height="500" align="left">
<img src="screenshots/blog_screen_2.png" width="231" height="500" align="center">
<img src="screenshots/blog_screen_3.png" width="231" height="500" align="right">
</p>
<br>
<p align="center">
<img src="screenshots/blog_details_1.png" width="231" height="500" align="left">
<img src="screenshots/blog_details_2.png" width="231" height="500" align="center">
<img src="screenshots/add_blog_screen.png" width="231" height="500" align="right">
</p>
<br>
<p align="center">
<img src="screenshots/user_profile_screen.png" width="231" height="500" align="left">
<img src="screenshots/edit_profile_screen_1.png" width="231" height="500" align="center">
<img src="screenshots/update_profile.png" width="231" height="500" align="right">
</p>
<p align="center">
<img src="screenshots/projects_screen.png" width="231" height="500" align="left">
<img src="screenshots/project_details.png" width="231" height="500" align="center">
<img src="screenshots/add_project.png" width="231" height="500" align="right">
</p>
<p align="center">
<img src="screenshots/delete_project.png" width="231" height="500" align="left">
<img src="screenshots/update_project.png" width="231" height="500" align="center">
<img src="screenshots/web_view.png" width="231" height="500" align="right">
</p>
<p align="center">
<img src="screenshots/edit_blog.png" width="231" height="500" align="left">
<img src="screenshots/mail.jpg" width="231" height="500" align="center">
<img src="screenshots/commet_screen_2.png" width="231" height="500" align="right">
</p>


## App Demo
```
https://drive.google.com/file/d/1DRo3T6sfIt1ZVaxi5t5dyG1GDuePy5v0/view
```
