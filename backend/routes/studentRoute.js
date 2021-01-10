const router = require('express').Router();

const studentService = require('../services/studentService');

const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;

router.get("/student/:id", async (req, res, next) => {

    // This is where the requests of type "http://localhost:3000/student/1" will arrive. 
    // Here we need to tell the StudentService what it needs to do, so we invoke the method 
    // "getStudent" and send the id from the URL as parameter. We await for the response, 
    // and we put the result in an object "student", which we send back to the caller (frontend)
    

    if(!isNaN(req.params.id)){
        let student = await studentService.getStudentProfile(req.params.id)
        .catch(error => {
            res.status(error.code).send(error.message);
        });

        res.json(student);
    } else {
        res.status(ERR_BAD_REQUEST).send('Your request does not contains a valid student id. Please try again')
    }

});

router.post("/student", async (req, res, next) => {
    const studentAccount = await studentService.createStudentAccount(req.body, req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(studentAccount);
});

router.get("/student/account/:userID", async (req, res, next) => {
    const account = await studentService.getStudentByUserId(parseInt(req.params.userID), req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(account);
});

router.delete("/student/:id", async (req, res, next) => {
    let result = await studentService.deleteStudentById(parseInt(req.params.id), req.user)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
    res.json(result);
});

module.exports = router;