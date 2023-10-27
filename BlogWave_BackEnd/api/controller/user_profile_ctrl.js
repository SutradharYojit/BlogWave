const userModel = require('../model/users_model');
const Sequelize = require('sequelize');
const Op = Sequelize.Op;

const updateProfile = async (req, res, next) => {
    const update = req.body;
    await userModel.update({
        userName: update.userName,
        email: update.email,
        profileUrl: update.profileUrl,
        bio: update.bio
    },
        { where: { id: update.id } })
        .then(() => {
            return res.status(201).json({ staus: true, message: "Data updated successfully" });
        })
}


const getUser = async (req, res, next) => {
    const userId = req.body.id;
    await userModel.findOne({ where: { id: userId } })
        .then((result) => {
            return res.status(200).json({ success: true, userData: result });
        }).catch((error) => {
            return res.status(404).json({ success: false, err: error });
        });
}


const getUserAll = (req, res, next) => {
    const currentUserId = req.body.userId
    userModel.findAll({ where: { [Op.not]: [{ id: currentUserId }], } }).then(users => {
        return res.status(200).json(users);

    }).catch(err => {
        return res.status(500).json({ message: "Fetching  Failed", error: err });

    })
}
module.exports = { updateProfile, getUser,getUserAll };