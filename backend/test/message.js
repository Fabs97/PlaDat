const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema');
const router = require('../routes/studentRoute');
const { response } = require('express');
const { request } = require('chai');
const { post } = require('../index');

//Assertion style
chai.should();

chai.use(chaiHttp);
chai.use(chaiJsonSchema);

describe('message API', () => {

    
    

    describe('POST /message', () => {
        
        let msg = {
            message: "nice to meet you",
            sender: "STUDENT",
            sendDate: "2020-11-10T12:50:00.000Z"
        }

        beforeEach(async () => {
            msg.employerId = (await chai.request(server)
                .get('/employers/last')).body.id

        })

        beforeEach(async () =>{
            
            msg.studentId = (await chai.request(server)
                .get('/students/last')).body.id
        })

        it('should register a message in the db', (done) => {
            chai.request(server)
                .post('/message')
                .set('content-type', 'application/json')
                .send({
                    studentId: msg.studentId,
                    employerId: msg.employerId,
                    message: msg.message,
                    sendDate: msg.sendDate,
                    sender: msg.sender
                })
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('object');
                    response.body.should.have.property('student_id');
                    response.body.should.have.property('employer_id');
                    response.body.should.have.property('message');
                    response.body.should.have.property('send_date');
                    response.body.should.have.property('sender');
                    response.body.student_id.should.equal(msg.studentId);
                    response.body.employer_id.should.equal(msg.employerId);
                    response.body.message.should.equal(msg.message);
                    response.body.send_date.should.equal(msg.sendDate);
                    response.body.sender.should.equal(msg.sender);
                    done();
                })
        })

        afterEach( async () => {
            await chai.request(server)
                .delete('/message')
                .set('content-type', 'application/json')
                .send({
                    studentId: msg.studentId,
                    employerId: msg.employerId,
                    sendDate: msg.sendDate
                })
        })

        it('should get a 400: Bad Request answer if the body of the request has wrong structure', (done) => {
            chai.request(server)
                .post('/message')
                .set('content-type', 'application/json')
                .send({
                    studentId: msg.studentId,
                    employerId: msg.employerId + 1,
                    message: msg.message,
                    sendDate: msg.sendDate,
                    sender: msg.sender
                })
                .end((err, response) => {
                    response.should.have.status(500);
                    done();
                })
        })

        it('should get a 500: Internal Server Error answer if the server cannot save the message', (done) => {
            chai.request(server)
                .post('/message')
                .set('content-type', 'application/json')
                .send({
                    studentId: msg.studentId,
                    employerId: msg.employerId,
                    sendDate: msg.sendDate,
                    sender: msg.sender
                })
                .end((err, response) => {
                    response.should.have.status(400);
                    done();
                })
        })
        
    })


    describe('GET /message/:studentId/:employerId', () =>{

        let msgDetails = {};
        
        beforeEach(async () => {
            let result = await chai.request(server)
                .get('/messages/last');
            msgDetails.studentId = result.body.student_id;
            msgDetails.employerId = result.body.employer_id;
        })

        it('should return a list of messages between the two users, in chronological order', (done) => {
            chai.request(server)
                .get('/message/' + msgDetails.studentId + '/' + msgDetails.employerId)
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    let messages = response.body;
                    let prevTime = 0;
                    for(let i=0; i<messages.length; i++){
                        messages
                        messages[i].should.have.property('student_id');
                        messages[i].student_id.should.equal(msgDetails.studentId);
                        messages[i].should.have.property('employer_id');
                        messages[i].employer_id.should.equal(msgDetails.employerId);
                        messages[i].should.have.property('message');
                        messages[i].should.have.property('send_date');
                        let currTime = Date.parse(messages[i].send_date);
                        currTime.should.above(prevTime);
                        prevTime = currTime;
                        messages[i].should.have.property('sender');
                    }
                    done();

                })
        })

        it('should get a 400: Bad Request answer if the parameter of the request are not numbers', (done) =>{
            chai.request(server)
                .get('/message/' + msgDetails.studentId + '/lacipolla')
                .end((err, response) => {
                    response.should.have.status(400);
                    done();
                })
        })

    })

})
