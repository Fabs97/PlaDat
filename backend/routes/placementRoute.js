const router = require('express').Router();

const placementService = require('../services/placementService');

router.get("/placement/:id", async (req, res, next) => {

    const placement = await placementService.getPlacementById(req.params.id);
    res.json(placement);

});


module.exports = router;