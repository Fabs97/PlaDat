const router = require('express').Router();

const skillsService = require('../services/skillsService');

router.get("/skills", async (req, res, next) => {

    const skills = await skillsService.getAvailableSkills();
    res.json(skills);

});

module.exports = router;