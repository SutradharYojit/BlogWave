const commentModel = require('../model/comment_model')
const userModel = require('../model/users_model');

const addComment =  (req, res, next) => {
    const comment = req.body;

    commentModel.create({
        description: comment.description,
        blogId: comment.blogId,
        userId: comment.userId,
    }).then(async (comment) => {
        userModel.findOne({ where: { id: comment.userId } })
            .then((userData) => {
                // Create a merged data object that combines the comment data with the user data.
                const mergedData = {
                    id: comment.id,
                    description: comment.description,
                    blogId: comment.blogId,
                    createdAt: comment.createdAt,
                    updatedAt: comment.updatedAt,
                    userId: comment.userId,
                    user: {
                        id: userData.id,
                        userName: userData.userName,
                        email: userData.email,
                        password: userData.password,
                        profileUrl: userData.profileUrl,
                        bio: userData.bio,
                        createdAt: userData.createdAt,
                        updatedAt: userData.updatedAt
                    }
                };

                // Send a response with a status code of 201 (created) and the merged data.
                return res.status(201).json([mergedData]);
            });
    }).catch(err => {
        // If an error occurs during comment creation, send an error response with a status code of 500.
        return res.status(500).json({ message: "comment Add failed", error: err });
    })
};



const getComment = (req, res, next) => {
    commentModel.findAll({ where: { blogId: req.body.blogId }, include: userModel }).then((comment) => {
        // Fetch comments related to a specific blog entry based on the provided blogId.
        // The `include: userModel` option includes user information associated with each comment.

        // Reverse the order of comments (e.g., from oldest to newest).
        return res.status(200).json(comment.reverse());
    }).catch(err => {
        // If an error occurs during comment retrieval, send an error response with a status code of 500.
        return res.status(500).json({ message: "Fetching comment Failed", error: err });
    })
};



module.exports={addComment,getComment};