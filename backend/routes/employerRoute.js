const router = require('express').Router();

const employerService = require('../services/employerService');

router.get("/employer/:id", async (req, res, next) => {
    const employer = await employerService.getEmployer(req.params.id);
    res.json(employer);

});

router.get('/employers/last', async (req, res, next) => {
    const employerId = await employerService.getLastEmployer();
    res.json(employerId)
})


module.exports = router;