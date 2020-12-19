const database = require('../DB/connection');

const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {
    getEmployer: async (employer_id) => {
        let result = await database('employer')
            .select('name', 'location', 'urllogo')
            .where('id', employer_id);
        return result[0];
    },

    getLastEmployer: async () => {
        let result = await database("employer")
            .select("id")
            .orderBy("id", "desc")
            .limit(1);
        return result[0];
    },

    addNewEmployer: async (details) => {
        let result = await database('employer')
            .returning()
            .insert({
                name: details.name,
                description: details.description,
                domain_of_activity_id: details.domainOfActivityId
            }, ['id','name', 'description'])
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your profile');
                }
            });
        result = result[0];

        result.domain_of_activity = await database('domain_of_activity AS d')
            .select('d.id AS id', 'd.name AS name')
            .leftJoin('employer AS e', 'd.id', 'e.domain_of_activity_id')
            .where('e.id', result.id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your profile');
                }
            });
        return result;
    },

    setEmployerLocation: async (employerId, locationId) => {
        let result = await database('employer')
            .returning()
            .where('id', employerId)
            .update('location_id', locationId)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem setting your employer profile location. Please try again')
                }
            });
        return result;
    },

};