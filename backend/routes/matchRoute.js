const router = require('express').Router();

const matchService = require('../services/matchService');
const SuperError = require('../errors').SuperError;
const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;
const ERR_FORBIDDEN = require('../errors').ERR_FORBIDDEN;


router.post("/matching", async (req, res, next) => {
    const choice = await matchService.saveChoice(req.body);
    res.json(choice);

});

router.get('/student/:studentId/placements', async (req, res, next) => {
    if(parseInt(req.params.studentId) !== req.user.id) {
        res.status(ERR_FORBIDDEN).send('You are not authorized to retrieve this information');
        return;
    }
    const placements = await matchService.getMatchesByStudentId(req.params.studentId)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(placements);
});

router.delete('/match/:studentId/:placementId', async (req, res, next) => {
    if( !isNaN(req.params.studentId) && !isNaN(req.params.placementId)){
        let match = await matchService.deleteMatch(req.params.studentId, req.params.placementId, req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
        res.json(match);
    } else {
        res.status(ERR_BAD_REQUEST).send('Your request did not provided valid values for ids. Please try again.');
    }
    
});

router.get('/placement/:placementId/students', async (req, res, next) => {
    if(!isNaN(req.params.placementId)){
        let students = await matchService.getMatchesByPlacementId(req.params.placementId, req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
        res.json(students);
    } else {
        res.status(ERR_BAD_REQUEST).send('Your request did not provided a valid value for id. Please try again.');
    }
       
});


module.exports = router;