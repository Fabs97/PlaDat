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
        phone: "test phone",
        education: [
            {
                majorId: 1,
                degreeId: 1,
                institutionId: 1,
                description: "Test description",
                period: "test period : September 2020 - October 2021"
            },
            {
                majorId: 2,
                degreeId: 1,
                institutionId: 2,
                description: "Test description 2",
                period: "test period : September 2019 - October 2020"
            }
        ],
        skills: {
            technicalSkills : [ 
                {
                    "id": 1
                },
                {
                    "id": 1
                }
            ],
            softSkills : [ 
                {
                    "id": 17
                },
                {
                    "id": 18
                }
            ]
        },
        work: [
            {
                companyName: "Test Company name",
                position: "Test position",
                description: "Test job description",
                workPeriod: "Test date : September 2020 - October 2021"
            },
            {
                companyName: "Test Company name 2",
                position: "Test position 2",
                description: "Test job description 2",
                workPeriod: "Test date : September 2020 - October 2021 2"
            },
        ]

    };

    describe('POST /student', () =>{
        it('should add a student in the db and recieve its data and id as an answer', (done) => {
            
            chai.request(server)
                .post('/student')
                .set('content-type', 'application/json')
                .send(testStudent)
                .end((err, response) => {
                    response.should.have.status(200);
                    let newStudent = response.body;
                    newStudent.should.be.a('object');
                    newStudent.should.have.property('id');
                    newStudent.should.have.property('name');
                    newStudent.should.have.property('surname');
                    newStudent.should.have.property('email');
                    newStudent.should.have.property('description');
                    newStudent.should.have.property('phone');
                    newStudent.should.have.property('education');
                    newStudent.should.have.property('work');
                    newStudent.should.have.property('skills');

                    testStudent.id = newStudent.id;

                    newStudent.name.should.equal(testStudent.name);
                    newStudent.surname.should.equal(testStudent.surname);
                    newStudent.email.should.equal(testStudent.email);
                    newStudent.description.should.equal(testStudent.description);
                    newStudent.phone.should.equal(testStudent.phone);

                    //skills
                    let skills = newStudent.skills;
                    skills.should.be.a('array');
                    for(let i=0; i<skills.length; i++){
                        skills[i].should.have.property('student');
                        skills[i].should.have.property('skill');
                    }

                    //work
                    let work = newStudent.work;
                    work.should.be.a('array');
                    for(let i=0; i<work.length; i++){
                        work[i].should.have.property('id');
                        work[i].should.have.property('companyName');
                        work[i].should.have.property('position');
                        work[i].should.have.property('workPeriod');
                        work[i].should.have.property('description');
                    }

                    //education
                    let education = newStudent.education;
                    education.should.be.a('array');
                    for(let i=0; i<education.length; i++){
                        education[i].should.have.property('studentId');
                        education[i].should.have.property('educationId');
                        education[i].should.have.property('description');
                        education[i].should.have.property('period');
                        education[i].should.have.property('majorId');
                        education[i].should.have.property('degreeId');
                        education[i].should.have.property('institutionId');
                    }

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