const userModel = require('../model/users_model');
const Sequelize = require('sequelize');
const Op = Sequelize.Op;

const updateProfile = async (req, res, next) => {
    const update = req.body;
    // Extract the user's profile information to update from the request body.
    await userModel.update({
        userName: update.userName,
        email: update.email,
        profileUrl: update.profileUrl,
        bio: update.bio
    },
        { where: { id: update.id } })
        // method to update the user's profile information in the database.
        .then(() => {
            return res.status(201).json({ staus: true, message: "Data updated successfully" });
            // Respond with a status code of 201 and a success message indicating that the data was updated successfully.
        });
};

const getUser = async (req, res, next) => {
    const userId = req.params.userId;
    // Extract the user's ID from the request body.
    await userModel.findOne({ where: { id: userId } })
        // Use Sequelize's `findOne` method to find a user record in the `userModel` table based on the provided user ID.
        .then((result) => {
            return res.status(200).json(result);
            // Respond with a status code of 200 and the user data as JSON, indicating success.
        }).catch((error) => {
            return res.status(404).json({ success: false, err: error });
            // If there's an error or the user is not found, respond with a status code of 404 and an error message.
        });
}

const getUserAll = (req, res, next) => {
    console.log(req.params);
    const currentUserId = req.params.userId;
    // Extract the user's ID from the request body.
    userModel.findAll({ where: { [Op.not]: [{ id: currentUserId }], } })
        // Use Sequelize's `findAll` method to find all user records in the `userModel` table, except the user with the specified ID (currentUserId).
        .then(users => {
            return res.status(200).json(users);
            // Respond with a status code of 200 and the list of user data as JSON, indicating success.
        }).catch(err => {
            return res.status(500).json({ message: "Fetching Failed", error: err });
            // If there's an error while fetching the user data, respond with a status code of 500 and an error message.
        });
}

module.exports = { updateProfile, getUser, getUserAll };