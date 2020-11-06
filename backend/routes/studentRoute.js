const router = require('express').Router();

const service = require('../services/studentService');

router.get("/student/:id", async (req, res, next) => {

    // This is where the requests of type "http://localhost:3000/student/1" will arrive. 
    // Here we need to tell the StudentService what it needs to do, so we invoke the method 
    // "getStudent" and send the id from the URL as parameter. We await for the response, 
    // and we put the result in an object "student", which we send back to the caller (frontend)
    const student = await service.getStudent(req.params.id);
    res.json(student);

});


// Here you can define further routes and their functionality

module.exports = router;