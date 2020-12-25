const router = require('express').Router();

const placementService = require('../services/placementService');

/* This API gets a JSON in the body of the request that contain the information about the new placemen
 * This information is supposed to be collected by the frontend and sent when the user click the "publish the placement" button
 * The fields of the JSON are: position, workingHours, startPeriod, endPeriod, salary, descriptionRole, institution, major
 */
router.post("/placement/new-placement", async (req, res, next) => {
    //AUTH: ONLY EMPLOYERS ARE ALLOWED 
    let newPlacement = await placementService.savePlacementPage(req.body)
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
    //AUTH: EMPLOYER ID HAS TO BE THE ONE LOGGED IN 
    const placements = await placementService.getPlacementsByEmployerId(req.params.employerId);
    res.json(placements);
});

router.delete('/placement/:id', async (req, res, next) => {
    //AUTH: THE EMPLOYER THAT DELETES THIS IS ALSO THE ONE WHICH 
    let result = await placementService.deletePlacementById(req.params.id);
    res.json(result);
})

router.get('/placements/last', async (req, res, next) => {
    let result = await placementService.getLastPlacement();
    res.json(result);
})

module.exports = router;