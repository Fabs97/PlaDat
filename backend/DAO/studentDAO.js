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
            .select('id', 'name','surname', 'description')
            .where('id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There was an error looking for your profile');
                }
            });
        return result[0];
    },

    createStudentAccount: async (studentInfo) => {
        let result = await database('student')
            .returning()
            .insert({
                name: studentInfo.name,
                surname: studentInfo.surname,
                description: studentInfo.description,
                phone: studentInfo.phone, 
                user_id: studentInfo.userId
            },['id','name','surname','description', 'phone', 'user_id'])
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
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem finding the recommended students. Please try again.')
                }
            })
        
        studentIDs = studentIDs.map(student => student.student_id);

        let resultTemp = await database('student AS s')
            .select('s.id', 's.name', 's.surname', 's.email', 's.description', 'sk.id AS skill_id', 'sk.name AS skill_name', 'sk.type AS skill_type', 'l.id AS location_id', 'l.country AS location_country', 'l.city AS location_city')
            .leftJoin('student_has_skills AS shs', 's.id', 'shs.student_id')
            .leftJoin('skill AS sk', 'shs.skill_id', 'sk.id')
            .leftJoin('location AS l', 's.location_id', 'l.id')
            .whereIn('s.id', studentIDs)
            .orderBy('s.id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended students. Please try again.')
                }
            })
        let result = []

        let educations = await database('education AS e')
            .select('m.name AS major', 'i.name AS institution', 'd.name AS degree', 'she.student_id AS student_id', 'she.description AS description', 'she.start_period AS start_period', 'she.end_period AS end_period')
            .leftJoin('student_has_education AS she', 'e.id', 'she.education_id')
            .leftJoin('majors AS m', 'e.major_id', 'm.id')
            .leftJoin('institutions As i', 'e.institution_id', 'i.id')
            .leftJoin('degree AS d', 'e.degree_id', 'd.id')
            .whereIn('she.student_id', studentIDs)
            .orderBy('she.student_id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended students. Please try again.')
                }
            })

        let works = await database('work AS w')
            .select('w.company_name AS company', 'w.position AS position', 'w.start_period AS start_period', 'w.end_period AS end_period', 'w.description AS description', 'shw.student_id AS student_id')
            .leftJoin('student_has_work AS shw', 'w.id', 'shw.work_id')
            .whereIn('shw.student_id', studentIDs)
            .orderBy('shw.student_id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended students. Please try again.')
                }
            })
        
        let j = 0;
        let k = 0;
        for(let i = 0; i < resultTemp.length; i++){
            let prev = result.length-1;

            if(!result[prev] || result[prev].id !== resultTemp[i].id) {
                result.push({
                    id: resultTemp[i].id,
                    name: resultTemp[i].name,
                    surname: resultTemp[i].surname,
                    email: resultTemp[i].email,
                    description: resultTemp[i].description,
                    location: {
                        id: resultTemp[i].location_id,
                        country: resultTemp[i].location_country,
                        city: resultTemp[i].location_city
                    },
                    skills: [{
                        id: resultTemp[i].skill_id,
                        name: resultTemp[i].skill_name,
                        type: resultTemp[i].skill_type
                    }],
                    education: [],
                    work: []
                })

                let curr = prev + 1;

                while(j < educations.length && educations[j].student_id == result[curr].id){
                    result[curr].education.push({
                        major: educations[j].major,
                        institution: educations[j].institution,
                        degree: educations[j].degree,
                        description: educations[j].description,
                        start_period: educations[j].start_period,
                        end_period: educations[j].end_period
                    });
                    j++;
                }

                while(k < works.length && works[k].student_id == result[curr].id){
                    result[curr].work.push({
                        company_name: works[k].company,
                        position: works[k].position,
                        start_period: works[k].start_period,
                        end_period: works[k].end_period,
                        description: works[k].description
                    })
                    k++;
                }
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
    getStudentByUserId: async (userId) => {
        let result = await database('student')
            .select('id', 'name')
            .where('user_id', userId)
        
        return result.length ? result[0] : null;
    }

    getStudentLocationById: async (id) => {
        let result = await database('student AS s')
            .select('l.id', 'l.country', 'l.city')
            .leftJoin('location AS l', 's.location_id', 'l.id')
            .where('s.id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your student profile location. Please try again')
                }
            });
        return result[0]; 
    }, 

    getStudentEducationById: async (id) => {
        return await database('student_has_education AS she')
            .select('d.name AS degree', 'm.name AS major', 'i.name AS institution', 'e.id AS id', 'she.description AS description', 'she.start_period AS start_period', 'she.end_period AS end_period')
            .leftJoin('education AS e', 'she.education_id', 'e.id')
            .leftJoin('degree AS d', 'e.degree_id', 'd.id')
            .leftJoin('majors AS m', 'e.major_id', 'm.id')
            .leftJoin('institutions AS i', 'e.institution_id', 'i.id')
            .where('she.student_id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your student profile education. Please try again')
                }
            });

    }, 

    getStudentWorkById: async (id) => {
        return await database('student_has_work AS shw')
            .select('w.id AS id', 'w.company_name AS company_name', 'w.position AS position', 'w.start_period AS start_period', 'w.end_period AS end_period', 'w.description AS description')
            .leftJoin('work AS w', 'shw.work_id', 'w.id')
            .where('shw.student_id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your student profile work experience. Please try again')
                }
            });
    },


};