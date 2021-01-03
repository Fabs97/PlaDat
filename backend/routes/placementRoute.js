const router = require('express').Router();

const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;

const placementService = require('../services/placementService');

/* This API gets a JSON in the body of the request that contain the information about the new placemen
 * This information is supposed to be collected by the frontend and sent when the user click the "publish the placement" button
 * The fields of the JSON are: position, workingHours, startPeriod, endPeriod, salary, descriptionRole, institution, major
 */
router.post("/placement/new-placement", async (req, res, next) => {
    let newPlacement = await placementService.savePlacement(req.body, req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(newPlacement);

});

// this API just get you the correspondent placement based on the id
// it is returned in a json with these fields:
// id, position, workingHours, startPeriod, endPeriod, salary, descriptionRole, institution, major 
router.get('/placement/:id', async (req, res, next) => {
    const placement = await placementService.getPlacementById(req.params.id); 
    res.json(placement);
});


// this api return all the ids of all the placements
router.get('/placement', async (req, res, next) => {
    //AUTH: DANGEROUS, WE SHOULD REMOVE
    const placements = await placementService.getAllPlacementsIds();
    res.json(placements);

});

router.get('/employer/:employerId/placements', async (req, res, next) => {
    const placements = await placementService.getPlacementsByEmployerId(parseInt(req.params.employerId), req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(placements);
});

router.delete('/placement/:id', async (req, res, next) => {
    let result = await placementService.deletePlacementById(req.params.id, req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(result);
})

router.get('/placements/last', async (req, res, next) => {
    let result = await placementService.getLastPlacement(req.user);
    res.json(result);
})

router.put('/placement/:id/close', async (req, res, next) => {
    if(!isNaN(req.params.id)){
        let result = await placementService.closePlacementById(req.params.id, req.user)
            .catch(error => {
                res.status(error.code).send(error.message);
            })
        res.send(result);
    } else {
        res.status(ERR_BAD_REQUEST).send('The request does not contains a valid placement id. Please try again.')
    }

})

module.exports = router;