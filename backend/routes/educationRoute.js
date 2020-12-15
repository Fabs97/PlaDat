const router = require('express').Router();

const educationService = require('../services/educationService')

router.get("/institutions", async (req, res, next) => {
    const institutions = await educationService.getInstitutions();
    res.json(institutions);

});

router.get("/majors", async (req, res, next) => {
    const majors = await educationService.getMajors();
    res.json(majors);

});

router.get("/degrees", async (req, res, next) => {
    const degrees = await educationService.getDegrees();
    res.json(degrees);

});

module.exports = router;