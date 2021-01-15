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

        let studentId;
        let employerId;
        let userId;
        let sessionToken;

        beforeEach(async () =>{
            let student = {
                email: 'Alice@test.com',
                password: '12345678',
            }
            let session = (await chai.request(server)
                .post('/login')
                .set('content-type', 'application/json')
                .send(student)).body;
            // console.log(session);
            userId = session.userID;
            sessionToken = session.token;
            studentId = session.studentID;
            // console.log(`token works!!! ${session.token}`)
            let matches = (await chai.request(server)
                .get('/student/' + studentId + '/placements')
                .set('Authorization', `Bearer ${sessionToken}`)).body;
            employerId = matches[0].employer_id
            // console.log(matches)
        })
        
        let msg = {
            message: "Hello, thank you for the internship opportunity",
            sender: "STUDENT",
            sendDate: new Date(),
        }

        it('should save a new message from a student to an employer', (done) => {
            chai.request(server)
                .post('/message')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send({
                    studentId: studentId,
                    employerId: employerId,
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
                    response.body.should.have.property('id');
                    msg.id = response.body.id;
                    response.body.student_id.should.equal(studentId);
                    response.body.employer_id.should.equal(employerId);
                    response.body.message.should.equal(msg.message);
                    (new Date(response.body.send_date).getTime()).should.equal(msg.sendDate.getTime());
                    response.body.sender.should.equal(msg.sender);
                    done();
                })
        }).timeout(10000);

        it('should get a 400: Bad Request answer if the body of the request has wrong structure', (done) => {
            chai.request(server)
                .post('/message')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send({
                    studentId: studentId,
                    // employerId: employerId,
                    // message: msg.message,
                    sendDate: msg.sendDate,
                    // sender: msg.sender
                })
                .end((err, response) => {
                    response.should.have.status(400);
                    done();
                })
        }).timeout(10000);

        it('should get a 500: Internal Server Error answer if the server cannot save the message', (done) => {
            chai.request(server)
                .post('/message')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send({
                    studentId: studentId,
                    employerId: employerId,
                    sendDate: msg.sendDate,
                    sender: msg.sender
                })
                .end((err, response) => {
                    response.should.have.status(400);
                    done();
                })
        }).timeout(10000);

        afterEach( async () => {
            await chai.request(server)
                .delete('/message')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send({
                    studentId: studentId,
                    employerId: employerId,
                    sendDate: msg.sendDate,
                    id: msg.id
                })
        })
        
    })


    describe('GET /message/:studentId/:employerId', () =>{

        let studentId;
        let employerId;
        let userId;
        let sessionToken;

        beforeEach(async () =>{
            let student = {
                email: 'Alice@test.com',
                password: '12345678',
            }
            let session = (await chai.request(server)
                .post('/login')
                .set('content-type', 'application/json')
                .send(student)).body;
            // console.log(session);
            userId = session.userID;
            sessionToken = session.token;
            studentId = session.studentID;
            // console.log(`token works!!! ${session.token}`)
            let matches = (await chai.request(server)
                .get('/student/' + studentId + '/placements')
                .set('Authorization', `Bearer ${sessionToken}`)).body;
            employerId = matches[0].employer_id
            // console.log(matches)
        })

        it('should return a list of messages between two users, in chronological order', (done) => {
            chai.request(server)
                .get('/message/' + studentId + '/' + employerId)
                .set('Authorization', `Bearer ${sessionToken}`)
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    let messages = response.body;
                    let prevTime = 0;
                    for(let i=0; i<messages.length; i++){
                        messages[i].should.have.property('student_id');
                        messages[i].student_id.should.equal(studentId);
                        messages[i].should.have.property('employer_id');
                        messages[i].employer_id.should.equal(employerId);
                        messages[i].should.have.property('message');
                        messages[i].should.have.property('send_date');
                        let currTime = Date.parse(messages[i].send_date);
                        currTime.should.be.at.least(prevTime);
                        prevTime = currTime;
                        messages[i].should.have.property('sender');
                        messages[i].should.have.property('id');
                    }
                    done();

                })
        })

        it('should get a 400: Bad Request answer if the parameter of the request are not numbers', (done) =>{
            chai.request(server)
                .get('/message/' + studentId + '/lacipolla')
                .set('Authorization', `Bearer ${sessionToken}`)
                .end((err, response) => {
                    response.should.have.status(400);
                    done();
                })
        })

    })

})
