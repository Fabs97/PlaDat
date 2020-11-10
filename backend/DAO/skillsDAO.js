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
        //Aida: I removed the creating of the id because it didn't work when I was trying 
        // to save other skills - the id is created incrememntally by Postgres, so we should 
        //just igore it when we create a new entry in the DB

        // I assumed the id are assigned in numerical order, I am going to check later/fix it
        return database('skill')
            .returning()
            .insert({
                name: name, 
                type: 'OTHER'
                }, ['id']);
        // return newID;
        // I commented this return because we usually return the result of the query, and we 
        // have to put in the query what value we want to get as return (in here, it's the id)
    },

    // this look for a skill, known the name and the type
    getSkillByNameAndType: (name, type) => {
        return database('skill')
            .select('id', 'name', 'type')
            .where(['name', 'type'], [name, type]);
    },

    

};