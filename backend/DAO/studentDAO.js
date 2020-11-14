//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection');
const connection = require('../DB/connection');

module.exports = {
    // Here we add methods that have to make operation on the database: create, select, delete, etc
    getStudentById: (id) => {
        // Using Knex.js library, we are performing ORM (Object Relational Mapping).
        // This helps us not write direct sql queries, but perform basic DB operations using methods. 
        // You can find out more about this one on its website: http://knexjs.org/
        
        // This one is very similar to SQL
        return database('student')
            .select('id', 'name')
            .where('id', id);
    },

    createStudentAccount: (studentInfo) => {
        return database('student')
            .returning()
            .insert({
                name: studentInfo.name,
                surname: studentInfo.surname
            },['id','name','surname']);
    },

    setStudentSkills: (studentId, skills) => {
        studentId = parseInt(studentId);
        return new Promise(async (resolve, reject) => {
            let studentToSkills = []
            for(let i=0, len=skills.length; i<len; i++) {

                let result = await database('student_has_skills')
                    .select()
                    .where('student_id', studentId)
                    .andWhere('skill_id', skills[i].id);

                if(result.length == 0) {
                    result = await database('student_has_skills')
                    .returning()
                    .insert({
                        student_id: studentId,
                        skill_id: skills[i].id
                        }, ['student_id', 'skill_id'])
                        .catch(error => {
                            console.log(error);  
                        });
                }
                 
                if(result) {
                    studentToSkills.push({
                        student: result[0].student_id,
                        skill: result[0].skill_id
                    })
                }
                
            }
            resolve(studentToSkills);
        });
    },
    // getStudentsBySkills: (skillsId) => {
    //     return database('student')
    //         .select(['student.id', 'student.name'])
    //         .leftJoin('student_has_skills AS shs', 'shs.student_id', 'student.id')
    //         .whereIn('shs.skill_id', skillsId)
    //         .groupBy('student.id')
    //              
                //THIS SHOULD BE REPLACED WITH THE 50% CONDITION
    //         .having(database.raw('count(shs.skill_id) > 2'))
    // }

};