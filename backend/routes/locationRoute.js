const router = require('express').Router();

const locationService = require('../services/locationService');

router.delete('/location/:id', async (req, res, next) => {
    await locationService.deleteLocationById(req.params.id);
    res.status(200).send("location deleted correctly");
})

module.exports = router;