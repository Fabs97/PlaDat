const messageDAO = require('../DAO/messageDAO');

module.exports = {

    saveNewMessage: async (message) => {
        return await messageDAO.saveNewMessage(message);
    },

    getConversation: async (studentId, emplyerId) => {
        return await messageDAO.getConversation(studentId,emplyerId);
    },

}