const registrationDAO = require('../DAO/registrationDAO');
const bcrypt = require('bcrypt');
const studentService = require('../services/studentService');
const { SuperError, ERR_UNAUTHORIZED } = require('../errors');
const placementService = require('./placementService');
const employerService = require('./employerService');
const jwt = require('jsonwebtoken');

module.exports = {
    createUserRegistration: (userInfo) => {
        // standard saltRound = 10
        return bcrypt.hash(userInfo.password, 10).then(async function(hash){
            userInfo.password = hash;
            return await registrationDAO.createUserRegistration(userInfo);
        });        
    },
    getUserProfile: async (user) => {
        let userResult = {};
        let userAccount = await registrationDAO.getAccountByEmail(user.email);

        if (!userAccount) {
            throw new SuperError(ERR_UNAUTHORIZED, 'The email or password you introduced are not correct');
        }
    
        userResult.userID = userAccount.id;

        var passwordIsValid = bcrypt.compareSync(
            user.password,
            userAccount.password
        );
    
        if (!passwordIsValid) {
            throw new SuperError(ERR_UNAUTHORIZED, 'The email or password you introduced are not correct');
        }

        if(userAccount.type === 'STUDENT') {
            let studentAccount = await studentService.getStudentByUserId(userAccount.id);
            if(studentAccount && studentAccount.id){
                userResult.studentID = studentAccount.id;
            }
        } else {
            let employerAccount = await employerService.getEmployerByUserId(userAccount.id);
            if(employerAccount && employerAccount.id){
                userResult.employerID = employerAccount.id;
            }
        }

        if(!userResult.studentID && !userResult.employerID) {
            userResult.student = ( userAccount.type === 'STUDENT' ? true : false )
        }
        
        userResult.token = jwt.sign({ id: userAccount.id }, process.env.ACCESS_TOKEN_SECRET, {
            expiresIn: process.env.ACCESS_TOKEN_LIFE // 30 DAYS
        });
        
        return userResult;
    }
}