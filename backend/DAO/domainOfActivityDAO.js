const database = require('../DB/connection');

const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    getAllDomainsOfActivity: async () => {
        return await database('domain_of_activity')
            .select('id', 'name')
            .catch(error => {
                if (error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up domains of activity. Please try again.')
                }
            })
    }

}