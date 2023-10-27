const blogModel = require('../model/blog_model')


const createBlog = (req, res, next) => {
    const blog = req.body;

    blogModel.create({
        title: blog.title,
        description: blog.description,
        categories: blog.categories,
        tags: blog.tags,// list of tags
        blogImgUrl: blog.blogImgUrl,
        userId: blog.userId
    }).then(() => {
        return res.status(201).json({ message: "blog add succesfully", success: true, });

    }).catch(err => {
        return res.status(500).json({ message: "blog Add failed", error: err });

    })
};


const getBlog = (req, res, next) => {
    blogModel.findAll({
        order: [['createdAt', 'DESC']] // Order by createdAt in descending order (latest date first)
    }).then((blogs) => {
        return res.status(200).json(blogs);
    }).catch(err => {
        return res.status(500).json({ message: "Fetching project Failed", error: err });
    });
};

const updateBlogs = async (req, res, next) => {
    const update = req.body;
    await blogModel.update({
        title: update.title,
        description: update.description,
        categories: update.categories,
        tags: update.tags,// list of tags
        blogImgUrl: update.blogImgUrl,
    },
        { where: { id: update.id } })
        .then(() => {
            return res.status(201).json({ staus: true, message: "Blog updated successfully" });

        }).catch(err => {
            return res.status(500).json({ message: "Blog update failed", error: err });
        })
}

const deleteBlogs =  async (req, res, next) => {
    try {
        await blogModel.destroy({ where: { id: req.body.id } })
            .then(() => {
                return res.status(201).json({ message: "Data Delete successfully" });
            });
    } catch (err) {
        console.error("Error Delete data:", err);
        return res.status(500).json({ message: "Getting Delete failed", error: err });
    }
}


module.exports = { createBlog, getBlog ,updateBlogs,deleteBlogs};