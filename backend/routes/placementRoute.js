  
const router = require('express').Router();

const service = require('../services/placementService');

router.get("/placements", async (req, res, next) => {
    const placements = await service.getPlacements(req.params.id);
    res.json(placements);

});

module.exports = router;