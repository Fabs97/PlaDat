const messageDAO = require('../DAO/messageDAO');
const SuperError = require('../errors').SuperError;
const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;

module.exports = {

    saveNewMessage: async (message) => {
        if(isNaN(message.studentId) || isNaN(message.employerId)|| typeof(message.sendDate) != 'string' || (message.sender != 'STUDENT' && message.sender != 'EMPLOYER') || typeof(message.message) != 'string'){
            throw new SuperError(ERR_BAD_REQUEST, 'Your request structure contains some mistakes. Please try again.');
        } else {
            return await messageDAO.saveNewMessage(message);
        }
    },

    getConversation: async (studentId, employerId) => {

        let student = await studentService.getStudent(studentId);
        let employer = await employerService.getEmployer(employerId);
        if (  (auth.id !== student.userId && auth.id == employer.userId) 
        || (  (auth.id == student.userId) && auth.id !== employer.userId)) {
            throw new SuperError(ERR_FORBIDDEN, 'You are not authorized to delete this match');
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