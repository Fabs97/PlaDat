const router = require('express').Router();
const ERR_INTERNAL_SERVER_ERROR = require('../errors.js').ERR_INTERNAL_SERVER_ERROR
const registrationService = require('../services/registrationService');

router.post("/registration", async ( req, res, next ) => {
    let userRegistration = await registrationService.createUserRegistration(req.body)
        .catch(error => {
            res.status(error.code ? error.code : ERR_INTERNAL_SERVER_ERROR ).send(error.message);
        });
    res.json(userRegistration);
});

router.post("/login", async ( req, res, next ) => {
    let userProfile = await registrationService.getUserSession(req.body)
        .catch(error => {
            res.status(error.code ? error.code : ERR_INTERNAL_SERVER_ERROR ).send(error.message);
        });
    res.json(userProfile);
});

router.delete("/user/:id", async (req, res, next) => {
    let result = await registrationService.deleteUser(parseInt(req.params.id), req.user)
        .catch(error => {
            res.status(error.code ? error.code : ERR_INTERNAL_SERVER_ERROR ).send(error.message);
        });
    res.json(result)
})


module.exports = router;