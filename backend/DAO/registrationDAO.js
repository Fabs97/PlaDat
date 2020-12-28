const database = require('../DB/connection');
const connection = require('../DB/connection');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;



module.exports = {
    
    createUserRegistration: async (userInfo) => {
        let result = await database('registration').returning().insert({
            email: userInfo.email,
            password: userInfo.password,
            type: userInfo.type
        },['id', 'email', 'type'])
        .catch(error => {
            if(error){
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem saving your registration. Please try again')
            }
        });

        return result[0];
    },

    getAccountByEmail: async (email) => {
        let result = await database('registration')
            .select()
            .where('email', email)
        return result.length ? result[0] : null
    },

    deleteUserById: function(userId) {
        return database('registration')
            .where('id', userId)
            .del();
    }
}