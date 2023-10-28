const blogModel = require('../model/blog_model')


const createBlog = (req, res, next) => {
    const blog = req.body; // Extract the blog data from the request body.
    // Use the 'blogModel' to create a new blog entry in the database.
    blogModel.create({
        title: blog.title, // Set the 'title' field in the database with the 'blog.title' value.
        description: blog.description, // Set the 'description' field with the 'blog.description' value.
        categories: blog.categories, // Set the 'categories' field with the 'blog.categories' value.
        tags: blog.tags, // Set the 'tags' field with the 'blog.tags' value (assuming it's an array of tags).
        blogImgUrl: blog.blogImgUrl, // Set the 'blogImgUrl' field with the 'blog.blogImgUrl' value.
        userId: blog.userId // Set the 'userId' field with the 'blog.userId' value.
    }).then(() => {
        // If the blog entry is created successfully, send a success response.
        return res.status(201).json({ message: "Blog added successfully", success: true });
    }).catch(err => {
        // If there's an error during the creation process, send an error response.
        return res.status(500).json({ message: "Blog creation failed", error: err });
    });
};


const getBlog = (req, res, next) => {
    blogModel.findAll({
        order: [['createdAt', 'DESC']] // Fetch all blog entries and order them by 'createdAt' in descending order (latest date first).
    }).then((blogs) => {
        // If fetching the blog entries is successful, send a response with a status code of 200 and the list of blogs.
        return res.status(200).json(blogs);
    }).catch(err => {
        // If there's an error during the fetching process, send an error response.
        return res.status(500).json({ message: "Fetching blog entries failed", error: err });
    });
};

const updateBlogs = async (req, res, next) => {
    const update = req.body;

    await blogModel.update(
        {
            title: update.title,
            description: update.description,
            categories: update.categories,
            tags: update.tags, // list of tags
            blogImgUrl: update.blogImgUrl,
        },
        {
            where: { id: update.id } // Update the blog entry where the ID matches the provided 'id'.
        }
    ).then(() => {
        // If the blog entry is successfully updated, send a response with a status code of 201 (created) and a success message.
        return res.status(201).json({ status: true, message: "Blog updated successfully" });
    }).catch(err => {
        // If there's an error during the update process, send an error response.
        return res.status(500).json({ message: "Blog update failed", error: err });
    });
}


const deleteBlogs = async (req, res, next) => {
    try {
        await blogModel.destroy({ where: { id: req.body.id } })
            .then(() => {
                // If the blog entry is successfully deleted, send a response with a status code of 201 (created) and a success message.
                return res.status(201).json({ message: "Data Delete successfully" });
            });
    } catch (err) {
        console.error("Error Delete data:", err);
        // If an error occurs during the deletion process, send an error response with a status code of 500.
        return res.status(500).json({ message: "Getting Delete failed", error: err });
    }
}



module.exports = { createBlog, getBlog ,updateBlogs,deleteBlogs};