//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection')

module.exports = {

    // This creates a new placement in the database 
    createNewPlacement: (details) => {

        const workingHs = parseInt(details.workingHours);
        const salary = parseInt(details.salary);
        
    
        return database('placements')
            .returning()
            .insert({
                position: details.position,
                working_hours: workingHs,
                start_period: details.startPeriod,
                end_period: details.endPeriod, 
                salary: salary,
                description_role: details.descriptionRole,
                institution: details.institution, 
                major: details.major
            }, ['id', 'position', 'working_hours', 'start_period', 'end_period', 'salary', 'description_role', 'institution', 'major']);

    },

    // this gets a placement from the db knowing its id
    getPlacementById: (id) => {

        return database('placements')
            .select('id',
                'position',
                'working_hours',
                'start_period',
                'end_period',
                'salary',
                'description_role',
                'institution',
                'major')
            .where('id', id);

    },

    getAllPlacementsIds: () => {
        return database('placements')
            .select('id');
    },

    setPlacementSkills: (id, skills) => {

        id = parseInt(id);
        return new Promise(async (resolve, reject) => {
            let placementToSkills = []
            for(let i=0, len=skills.length; i<len; i++) {
                let result = await database('placement_has_skills')
                    .returning()
                    .insert({
                        placement_id: id,
                        skill_id: skills[i].id
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

}; 