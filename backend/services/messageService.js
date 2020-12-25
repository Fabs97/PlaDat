const messageDAO = require('../DAO/messageDAO');
const {SuperError,ERR_BAD_REQUEST,ERR_NOT_FOUND, ERR_FORBIDDEN} = require('../errors');
const studentService = require('./studentService');
const employerService = require('./employerService');

module.exports = {

    saveNewMessage: async (message, auth) => {
        if(isNaN(message.studentId) || isNaN(message.employerId)|| typeof(message.sendDate) != 'string' || (message.sender != 'STUDENT' && message.sender != 'EMPLOYER') || typeof(message.message) != 'string'){
            throw new SuperError(ERR_BAD_REQUEST, 'Your request structure contains some mistakes. Please try again.');
            return;
        }

        let student = await studentService.getStudent(message.studentId)
        let employer = await employerService.getEmployer(message.employerId)

        if(!student || !employer) {
            throw new SuperError(ERR_NOT_FOUND, 'The conversation cannot be found');
            return;
        };

        if ( auth.id !== student.userId && auth.id !== employer.userId) {
            throw new SuperError(ERR_FORBIDDEN, 'You are not authorized to initiate this conversation');
            return;
        }

        return await messageDAO.saveNewMessage(message);
    },

    getConversation: async (studentId, employerId, auth) => {

        let student = await studentService.getStudent(studentId)
        let employer = await employerService.getEmployer(employerId)

        if(!student || !employer) {
            throw new SuperError(ERR_NOT_FOUND, 'The conversation cannot be found');
            return;
        };

        if ( auth.id !== student.userId && auth.id !== employer.userId) {
            throw new SuperError(ERR_FORBIDDEN, 'You are not authorized to see this conversation');
            return;
        }

        return await messageDAO.getConversation(studentId,employerId);
    },

    deleteMessage: async (msgDetails) => {
        return await messageDAO.deleteMessage(msgDetails);
    },

    getLastMessage: async () => {
        return await messageDAO.getLastMessage();
    },

}