
const router = require('express').Router();

const https = require('https');
require('dotenv').config({ path: '../.env' })


router.get("/googleMaps/:input", async (req, res, next) => {
    
  let connector = https.get("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\"" + req.params.input + "\"&types=address&key=" + process.env.GPLACES_APIKEY, (resp) => {
    resp.pipe(res);
    res.setHeader('content-type', 'application/json');
    res.setHeader('charset', 'utf-8');
  });
  req.pipe(connector);
})

module.exports = router;