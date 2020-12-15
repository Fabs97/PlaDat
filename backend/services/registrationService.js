const registrationDAO = require('../DAO/registrationDAO');
const bcrypt = require('bcrypt');

module.exports = {
    createUserRegistration: (userInfo) => {
        // standard saltRound = 10
        return bcrypt.hash(userInfo.password, 10).then(async function(hash){
            userInfo.password = hash;
            return await registrationDAO.createUserRegistration(userInfo);
        });        
    }
}