const router = require('express').Router();

const service = require('../services/studentService');

router.get("/:id", async (req, res, next) => {
    // db
    //logic
    const student = await service.getStudent(req.params.id);

    res.json(student);
  

    res.status(200).send("ciao");
});


// routes

module.exports = router;