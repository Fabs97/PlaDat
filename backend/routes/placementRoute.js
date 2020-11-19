const router = require('express').Router();

const placementService = require('../services/placementService');

/* This API gets a JSON in the body of the request that contain the information about the new placemen
 * This information is supposed to be collected by the frontend and sent when the user click the "publish the placement" button
 * The fields of the JSON are: position, workingHours, startPeriod, endPeriod, salary, descriptionRole, institution, major
 */
router.post("/placement/new-placement", async (req, res, next) => {

    newPlacement = await placementService.savePlacementPage(req.body);
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

    const placements = await placementService.getAllPlacementsIds();
    res.json(placements);

});

module.exports = router;