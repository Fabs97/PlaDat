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
                employer_id: details.employerId
            }, ['id', 'position', 'employment_type', 'start_period', 'end_period', 'salary', 'description_role', 'employer_id'])
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
                'employer_id'
                )
            .where('id', id);
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

   
    getPlacementsForSkills: async (skills) => {

        let placementData = await database('placements AS p')
            .select(['p.id', 'p.position', 'p.employment_type', 'start_period', 'end_period', 'salary', 'description_role', 'employer_id'])
            .leftJoin('placement_has_skills AS phs', 'phs.placement_id', 'p.id')
            .leftJoin(database.raw('(select p.id, count(phs.skill_id) as count_total from placements p join placement_has_skills phs on p.id = phs.placement_id group by p.id) as p2'), 'p.id','p2.id') //here we count the total number of skills for each placement
            .whereIn('phs.skill_id', skills)
            .groupBy('p.id')
            .having(database.raw('count(phs.skill_id) > max(p2.count_total)/2'))
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem finding the recommended placements. Please try again.')
                }
            })

        let placementIDs =  placementData.map(placement => placement.id);

        let resultTemp = await database('placement_has_skills AS phs')
            .leftJoin('skill AS s', 's.id', 'phs.skill_id')
            .whereIn('phs.placement_id', placementIDs)
            .orderBy('phs.placement_id')
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking up informations about the recommended placements. Please try again.')
                }
            })
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
        for (let p=0; p<placementData.length; p++) {

            for(let i=0; i<resultTemp.length; i++){

                if(placementData[p].id === resultTemp[i].placement_id) {

                    prev = result.length - 1;

                    if(result[prev] && result[prev].id === placementData[p].id && resultTemp[i].placement_id === result[prev].id) {
                        result[prev].skills .push({
                            id: resultTemp[i].skill_id,
                            name: resultTemp[i].name,
                            type: resultTemp[i].type
                        })
                    } else if (!result[prev] || result[prev].id !== placementData[p].id) {
                        result.push({
                            id: placementData[p].id,
                            position: placementData[p].position,
                            employment_type: placementData[p].employment_type,
                            employer_id: placementData[p].employer_id,
                            start_period: placementData[p].start_period,
                            end_period: placementData[p].end_period,
                            end_period: placementData[p].end_period,
                            salary: placementData[p].salary,
                            description_role: placementData[p].description_role,
                            majors: [],
                            institutions: [],
                            skills: [{
                                id: resultTemp[i].skill_id,
                                name: resultTemp[i].name,
                                type: resultTemp[i].type
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
            }
        }

        return result;

    }, 

    getPlacementMajors: async (id) => {
        return database('majors AS m')
            .select('m.id', 'm.name')
            .leftJoin('placement_has_major AS phm', 'm.id', 'phm.major_id')
            .where('phm.placement_id', id);
    },

    getPlacementInstitutions: async (id) => {
        return database('institutions AS i')
            .select('i.id', 'i.name')
            .leftJoin('placement_has_institution AS phi', 'i.id', 'phi.institution_id')
            .where('phi.placement_id', id);
    },

    getPlacementsByEmployerId: (employerId) => {
        return database('placements as p')
            .select('p.id', 'p.position', 'p.start_period', 'p.end_period', 'p.salary', 'p.description_role', 'p.employer_id', 'p.employment_type', 't1.count_matches')
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
    }

}; 
