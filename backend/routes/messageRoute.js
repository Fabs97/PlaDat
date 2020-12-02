const router = require('express').Router();

const messageService = require('../services/messageService');

router.post('/message', async (req, res, next) => {
    let message = await messageService.saveNewMessage(req.body);
    res.json(message);
});

router.get('/message/:studentId/:employerId', async (req, res, next) => {
    let conversation = await messageService.getConversation(req.params.studentId, req.params.employerId);
    res.json(conversation); 
});

module.exports = router;