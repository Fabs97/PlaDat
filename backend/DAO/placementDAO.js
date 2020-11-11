//You need to import the DB instance in order to use it and make requests
const database = require('../DB/connection')

module.exports = {

    // This creates a new placement in the database 
    createNewPlacement: (details) => {

        return database('placements')
            .returning()
            .insert({
                position: details.position,
                working_hours: details.workingHours,
                start_period: details.startPeriod,
                end_period: details.endPeriod, 
                salary: details.salary,
                description_role: details.descriptionRole,
                institution: details.institution, 
                major: details.major
            }, ['id']);

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

    }

}; 