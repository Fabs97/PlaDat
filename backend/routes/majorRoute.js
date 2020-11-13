const router = require('express').Router();

const service = require('../services/majorService');

router.get("/majors", async (req, res, next) => {
    const majors = await service.getMajors(req.params.id);
    res.json(majors);

});

module.exports = router;