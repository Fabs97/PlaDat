
const https = require('https');
require('dotenv').config({ path: '../.env' })

module.exports = {
    getMapResult: async (input) => {
      return new Promise((resolve, reject) => {
        https.get('https://maps.googleapis.com/maps/api/place/autocomplete/json?input="' + input + '"&types=address&language=en&key=' + process.env.GPLACES_APIKEY, (resp) => {
            let data = '';

            // A chunk of data has been recieved.
            resp.on('data', (chunk) => {
              data += chunk;
            });
          
            // The whole response has been received. Print out the result.
            resp.on('end', () => {
              resolve(data);
            });
          
        }).on("error", (err) => {
            reject(error);
        });
      })
        
    },
}


