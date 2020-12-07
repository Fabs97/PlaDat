const database = require('../DB/connection')
const utils = require('../utils')
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

eDAO = module.exports = {

    createEducationExperiences: async (studentID, education) => {
        let educationExperiences = [];
        await database.transaction( async (trx) => {
            for(let i=0; i<education.length; i++) {
                let savedEducation = {};
                let educationExp = await eDAO.getEducation(education[i].majorId, education[i].degreeId, education[i].institutionId);
                if (!educationExp) {
                    educationExp = await eDAO.saveEducation(education[i])
                        .catch(trx.rollback);
                } 
                if (educationExp) {
                    savedEducation = await eDAO.saveEducationExperience(studentID, educationExp.id, education[i].description, education[i].period)
                        .catch(trx.rollback);
                }
                if(savedEducation) {
                    savedEducation.majorId = education[i].majorId;
                    savedEducation.degreeId = education[i].degreeId;
                    savedEducation.institutionId = education[i].institutionId;
                }
                educationExperiences.push(savedEducation);
            }
            if(educationExperiences.length < 1) {
                trx.rollback();
            }
        })  
        .catch((error) => {
            // the inserts didn't happen
            if(error) {
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'The education experience was not saved correctly. Please try again');
            }
        });

        return educationExperiences;
    },
    saveEducation: async (education) => {
        let result = await database('education')
            .insert({
                    major_id: education.majorId,
                    institution_id: education.institutionId,
                    degree_id: education.degreeId
                },['id', 'major_id as majorId', 'institution_id as institutionId', 'degree_id as degreeId']);
        return result[0];
    },
    getEducation: async (majorId, degreeId, institutionId) => {
        let education = await database('education')
            .select('id')
            .where('major_id', majorId)
            .andWhere('degree_id', degreeId)
            .andWhere('institution_id', institutionId);
        return education.length ? education[0] : null;
    },
    saveEducationExperience: async (studentID, experienceID, description, period) => {
        let experience = await database('student_has_education')
            .insert({
                student_id: studentID,
                education_id: experienceID,
                description: description,
                period: period
            },['student_id as studentId', 'education_id as educationId', 'description', 'period']);
        return experience.length ? experience[0] : null;
    }
};

