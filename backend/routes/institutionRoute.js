const router = require('express').Router();

const institutionsService = require('../services/institutionService');

router.get("/institutions", async (req, res, next) => {
    const institutions = await institutionsService.getInstitutions();
    res.json(institutions);

});


module.exports = router;