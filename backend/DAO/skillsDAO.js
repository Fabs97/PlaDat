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
            .where(['name', 'type'], [name, 'Other']);
    },

    // this adds another skill in the other skill already exists in the db
    addNewOtherSkill: (name) => {
        const maxId = database('skill')
                        .max('id');
        const newID = maxId + 1; 
        // I assumed the id are assigned in numerical order, I am going to check later/fix it
        database('skill')
        .insert({
            id: newId,
            name: name, 
            type: 'Other'
            }, ['id', 'name', 'type']);
        return newID;
    },

    // this look for a skill, known the name and the type
    getSkillByNameAndType: (name, type) => {
        return database('skill')
            .select('id', 'name', 'type')
            .where(['name', 'type'], [name, type]);
    },

    

};