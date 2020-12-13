
const router = require('express').Router();

const https = require('https');
require('dotenv').config({ path: '../.env' })


router.get("/googleMaps", async (req, res, next) => {
    
    let connector = https.get("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\"" + req.body.input + "\"&types=address&language=en&key=" + process.env.GPLACES_APIKEY , (resp) => {
        resp.pipe(res);
        res.setHeader('content-type', 'application/json');
      })
    req.pipe(connector);
})

module.exports = router;