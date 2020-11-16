const database = require('../DB/connection');

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

    // this look for a skill, known the name and the type
    getSkillByNameAndType: (name, type) => {
        return database('skill')
            .select('id', 'name', 'type')
            .where(['name', 'type'], [name, type]);
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
            .where('shs.student_id', id);
    },
    
    getPlacementSkills: async (placementID) => {
        return database('skill AS s')
           .select('s.id', 's.name', 's.type')
           .leftJoin('placement_has_skills AS phs', 's.id', 'phs.placement_id')
            .where('phs.placement_id',placementID)
   },

};