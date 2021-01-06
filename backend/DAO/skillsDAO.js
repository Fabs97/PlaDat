const database = require('../DB/connection');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    getSkillByType: (type) => {
        return database('skill')
            .select('id', 'name', 'type')
            .where('type', type);
    },

    // this checks if the skill already exists in the other section and eventually returns its id
    getOtherSkillIdByName: (name) => {
        return database('skill')
            .select('id')
            .where(['name', 'type'], [name, 'OTHER']);
    },

    checkIfOtherSkillExists: async (name) => {
        let result = await database('skill')
            .select('id')
            .where('name', name)
            .andWhere('type', 'OTHER');
        return result [0];
    },

    // this adds another skill in the other skill already exists in the db
    addNewOtherSkill: async (name) => {
        let result = await database('skill')
            .returning()
            .insert({
                name: name, 
                type: 'OTHER'
                }, ['id']);
        return result[0];
    },

    getStudentSkillsById: (studentID) => {
        return database('student_has_skills')
            .select('skill_id')
            .where('student_id', studentID);
    },

    getSkillById: async (id) => {
        let result = await database('skill')
            .select('id', 'name', 'type')
            .where('id', id);
        return result[0];
    }, 

    getStudentSkills: async (id) => {
        return database('skill AS s')
            .select('s.id', 's.name', 's.type')
            .leftJoin('student_has_skills AS shs', 's.id', 'shs.skill_id')
            .where('shs.student_id', id)
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up the skills of your profile. Please try again.')
                }
            })
    },
    
    getPlacementSkills: async (placementID) => {
        return database('skill AS s')
           .select('s.id', 's.name', 's.type')
           .leftJoin('placement_has_skills AS phs', 's.id', 'phs.skill_id')
            .where('phs.placement_id',placementID)
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up the skills of your placement. Please try again.')
                }
            })
   },

};