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
        return res.status(201).json({ message: "project add succesfully", success: true, });

    }).catch(err => {
        return res.status(500).json({ message: "Project Add failed", error: err });

    })
}

const getproject = (req, res, next) => {
    projectModel.findAll().then((project) => {
        return res.status(200).json(project);

    }).catch(err => {
        return res.status(500).json({ message: "Fetching project Failed", error: err });

    })
}

const userProject = (req, res, next) => {
    projectModel.findAll({ where: { userId: req.body.id } }).then((project) => {
        return res.status(200).json(project.reverse());

    }).catch(err => {
        return res.status(500).json({ message: "Fetching project Failed", error: err });

    })
}

const updateProject = async (req, res, next) => {
    const update = req.body;
    await projectModel.update({
        title: update.title,
        description: update.description,
        technologies: update.technologies,
        projectUrl: update.projectUrl,
    },
        { where: { id: update.id } })
        .then(() => {
            return res.status(201).json({ staus: true, message: "project updated successfully" });

        }).catch(err => {
            return res.status(500).json({ message: "Project update failed", error: err });
        })
};


const deleteProject=async (req, res, next) => {
    try {
        await projectModel.destroy({ where: { id: req.body.id } })
            .then(() => {
                return res.status(201).json({ message: "Project Delete successfully" });
            });
    } catch (err) {
        console.error("Error Delete data:", err);
        return res.status(500).json({ message: "Getting Delete failed", error: err });
    }
}


module.exports = { addProject, getproject,userProject,updateProject,deleteProject }