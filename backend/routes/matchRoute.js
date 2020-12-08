const router = require('express').Router();

const matchService = require('../services/matchService');

router.post("/matching", async (req, res, next) => {
    const choice = await matchService.saveChoice(req.body);
    res.json(choice);

});

router.get('/student/:studentId/placements', async (req, res, next) => {
    const placements = await matchService.getMatchesByStudentId(req.params.studentId);
    res.json(placements);
});

module.exports = router;