
const router = require('express').Router();

const googleMapsService = require('../services/googleMapsService');

router.get("/googleMaps", async (req, res, next) => {
    let result = await googleMapsService.getMapResult(req.body.input);
    res.send(result)

})

module.exports = router;