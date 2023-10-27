const commentModel = require('../model/comment_model')
const userModel = require('../model/users_model');

const addComment =  (req, res, next) => {
    const comment = req.body;

    commentModel.create({
        description: comment.description,
        blogId: comment.blogId,
        userId: comment.userId,
    },).then(async (comment) => {
        userModel.findOne({ where: { id: comment.userId } })
            .then((userData) => {
                // return res.status(200).json({ success: true, userData: result });
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

                return res.status(201).json([mergedData]);

            });
        // comment.add("user", userData);
    }).catch(err => {
        return res.status(500).json({ message: "comment Add failed", error: err });
    })
};


const getComment = (req, res, next) => {
    commentModel.findAll({ where: { blogId: req.body.blogId }, include: userModel }).then((comment) => {
        return res.status(200).json(comment.reverse());

    }).catch(err => {
        return res.status(500).json({ message: "Fetching comment Failed", error: err });

    })
}


module.exports={addComment,getComment};