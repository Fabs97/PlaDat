const router = require('express').Router();

const employerService = require('../services/employerService');

router.get("/employer/:id", async (req, res, next) => {
    const employer = await employerService.getEmployer(parseInt(req.params.id))
        .catch(error => {
            res.status(error.code).send(error.message);
        })
    res.json(employer);

});

router.post('/employer', async (req, res, next) => {
    const newEmployer = await employerService.createNewEmployer(req.body, req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        })
    res.json(newEmployer);
})

router.delete('/employer/:id', async (req, res, next) => {
    let response = await employerService.deleteEmployerById(parseInt(req.params.id), req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
            return;
        })
    res.status(200).send("employer deleted correctly")
    
})


module.exports = router;