const database = require('../DB/connection');

module.exports = {

    getPreviousInteraction: (studentID, placementID) => {
        return database('student_has_placement')
            .select('student_id', 'placement_id', 'student_accept', 'placement_accept', 'status')
            .where('student_id', studentID)
            .andWhere('placement_id', placementID);
    },

    createInteraction: async (choice) => {
        let result = await database('student_has_placement')
            .returning()
            .insert({
                student_id: choice.studentID,
                placement_id: choice.placementID,
                student_accept: choice.studentAccept || null,
                placement_accept: choice.placementAccept || null, 
                status: (choice.studentAccept === false || choice.placemenetAccept === false ? 'REJECTED' : 'PENDING')
            }, ['student_id', 'placement_id', 'student_accept', 'placement_accept', 'status']);

        return result[0];
    }
  
};