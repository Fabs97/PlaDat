const database = require('../DB/connection');

module.exports = {

    getPreviousInteraction: async (studentID, placementID) => {
        let result = await database('student_has_placement')
            .select('student_id', 'placement_id', 'student_accept', 'placement_accept', 'status')
            .where('student_id', studentID)
            .andWhere('placement_id', placementID);
        return result[0];
    },

    createInteraction: async (choice) => {
        let result = await database('student_has_placement')
            .returning()
            .insert({
                student_id: choice.studentID,
                placement_id: choice.placementID,
                student_accept: choice.studentAccept,
                placement_accept: choice.placementAccept, 
                status: (choice.studentAccept === false || choice.placementAccept === false ? 'REJECTED' : 'PENDING')
            }, ['student_id', 'placement_id', 'student_accept', 'placement_accept', 'status']);
        
        return result[0];
    },

    saveInteraction:  (previousInteraction, choice) => {
        return database('student_has_placement')
            .where({ 
                student_id: choice.studentID,
                placement_id: choice.placementID
            })
            .update(previousInteraction.student_accept ? { 
                placement_accept : choice.placementAccept,
                status: choice.placementAccept === true ? 'ACCEPTED' : 'REJECTED'
            } : { 
                student_accept : choice.studentAccept,
                status: choice.studentAccept === true ? 'ACCEPTED' : 'REJECTED'
            }, ['student_id', 'placement_id', 'student_accept', 'placement_accept', 'status'])
    }
};