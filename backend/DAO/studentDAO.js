//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection');
const knexfile = require('../knexfile');

module.exports = {
    // Here we add methods that have to make operation on the database: create, select, delete, etc
    getStudentById: (id) => {
        // Using Knex.js library, we are performing ORM (Object Relational Mapping).
        // This helps us not write direct sql queries, but perform basic DB operations using methods. 
        // You can find out more about this one on its website: http://knexjs.org/
        
        // This one is very similar to SQL
        return database('student4')
            .select('id', 'name')
            .where('id', id);
    },

    setStudentSkills: (studentId, skills) => {
        for(let i=0, len=skills.length; i<len; i++) {
            database('Student_Has_Skill')
            .returning()
            .insert({
                student_id: studentId,
                skill_id: skills[i].id
                }, ['student_id', 'skill_id']);
        }
    }

};