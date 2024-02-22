const projectModel = require('../model/project_model');

const addProject = (req, res, next) => {
    const project = req.body;

    projectModel.create({
        title: project.title,
        description: project.description,
        technologies: project.technologies,
        projectUrl: project.projectUrl,
        userId: project.userId
    }).then(() => {
        // Create a new project entry in the database with the data provided in the request body.
        return res.status(201).json({ message: "project add successfully", success: true, });
        // Respond with a success message and a status code of 201 (Created) upon successful creation.
    }).catch(err => {
        // If an error occurs during project creation, send an error response with a status code of 500.
        return res.status(500).json({ message: "Project Add failed", error: err });

    })
};

const getproject = (req, res, next) => {
    projectModel.findAll().then((project) => {
        // Retrieve all project entries from the database.
        return res.status(200).json(project);
        // Respond with a JSON array of project entries and a status code of 200 (OK).
    }).catch(err => {
        // If an error occurs while fetching project entries, send an error response with a status code of 500.
        return res.status(500).json({ message: "Fetching project Failed", error: err });
    })
};

const userProject = (req, res, next) => {

    const userId = req.params.userId;
    projectModel.findAll({ where: { userId: userId } }).then((project) => {
        // Retrieve all project entries from the database where the userId matches the provided ID.
        return res.status(200).json(project.reverse());
        // Respond with a JSON array of project entries (in reverse order) and a status code of 200 (OK).
    }).catch(err => {
        // If an error occurs while fetching project entries, send an error response with a status code of 500.
        return res.status(500).json({ message: "Fetching project Failed", error: err });
    })
};

const updateProject = async (req, res, next) => {
    const update = req.body;
    // Retrieve the update data from the request body.
    await projectModel.update({
        title: update.title,
        description: update.description,
        technologies: update.technologies,
        projectUrl: update.projectUrl,
    },
        { where: { id: update.id } })
        // Update the project entry in the database based on the provided ID.
        .then(() => {
            return res.status(201).json({ staus: true, message: "project updated successfully" });
            // If the update is successful, respond with a success message and a status code of 201 (Created).

        }).catch(err => {
            return res.status(500).json({ message: "Project update failed", error: err });
            // If an error occurs during the update, send an error response with a status code of 500.
        });
};

const deleteProject = async (req, res, next) => {
    const projectId = req.params.projectId;
    try {
        await projectModel.destroy({ where: { id: projectId } })
            // Attempt to delete the project entry from the database based on the provided project ID.
            .then(() => {
                return res.status(201).json({ message: "Project Delete successfully" });
                // If the deletion is successful, respond with a success message and a status code of 201 (Created).
            });
    } catch (err) {
        console.error("Error Delete data:", err);
        // If an error occurs during deletion, log the error.

        return res.status(500).json({ message: "Getting Delete failed", error: err });
        // Send an error response with a status code of 500.
    }
};



module.exports = { addProject, getproject, userProject, updateProject, deleteProject }