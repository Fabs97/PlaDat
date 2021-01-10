const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema');
const router = require('../routes/registrationRoute');
const { response } = require('express');
const { request } = require('chai');

chai.should();

chai.use(chaiHttp);
chai.use(chaiJsonSchema);

describe('registration API', () => {
    
    describe('POST /registration', () => {
        it('should add a STUDENT user in the db and receive its data and id as an answer', (done) => {

            let testRegistration = {
                email: 'test_student@mail.com',
                password: '12345678',
                type: 'STUDENT'
            }

            chai.request(server)
            .post('/registration')
            .set('content-type', 'application/json')
            .send({email: testRegistration.email, password: testRegistration.password, type: testRegistration.type})
            .end((err, response) => {
                response.should.have.status(200);
                response.body.should.be.a('object');
                response.body.should.have.property('email');
                //response.body.should.have.property('password');
                response.body.should.have.property('type');
                testRegistration.id = response.body.id;
                response.body.email.should.equal(testRegistration.email);
                //response.body.password.should.equal(testRegistration.password);
                response.body.type.should.equal(testRegistration.type);
                
                done();
            })
        });

        it('should add an EMPLOYER user in the db and receive its data and id as an answer', (done) => {

            let testRegistration = {
                email: 'test_employer@mail.com',
                password: '12345678',
                type: 'EMPLOYER'
            }
            
            chai.request(server)
            .post('/registration')
            .set('content-type', 'application/json')
            .send({email: testRegistration.email, password: testRegistration.password, type: testRegistration.type})
            .end((err, response) => {
                response.should.have.status(200);
                response.body.should.be.a('object');
                response.body.should.have.property('email');
                //response.body.should.have.property('password');
                response.body.should.have.property('type');
                testRegistration.id = response.body.id;
                response.body.email.should.equal(testRegistration.email);
                //response.body.password.should.equal(testRegistration.password);
                response.body.type.should.equal(testRegistration.type);
                
                done();
            })
        })
    })

    describe('POST /login', () => {
        let testUserIds = [];
        it('should login a previously created STUDENT user and return its JWT', (done) => {
            let testLogin = {
                email: 'test_student@mail.com',
                password: '12345678'
            }
            chai.request(server)
            .post('/login')
            .set('content-type', 'application/json')
            .send({email: testLogin.email, password: testLogin.password})
            .end((err, response) => {
                response.should.have.status(200);
                response.body.should.be.a('object');
                response.body.should.have.property('userID');
                response.body.should.have.property('student');
                response.body.should.have.property('token');
                response.body.student.should.equal(true);
                testUserIds.push(response.body.userID);
                done();
            })
        });

        it('should add an EMPLOYER user in the db and receive its data and id as an answer', (done) => {

            let testLogin = {
                email: 'test_employer@mail.com',
                password: '12345678'
            }
            
            chai.request(server)
            .post('/login')
            .set('content-type', 'application/json')
            .send({email: testLogin.email, password: testLogin.password})
            .end((err, response) => {
                response.should.have.status(200);
                response.body.should.be.a('object');
                response.body.should.have.property('userID');
                response.body.should.have.property('student');
                response.body.should.have.property('token');
                response.body.student.should.equal(false);
                testUserIds.push(response.body.userID);

                done();
            })
        })

        after(async () => {
            for(let i=0; i<testUserIds.length; i++ ) {
                await chai.request(server).delete('/user/' + testUserIds[i]);
            }
        })
    })
})