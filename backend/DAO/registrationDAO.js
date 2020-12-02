const database = require('../DB/connection');
const connection = require('../DB/connection');

module.exports = {
    
    createUserRegistration: async (userInfo) => {
        let result = await database('registration').returning().insert({
            email: userInfo.email,
            password: userInfo.password,
            type: userInfo.type
        },['id', 'email', 'type']);

        return result[0];
    },
}