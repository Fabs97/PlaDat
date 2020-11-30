const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema');
const router = require('../routes/studentRoute');
const { response } = require('express');
const { request } = require('chai');

//Assertion style
chai.should();

chai.use(chaiHttp);
chai.use(chaiJsonSchema);

describe('student API', () =>{
    let testStudent = {
        name: "test name",
        surname: "test surname",
        email: "test email",
        description: "test description",
        phone: "test phone"
    }

    describe('POST /student', () =>{
        it('should add a student in the db and recieve its data and id as an answer', (done) => {
            
            chai.request(server)
                .post('/student')
                .set('content-type', 'application/json')
                .send({name: testStudent.name, surname: testStudent.surname, email: testStudent.email, description: testStudent.description, phone: testStudent.phone})
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body[0].should.be.a('object');
                    response.body[0].should.have.property('id');
                    response.body[0].should.have.property('name');
                    response.body[0].should.have.property('surname');
                    response.body[0].should.have.property('email');
                    response.body[0].should.have.property('description');
                    response.body[0].should.have.property('phone');
                    testStudent.id = response.body[0].id;
                    response.body[0].name.should.equal(testStudent.name);
                    response.body[0].surname.should.equal(testStudent.surname);
                    response.body[0].email.should.equal(testStudent.email);
                    response.body[0].description.should.equal(testStudent.description);
                    response.body[0].phone.should.equal(testStudent.phone);


                    done();
                })
        })

        afterEach(async () =>{
            await chai.request(server)
                .delete('/student/' + testStudent.id)
        })
    })

    describe('GET /student/:id', () => {
        it('should get the student details', (done) => {
            chai.request(server)
                .get('/students/last')
                .end((err, response) => {
                    let studentId = response.body.id;
                    chai.request(server)
                        .get('/student/' + studentId)
                        .end((err, response) => {
                            response.should.have.status(200);
                            response.body.should.be.a('object');
                            response.body.should.have.property('id');
                            response.body.id.should.equal(studentId);
                            response.body.should.have.property('name');
                            response.body.should.have.property('surname');
                            response.body.should.have.property('email');
                            response.body.should.have.property('description');
                            response.body.should.have.property('phone');
                        done();
                    })
                })
            
        })
    })

})