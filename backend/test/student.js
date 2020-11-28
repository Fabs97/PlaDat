const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema');
const router = require('../routes/studentRoute');
const { response } = require('express');

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
                .set('content-ype', 'application/json')
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
                    //response.body[0].name.should.be(testStudent.name);
                    //response.body[0].surname.should.be(testStudent.surname);
                    //response.body[0].email.should.be(testStudent.email);
                    //response.body[0].description.should.be(testStudent.description);ù
                    //response.body[0].phone.should.be(testStudent.phone);


                    done();
                })
        })
    })

    describe('GET /student/:id', () => {
        it('should get the student details', (done) => {
            chai.request(server)
                .get('/student/' + '1')
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('object');
                    response.body.should.have.property('id');
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