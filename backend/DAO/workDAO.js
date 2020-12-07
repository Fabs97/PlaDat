const database = require('../DB/connection')
const utils = require('../utils')
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    createWorkExperiences: async (studentID, work) => {

        let workToInsert = utils.toUnderscore(work);

        studentID = parseInt(studentID);
        let result = await database('work')
            .returning()
            .insert(workToInsert, ['id', 'company_name as companyName', 'position', 'work_period as workPeriod', 'description'])
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your work experience');
                }
            });

        return result;    

    }
};

