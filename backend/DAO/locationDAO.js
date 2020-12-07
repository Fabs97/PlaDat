const database = require('../DB/connection');

const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    saveLocation: async (details) => {
        let result = await database('location')
            .returning()
            .insert({
                country: details.country,
                city: details.city
            }, ['id', 'country', 'city'])
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'there has been a problem saving your location. Please try again.')
                }
            });
        return result[0];
    },

    findLocationByDetails: async (details) => {
        let result = await database('location')
            .select('id', 'country', 'city')
            .where('country', details.country)
            .andWhere('city', details.city)
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'there has been a problem looking up your location. Please try again.')
                }
            });
        return result[0];
    }


}