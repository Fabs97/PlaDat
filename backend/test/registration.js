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
    let testRegistration = {
        email: 'test email',
        password: ' test password',
        type: 'STUDENT'
    }
    describe('POST /registration', () => {
        it('should add a user in the db and receive its data and id as an answer', (done) => {

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
})