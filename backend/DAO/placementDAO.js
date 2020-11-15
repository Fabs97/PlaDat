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
                'description_role')
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

    getPlacements: () => {
        return database('placements')
            .select('id',
            'position',
            'working_hours',
            'start_period',
            'end_period',
            'salary',
            'institution',
            'description_role',
            'major');
    }, 
    getPlacementSkillsByID: (placementID) => {
         return database('placement_has_skills')
            .select('skill_id')
             .where('placement_id',placementID)
    },

    getPlacementsForSkills: async (skills) => {

        return database('placements AS p')
            .select(['p.id', 'p.position'])
            .leftJoin('placement_has_skills AS phs', 'phs.placement_id', 'p.id')
            .leftJoin(database.raw('(select p.id, count(phs.skill_id) as count_total from placements p join placement_has_skills phs on p.id = phs.placement_id group by p.id) as p2'), 'p.id','p2.id') //here we count the total number of skills for each placement
            .whereIn('phs.skill_id', skills)
            .groupBy('p.id')
            .having(database.raw('count(phs.skill_id) > max(p2.count_total)/2'))
            .catch((error) => {
                console.log(error)
            });


        /*
            RAW SQL FOR INSPIRATION: 

        select p.position
        from placements p
        join placement_has_skills phs on p.id = phs.placement_id
        join (
            select
                p.id,
                count(phs.skill_id) as count_total
            from placements p
            join placement_has_skills phs on p.id = phs.placement_id
            group by p.id
            )
            as p2 on p.id = p2.id
        where phs.skill_id in (2,3,4,5,6,7)
        group by p.id
        having count(phs.skill_id) > max(p2.count_total)/2

        */
    }, 

    getPlacementMajorsId: async (id) => {
        return database('placement_has_major')
            .select('major_id')
            .where('placement_id', id);
    },

    getPlacementInstitutionsId: async (id) => {
        return database('placement_has_institution')
            .select('institution_id')
            .where('placement_id', id);
    },

}; 
