const router = require('express').Router();
const recommendationService = require('../services/recommendationService');
const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;

router.get('/recommendation/:id/seePlacements', async (req, res, next) => {

    if(!isNaN(req.params.id)){
        let recommendations = await recommendationService.getPlacementRecommendationsForStudent(req.params.id)
        .catch(error => {
            res.status(error.code).send(error.message);
        });

        res.json(recommendations);
    } else {
        res.status(ERR_BAD_REQUEST).send('Your request does not contains a valid student id. Please try again')
    }

    
});

router.get('/recommendation/:id/seeStudents', async (req, res, next) => {

    
    if(!isNaN(req.params.id)){
        let recommendations = await recommendationService.getStudentRecommendationsForPlacement(req.params.id)
        .catch(error => {
            res.status(error.code).send(error.message);
        });

        res.json(recommendations);
    } else {
        res.status(ERR_BAD_REQUEST).send('Your request does not contains a valid student id. Please try again')
    }
});

module.exports = router;
