//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection');
const { setStudentLocation } = require('./studentDAO');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    // This creates a new placement in the database 
    createNewPlacement: async (details) => {

        const salary = parseInt(details.salary);
        let result = await database('placements')
            .returning()
            .insert({
                position: details.position,
                employment_type: details.employmentType,
                start_period: details.startPeriod,
                end_period: details.endPeriod, 
                salary: salary,
                description_role: details.descriptionRole,
                employer_id: details.employerId,
                status: 'OPEN'
            }, ['id', 'position', 'employment_type', 'start_period', 'end_period', 'salary', 'description_role', 'employer_id', 'status'])
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem saving your placement. Please try again')
                }
            });

        return result[0];

    },

    // this gets a placement from the db knowing its id
    getPlacementById: async (id) => {

        let result = await database('placements')
            .select('id',
                'position',
                'employment_type',
                'start_period',
                'end_period',
                'salary',
                'description_role',
                'employer_id',
                'status'
                )
            .where('id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your placement profile. Please try again')
                }
            });
        return result[0];

    },

    getAllPlacementsIds: () => {
        return database('placements')
            .select('id');
    },

    setPlacementSkills: (id, skills) => {

        id = parseInt(id);
        return new Promise(async (resolve, reject) => {
            let placementToSkills = [];
            for (let i = 0, len = skills.length; i < len; i++) {
                const skill = skills[i];
                let result = await database('placement_has_skills')
                    .returning()
                    .insert({
                        placement_id: id,
                        skill_id: skill.id
                        }, ['placement_id', 'skill_id'])
                        .catch(error => {
                            console.log(error);  
                        })
                    
                if(result) {
                    placementToSkills.push({
                        placement: result[0].placement_id,
                        skill: result[0].skill_id
                    })
                }
                
            }
            resolve(placementToSkills);
        });

    },

    setPlacementInstitutions: (id, institutions) => {

        id = parseInt(id);
        return new Promise(async (resolve, reject) => {
            let placementToInstitutions = [];
            for (let i = 0, len = institutions.length; i < len; i++) {
                const institution = institutions[i];
                let result = await database('placement_has_institution')
                    .returning()
                    .insert({
                        placement_id: id,
                        institution_id: institution.id
                        }, ['placement_id', 'institution_id'])
                        .catch(error => {
                            console.log(error);  
                        })
                    
                if(result) {
                    placementToInstitutions.push({
                        placement: result[0].placement_id,
                        institution: result[0].institution_id
                    })
                }
                
            }
            resolve(placementToInstitutions);
        });

    },

    setPlacementMajors: (id, majors) => {

        id = parseInt(id);
        return new Promise(async (resolve, reject) => {
            let placementToMajors = [];
            for (let i = 0, len = majors.length; i < len; i++) {
                const major = majors[i];
                let result = await database('placement_has_major')
                    .returning()
                    .insert({
                        placement_id: id,
                        major_id: major.id
                        }, ['placement_id', 'major_id'])
                        .catch(error => {
                            console.log(error);  
                        })
                    
                if(result) {
                    placementToMajors.push({
                        placement: result[0].placement_id,
                        major: result[0].major_id
                    })
                }
                
            }
            resolve(placementToMajors);
        });

    },

   
    getPlacementsForRecommendations: async (studentId) => {

        let placementsInteractedWithStudent = await database('placements as p')
            .select('p.id')
            .leftJoin('student_has_placement as shp', 'p.id', 'shp.placement_id')
            .whereIn('shp.student_accept', [true, false] )
            .andWhere('shp.student_id', studentId)
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended students. Please try again.')
                }
            })
        
        let placementsInteractedWithStudentIDs =  placementsInteractedWithStudent.map(placement => placement.id);

        let resultTemp  = await database('placements AS p')
            .select('p.id AS id', 'p.position AS position', 'p.employment_type AS employment_type', 'p.employer_id AS employer_id', 'p.start_period AS start_period', 'p.end_period AS end_period', 'p.salary AS salary', 'p.status AS status', 'p.description_role AS description_role', 's.id AS skill_id', 's.name AS skill_name', 's.type AS skill_type')
            .leftJoin('placement_has_skills AS phs', 'p.id', 'phs.placement_id')
            .leftJoin('skill AS s', 'phs.skill_id', 's.id')
            .whereNotIn('p.id', placementsInteractedWithStudentIDs)
            .andWhere('p.status','OPEN')
            .orderBy('p.id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up the recommended placements. Please try again.')
                }
            })

        let placementIDs =  resultTemp.map(placement => placement.id);

        let result = [];
        let prev = 0;

        let locations = await database('location AS l')
            .select('l.id AS id', 'l.country AS country', 'l.city AS city', 'p.id AS placement_id')
            .leftJoin('placements as p', 'l.id', 'p.location_id')
            .whereIn('p.id', placementIDs)
            .orderBy('p.id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended placements. Please try again.')
                }
            })
        
        let majors = await database('majors as m')
            .select('m.name AS name', 'phm.placement_id AS placement_id')
            .leftJoin('placement_has_major AS phm', 'm.id', 'phm.major_id')
            .whereIn('phm.placement_id', placementIDs)
            .orderBy('phm.placement_id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended placements. Please try again.')
                }
            })
        
        let institutions =  await database('institutions AS i')
            .select('i.name AS name', 'phi.placement_id AS placement_id')
            .leftJoin('placement_has_institution AS phi', 'i.id', 'phi.institution_id')
            .whereIn('phi.placement_id', placementIDs)
            .orderBy('phi.placement_id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended placements. Please try again.')
                }
            })

        let employers = await database('employer AS e')
            .select('e.name AS employer_name', 'p.id AS placement_id')
            .leftJoin('placements AS p', 'e.id', 'p.employer_id')
            .whereIn('p.id', placementIDs)
            .orderBy('p.id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended placements. Please try again.')
                }
            })
    
        
        let j = 0;
        let k = 0;
        let h = 0;
        let l = 0;
        

        for(let i=0; i<resultTemp.length; i++){


            prev = result.length - 1;

            if(result[prev] && result[prev].id === resultTemp[i].id) {
                result[prev].skills .push({
                    id: resultTemp[i].skill_id,
                    name: resultTemp[i].skill_name,
                    type: resultTemp[i].skill_type
                })
            } else if (!result[prev] || result[prev].id !== resultTemp[i].id) {
                result.push({
                    id: resultTemp[i].id,
                    position: resultTemp[i].position,
                    employment_type: resultTemp[i].employment_type,
                    employer_id: resultTemp[i].employer_id,
                    start_period: resultTemp[i].start_period,
                    end_period: resultTemp[i].end_period,
                    salary: resultTemp[i].salary,
                    description_role: resultTemp[i].description_role,
                    status: resultTemp[i].status,
                    majors: [],
                    institutions: [],
                    skills: [{
                        id: resultTemp[i].skill_id,
                        name: resultTemp[i].skill_name,
                        type: resultTemp[i].skill_type
                    }]
                })

                let curr = prev + 1;

                while(j < locations.length && locations[j].placement_id == result[curr].id){
                    result[curr].location = {
                        id: locations[j].id,
                        country: locations[j].country,
                        city: locations[j].city
                    };
                    j++;
                }

                while(l < employers.length && employers[l].placement_id == result[curr].id){
                    result[curr].employer_name = employers[l].employer_name;
                    l++;
                }

                while(k < majors.length && majors[k].placement_id == result[curr].id){
                    result[curr].majors.push({
                        name: majors[k].name
                    }),
                    k++;
                }

                while(h < institutions.length && institutions[h].placement_id == result[curr].id){
                    result[curr].institutions.push({
                        name: institutions[h].name
                    })
                    h++;
                }
                                
                        
                    
                    
            }
            
        }
        

        return result;

    }, 

    getPlacementMajors: async (id) => {
        return database('majors AS m')
            .select('m.id', 'm.name')
            .leftJoin('placement_has_major AS phm', 'm.id', 'phm.major_id')
            .where('phm.placement_id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your placement majors. Please try again')
                }
            });
    },

    getPlacementInstitutions: async (id) => {
        return database('institutions AS i')
            .select('i.id', 'i.name')
            .leftJoin('placement_has_institution AS phi', 'i.id', 'phi.institution_id')
            .where('phi.placement_id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your placement institutions. Please try again')
                }
            });
    },

    getPlacementsByEmployerId: (employerId) => {
        return database('placements as p')
            .select('p.id', 'p.position', 'p.start_period', 'p.end_period', 'p.salary', 'p.description_role', 'p.employer_id', 'p.employment_type', 'status', 't1.count_matches')
            .leftJoin(database.raw("(select shp.placement_id, count(shp.student_id) as count_matches from student_has_placement as shp where shp.status='ACCEPTED' group by shp.placement_id) as t1"), 'p.id','t1.placement_id') //here we count the total number of matches for each placement
            .where('p.employer_id', employerId);
    },
    
    deletePlacementById: (id) => {
        return database('placements')
            .where('id', id)
            .del();
    },

    setPlacementLocation: async (placementId, locationId) => {
        let result = await database('placements')
            .returning()
            .where('id', placementId)
            .update('location_id', locationId)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem setting your student profile location. Please try again')
                }
            });
        return result;
    },

    getLastPlacement: async () => {
        let result = await database("placements")
            .select("id")
            .orderBy("id", "desc")
            .limit(1);
        return result[0];
    },

    closePlacementById: async (id) => {
        let result = await database('placements')
            .returning()
            .where('id', id)
            .update('status', 'CLOSED')
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem closing your placement. Please try again.')
                }
            });
        return result;
    }, 

    getPlacementLocation: async (id) => {
        let result = await database('placements AS p')
            .select('l.id', 'l.country', 'l.city')
            .leftJoin('location AS l', 'p.location_id', 'l.id')
            .where('p.id', id)
            .catch(error => {
                if(error) {
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem getting your placement location. Please try again')
                }
            });
        return result[0]; 
    }



}; 
