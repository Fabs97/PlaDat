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
            .insert(workToInsert, ['id', 'company_name as companyName', 'position', 'start_period as startPeriod', 'end_period as endPeriod', 'description'])
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your work experience');
                }
            });
        
        let student_work = [];
        for(let i=0; i<result.length; i++) {
            student_work.push({
                student_id: studentID,
                work_id: result[i].id
            });
        }
        await database('student_has_work')
            .returning()
            .insert(student_work, ['student_id', 'work_id'])
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your work experience');
                }
            });

        return result;    

    }
};

