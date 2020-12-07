const database = require('../DB/connection')
const utils = require('../utils')

module.exports = {

    createWorkExperiences: async (studentID, work) => {

        let workToInsert = utils.toUnderscore(work);

        studentID = parseInt(studentID);
        let result = await database('work')
            .returning()
            .insert(workToInsert, ['id', 'company_name as companyName', 'position', 'work_period as workPeriod', 'description']);

        return result;    

    }
};

