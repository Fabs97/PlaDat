//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection')

module.exports = {

    // This creates a new placement in the database 
    createNewPlacement: async (details) => {

        const workingHs = parseInt(details.workingHours);
        const salary = parseInt(details.salary);
        let result = await database('placements')
            .returning()
            .insert({
                position: details.position,
                working_hours: workingHs,
                start_period: details.startPeriod,
                end_period: details.endPeriod, 
                salary: salary,
                description_role: details.descriptionRole
            }, ['id', 'position', 'working_hours', 'start_period', 'end_period', 'salary', 'description_role']);

        return result[0];

    },

    // this gets a placement from the db knowing its id
    getPlacementById: async (id) => {

        let result = await database('placements')
            .select('id',
                'position',
                'working_hours',
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
            .select(['p.id', 'p.position', 'p.working_hours', 'start_period', 'end_period', 'salary', 'description_role'])
            .leftJoin('placement_has_skills AS phs', 'phs.placement_id', 'p.id')
            .leftJoin(database.raw('(select p.id, count(phs.skill_id) as count_total from placements p join placement_has_skills phs on p.id = phs.placement_id group by p.id) as p2'), 'p.id','p2.id') //here we count the total number of skills for each placement
            .whereIn('phs.skill_id', skills)
            .groupBy('p.id')
            .having(database.raw('count(phs.skill_id) > max(p2.count_total)/2'))
            .catch((error) => {
                console.log(error)
            });

        let placementIDs =  placementData.map(placement => placement.id);

        let resultTemp = await database('placement_has_skills AS phs')
            .leftJoin('skill AS s', 's.id', 'phs.skill_id')
            .whereIn('phs.placement_id', placementIDs)
            .orderBy('phs.placement_id');
        let result = [];
        let prev = 0;

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
                            working_hours: placementData[p].working_hours,
                            start_period: placementData[p].start_period,
                            end_period: placementData[p].end_period,
                            end_period: placementData[p].end_period,
                            salary: placementData[p].salary,
                            description_role: placementData[p].description_role,
                            skills: [{
                                id: resultTemp[i].skill_id,
                                name: resultTemp[i].name,
                                type: resultTemp[i].type
                            }]
                        })
                                
                        
                    
                        
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
        return database('placements')
            .select()
            .where('employer_id', employerId);
    }

}; 
