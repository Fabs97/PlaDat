const database = require('../DB/connection');
const connection = require('../DB/connection');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;
const ERR_UNAUTHORIZED = require('../errors').ERR_UNAUTHORIZED;



module.exports = {
    
    createUserRegistration: async (userInfo) => {
        let result = await database('registration').returning().insert({
            email: userInfo.email,
            password: userInfo.password,
            type: userInfo.type
        },['id', 'email', 'type'])
        .catch(error => {
            if(error.constraint === 'registration_email_unique'){
                throw new SuperError(ERR_UNAUTHORIZED, 'There is already an account in use with this email. Please use another email address.')
            } else {
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