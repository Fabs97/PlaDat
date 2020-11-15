const router = require('express').Router();

const matchService = require('../services/matchService');

router.post("/matching", async (req, res, next) => {
    const choice = await matchService.saveChoice(req.body);
    res.json(choice);

});

module.exports = router;