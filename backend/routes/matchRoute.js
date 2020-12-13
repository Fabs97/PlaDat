const router = require('express').Router();

const matchService = require('../services/matchService');
const SuperError = require('../errors').SuperError;
const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;


router.post("/matching", async (req, res, next) => {
    const choice = await matchService.saveChoice(req.body);
    res.json(choice);

});

router.get('/student/:studentId/placements', async (req, res, next) => {
    const placements = await matchService.getMatchesByStudentId(req.params.studentId)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(placements);
});

router.delete('/match/:studentId/:placementId', async (req, res, next) => {
    if( !isNaN(req.params.studentId) && !isNaN(req.params.placementId)){
        let match = await matchService.deleteMatch(req.params.studentId, req.params.placementId)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
        res.json(match);
    } else {
        res.status(ERR_BAD_REQUEST).send('Your request did not provided valid values for ids. Please try again.');
    }
    
});

module.exports = router;