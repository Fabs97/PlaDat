const router = require('express').Router();

const registrationService = require('../services/registrationService');

router.post("/registration", async ( req, res, next ) => {
    let userRegistration = await registrationService.createUserRegistration(req.body)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(userRegistration);
});

module.exports = router;