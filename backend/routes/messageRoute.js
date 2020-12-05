const router = require('express').Router();

const messageService = require('../services/messageService');

const SuperError = require('../errors').SuperError;
const ERR_BAD_REQUEST_ERROR = require('../errors').ERR_BAD_REQUEST_ERROR;


router.post('/message', async (req, res, next) => {
    if(typeof(req.body.studentId) != 'number' || typeof(req.body.employerId) != 'number' || typeof(req.body.sendDate) != 'string' || (req.body.sender != 'STUDENT' && req.body.sender != 'EMPLOYER') || typeof(req.body.message) != 'string'){
        res.status(ERR_BAD_REQUEST_ERROR).send('Your request structure contains some mistakes. Please try again.');
    } else {
        let message = await messageService.saveNewMessage(req.body)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
        res.json(message);
    }
    
});

router.get('/message/:studentId/:employerId', async (req, res, next) => {
    if( typeof(req.params.studentId) === 'number' && typeof(req.params.employerId) === 'number'){
        let conversation = await messageService.getConversation(req.params.studentId, req.params.employerId)
        .catch(error => {
            res.status(error.code).send(error.message);
        });
        res.json(conversation);
    } else {
        res.status(ERR_BAD_REQUEST_ERROR).send('Your request did not provided valid values for ids. Please try again.');
    }
     
});

router.delete('/message', async (req, res, next) => {
    let result = await messageService.deleteMessage(req.body);
    res.json(result);
});

router.get('/messages/last', async (req, res, next) => {
    let lastMessage = await messageService.getLastMessage();
    res.json(lastMessage);
});

module.exports = router;