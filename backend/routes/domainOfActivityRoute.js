const router = require('express').Router();

const domainOfActivityService = require('../services/domainOfActivityService');

router.get('/domainOfActivity', async (req, res, next) => {
    let domainsOfActivity = await domainOfActivityService.getAllDomainsOfActivity()
        .catch(error => {
            res.status(error.code).send(error.message);
        })
    res.json(domainsOfActivity);
});

module.exports = router;