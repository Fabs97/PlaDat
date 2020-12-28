const database = require('../DB/connection');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

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
    },

    getMatchesByStudentId: (studentId) => {
        return database('student_has_placement as shp')
            .select('shp.placement_id as id', 'p.position', 'p.description_role', 'p.employer_id', 'e.name as employer_name')
            .leftJoin('placements as p', 'p.id', 'shp.placement_id')
            .leftJoin('employer as e', 'e.id', 'p.employer_id')
            .where('shp.status','ACCEPTED')
            .andWhere('shp.student_id', studentId)
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem retrieving your matches. Please try again')
                }
            })
    },

    deleteMatch: (studentId, placementId) => {
        return database('student_has_placement as shp')
            .where('student_id', studentId)
            .andWhere('placement_id', placementId)
            .del()
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem retrieving your matches. Please try again')
                }
            })
    },

    getMatchesByPlacementId: (placementId) => {
        return database('student_has_placement as shp')
            .select('shp.student_id as studentId', 's.name as studentName', 's.surname', 's.description', 'skill.id', 'skill.name as skillName', 'skill.type')
            .leftJoin('student as s', 's.id', 'shp.student_id')
            .leftJoin('student_has_skills as shs', 's.id', 'shs.student_id')
            .leftJoin('skill as skill', 'shs.skill_id', 'skill.id')
            .where('shp.status','ACCEPTED')
            .andWhere('shp.placement_id', placementId)
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem retrieving your matches. Please try again')
                }
            })
    },
    getStudentMatchesWithEmployer: async function (employerId, studentID) {
        let result = await database('student_has_placement as shp')
            .select('shp.student_id', 'shp.placement_id', 'shp.student_accept', 'shp.placement_accept', 'shp.status')
            .leftJoin('placements as p', 'shp.placement_id', 'p.id')
            .where('p.employer_id', employerId)
            .andWhere('shp.student_id', studentID)
            .andWhere('shp.status', 'ACCEPTED')
        return result;
    }
};