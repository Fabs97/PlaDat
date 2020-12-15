const database = require('../DB/connection');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    saveNewMessage: async (messageBody) => {
        let result = await database('message')
            .returning()
            .insert({
                student_id: messageBody.studentId,
                employer_id: messageBody.employerId,
                message: messageBody.message,
                send_date: messageBody.sendDate,
                sender: messageBody.sender
            },['student_id', 'employer_id', 'message', 'send_date', 'sender'])
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem saving your message. Please try again');
                }
            });
        return result[0];
    },

    getConversation: (studentId, employerId) => {
        return database('message')
            .select('student_id', 'employer_id', 'message', 'send_date', 'sender')
            .where('student_id', studentId)
            .andWhere('employer_id', employerId)
            .orderBy('send_date', 'asc')
            .catch(error => {
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem looking for this conversation. Please try again');  
            });
    },
    
    deleteMessage: (details) => {
        return database('message')
            .where('student_id', details.studentId)
            .andWhere('employer_id', details.employerId)
            .andWhere('send_date', details.sendDate)
            .del();
    },

    getLastMessage: async () =>{
        let result = await database('message')
            .select('student_id', 'employer_id', 'send_date')
            .orderBy('send_date', 'desc')
            .limit(1);
        return result[0];
    }, 

}