const router = require('express').Router();

const skillsService = require('../services/skillsService');

router.get("/skills", async (req, res, next) => {

    const skills = await skillsService.getAvailableSkills();
    res.json(skills);

});


// this gets a skill known the name and type, useful for the research of the skills in the app (is a first version)
router.get('/skills/:type/:name', async (req, res, next) => {

    const skill = await skillsService.getSkillByNameAndType(req.params.name, req.params.type);
    res.json(skill);

});


module.exports = router;