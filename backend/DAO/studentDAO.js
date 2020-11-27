//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection');
const connection = require('../DB/connection');

module.exports = {
    // Here we add methods that have to make operation on the database: create, select, delete, etc
    getStudentById: async (id) => {
        // Using Knex.js library, we are performing ORM (Object Relational Mapping).
        // This helps us not write direct sql queries, but perform basic DB operations using methods. 
        
        // You can find out more about this one on its website: http://knexjs.org/
        
        // This one is very similar to SQL
        let result = await database('student')
            .select('id', 'name','surname','email', 'description', 'phone')
            .where('id', id);
        return result[0];
    },

    createStudentAccount: (studentInfo) => {
        return database('student')
            .returning()
            .insert({
                name: studentInfo.name,
                surname: studentInfo.surname,
                email: studentInfo.email,
                description: studentInfo.description,
                phone: studentInfo.phone
            },['id','name','surname','email','description', 'phone']);
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

    getStudentsBySkills: async (skillsId) => {
        let skillsNumber = skillsId.length;
        let studentIDs = await database('student_has_skills')
            .select('student_id')
            .whereIn('skill_id', skillsId)
            
            .groupBy('student_id')
                 
            .havingRaw('count(*) >= ?', parseInt(skillsNumber/2))
            .as('student_ids')
            .catch((error) => {
                console.log(error);
            });
        
        studentIDs = studentIDs.map(student => student.student_id);

        let resultTemp = await database('student AS s')
            .select('s.id', 's.name', 's.surname', 's.email', 's.description', 'sk.id AS skill_id', 'sk.name AS skill_name', 'sk.type AS skill_type')
            .leftJoin('student_has_skills AS shs', 's.id', 'shs.student_id')
            .leftJoin('skill AS sk', 'shs.skill_id', 'sk.id')
            .whereIn('s.id', studentIDs)
            .orderBy('s.id');
        let result = []

        for(let i = 0; i < resultTemp.length; i++){
            let prev = result.length-1;

            if(!result[prev] || result[prev].id !== resultTemp[i].id) {
                result.push({
                    id: resultTemp[i].id,
                    name: resultTemp[i].name,
                    surname: resultTemp[i].surname,
                    email: resultTemp[i].email,
                    description: resultTemp[i].description,
                    skills: [{
                        id: resultTemp[i].skill_id,
                        name: resultTemp[i].skill_name,
                        type: resultTemp[i].skill_type
                    }]
                })
            } else if(result[prev] && result[prev].id === resultTemp[i].id ){
                result[prev].skills.push({
                    id: resultTemp[i].skill_id,
                    name: resultTemp[i].skill_name,
                    type: resultTemp[i].skill_type
                })
            }
        }


        return result;
    },


};