const database = require('../DB/connection');

const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {
    getEmployer: async (employer_id) => {
        let result = await database('employer AS e')
            .select('e.id AS id', 'e.name AS name', 'e.description AS description')
            .where('id', employer_id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your employer details. Please try again')
                }
            });
        return result[0];
    },

    getLastEmployer: async () => {
        let result = await database("employer")
            .select("id")
            .orderBy("id", "desc")
            .limit(1);
        return result[0];
    },

    getEmployerByUserId:  async (userId) => {
        let result = await database('employer')
            .select('id', 'name')
            .where('user_id', userId)
        
        return result.length ? result[0] : null;
    },

    getEmployerByPlacementId: async (id) => {
        let result = await database('employer as e')
            .select('e.id', 'e.user_id as userId')
            .leftJoin('placements as p', 'e.id', 'p.employer_id')
            .where('p.id', id);
        return result.length ? result[0] : null;
    },

    addNewEmployer: async (details, userId) => {
        let result = await database('employer')
            .returning()
            .insert({
                name: details.name,
                description: details.description,
                domain_of_activity_id: details.domainOfActivityId,
                user_id: userId
            }, ['id','name', 'description', 'domain_of_activity_id'])
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your profile');
                }
            });
        return result[0];
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

    deleteEmployerById: (id) => {
        return database('employer')
            .where('id', id)
            .del();
    }

};