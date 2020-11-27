const router = require('express').Router();

const employerService = require('../services/employerService');

router.get("/employer/:id", async (req, res, next) => {
    const employer = await employerService.getEmployer(req.params.id);
    res.json(employer);

});


module.exports = router;