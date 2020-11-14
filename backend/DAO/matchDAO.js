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
        if (previousInteraction.student_accept) {   
            if(choice.placementAccept === true) {
                return  database('student_has_placement')
                    .where({ 
                        student_id: choice.studentID,
                        placement_id: choice.placementID
                    })
                    .update({ 
                        placement_accept : true,
                        status: 'ACCEPTED'
                    }, ['student_id', 'placement_id', 'student_accept', 'placement_accept', 'status'])
            } else if (choice.placementAccept === false) {
                return database('student_has_placement')
                    .where({ 
                        student_id: choice.studentID,
                        placement_id: choice.placementID
                    })
                    .update({ 
                        placement_accept : false,
                        status: 'REJECTED'
                    }, ['student_id', 'placement_id', 'student_accept', 'placement_accept', 'status'])
            }
        }

        //HERE WE SHOULD DO FOR THE OTHER CASES: WHEN THE PREVIOUS INTERACTION WAS POSITIVE FOR THE PLACEMENT
        //        if (previousInteraction.placement_accept) {   
                    // if(choice.studentAccept === true) {


        //
    }
  
};