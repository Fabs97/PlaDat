//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection');
const connection = require('../DB/connection');

//Error handling imports
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;
const ERR_NOT_FOUND = require('../errors').ERR_NOT_FOUND;

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

    createStudentAccount: async (studentInfo) => {
        let result = await database('student')
            .returning()
            .insert({
                name: studentInfo.name,
                surname: studentInfo.surname,
                email: studentInfo.email,
                description: studentInfo.description,
                phone: studentInfo.phone
            },['id','name','surname','email','description', 'phone'])
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your profile');
                }
            });

        return result[0];
    },

    setStudentSkills: (studentId, skills) => {
        studentId = parseInt(studentId);
        return new Promise(async (resolve, reject) => {
            let studentToSkills = [];
            let errorState = false;
            for(let i=0, len=skills.length; i<len; i++) {

                let result = await database('student_has_skills')
                    .select()
                    .where('student_id', studentId)
                    .andWhere('skill_id', skills[i].id)
                    .catch(error => {
                        if(error) {
                            reject(new SuperError(ERR_NOT_FOUND, 'There was an error saving your skills')); 
                            errorState = true;
                            return error;
                        }
                    });
                if(errorState) return;

                if(result.length == 0) {
                    result = await database('student_has_skills')
                    .returning()
                    .insert({
                        student_id: studentId,
                        skill_id: skills[i].id
                        }, ['student_id', 'skill_id'])
                        .catch(error => {
                            if(error) {
                                reject(new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error saving your skills'));
                                errorState = true;
                            }
                        });
                }
                if(errorState) return;

                 
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

    getLastStudent: async () => {
        let result = await database("student")
            .select("id")
            .orderBy("id", "desc")
            .limit(1);
        return result[0];
    },

    deleteStudentById: (id) => {
        return database('student')
            .where('id', id)
            .del();
            
    },

    setStudentLocation: async (studentId, locationId) => {
        let result = await database('student')
            .returning()
            .where('id', studentId)
            .update('location_id', locationId)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem setting your student profile location. Please try again')
                }
            });
        return result;
    },


};