const router = require('express').Router();
const recommendationService = require('../services/recommendationService');

router.get('/recommendation/:id/seePlacements', async (req, res, next) => {

    let recommendations = await recommendationService.getPlacementRecommendationsForStudent(req.params.id);
    res.json(recommendations);
});

router.get('/recommendation/:id/seeStudents', async (req, res, next) => {

    let recommendations = await recommendationService.getStudentRecommendationsForPlacement(req.params.id);
    res.json(recommendations);
});

module.exports = router;
