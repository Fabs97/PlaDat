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

    describe('POST /student', () =>{
        let testStudent = {
            name: "Test Name",
            surname: "Test Surname",
            description: "Test Description",
            phone: "28029328483",
            location: {
                country: "Canada",
                city: "Toronto"
            },
            skills: {
                technicalSkills: [],
                softSkills: [],
            },
            education: [],
            work: [
                {
                    companyName: "Test Company name",
                    position: "Test position",
                    description: "Test job description",
                    startPeriod: "2020-12-14",
                    endPeriod: "2020-12-14",
                },
                {
                    companyName: "Test Company name 2",
                    position: "Test position 2",
                    description: "Test job description 2",
                    startPeriod: "2020-12-14",
                    endPeriod: "2020-12-14",
                },
            ]
        };
        let userId, sessionToken, studentId, majors;
    
        before(async () =>{
            let newUser = {
                email: 'test_student@mail.com',
                password: '12345678',
                type: 'STUDENT'
            }
            account = (await chai.request(server)
                .post('/registration')
                .set('content-type', 'application/json')
                .send(newUser)).body;
            session = (await chai.request(server)
                .post('/login')
                .set('content-type', 'application/json')
                .send({email: newUser.email, password: newUser.password})).body;
            // console.log(session);
            userId = session.userID;
            sessionToken = session.token;        
            majors = (await chai.request(server)
                .get('/majors')
                .set('Authorization', `Bearer ${sessionToken}`)).body;
            degrees = (await chai.request(server)
                .get('/degrees')
                .set('Authorization', `Bearer ${sessionToken}`)).body;
            institutions = (await chai.request(server)
                .get('/institutions')
                .set('Authorization', `Bearer ${sessionToken}`)).body;
            techSkills = (await chai.request(server)
                .get('/skills/TECH')
                .set('Authorization', `Bearer ${sessionToken}`)).body;
            softSkills = (await chai.request(server)
                .get('/skills/SOFT')
                .set('Authorization', `Bearer ${sessionToken}`)).body;
    
            testStudent.userId = userId;
    
            testStudent.education.push({
                majorId: majors[0].id,
                degreeId: degrees[0].id,
                institutionId: institutions[0].id,
                description: "Test description",
                startPeriod: "2020-12-14",
                endPeriod: "2021-12-14",
            })
            testStudent.education.push({
                majorId: majors[1].id,
                degreeId: degrees[1].id,
                institutionId: institutions[1].id,
                description: "Test description",
                startPeriod: "2020-12-14",
                endPeriod: "2021-12-14",
            })
    
            testStudent.skills.technicalSkills.push({ id: techSkills[0].id})
            testStudent.skills.technicalSkills.push({ id: techSkills[1].id})
            testStudent.skills.technicalSkills.push({ id: techSkills[2].id})
            testStudent.skills.softSkills.push({ id: softSkills[0].id})
            testStudent.skills.softSkills.push({ id: softSkills[1].id})
            
        });

        it('should add a student in the db and recieve its data and id as an answer', (done) => {
            
            chai.request(server)
                .post('/student')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send(testStudent)
                .end((err, response) => {
                    response.should.have.status(200);
                    let newStudent = response.body;
                    newStudent.should.be.a('object');
                    newStudent.should.have.property('id');
                    newStudent.should.have.property('name');
                    newStudent.should.have.property('surname');
                    newStudent.should.have.property('description');
                    newStudent.should.have.property('phone');
                    newStudent.should.have.property('location');
                    newStudent.should.have.property('education');
                    newStudent.should.have.property('work');
                    newStudent.should.have.property('skills');

                    newStudent.location.should.have.property('id');
                    newStudent.location.should.have.property('country');
                    newStudent.location.should.have.property('city');

                    testStudent.id = newStudent.id;

                    newStudent.name.should.equal(testStudent.name);
                    newStudent.surname.should.equal(testStudent.surname);
                    newStudent.description.should.equal(testStudent.description);
                    newStudent.phone.should.equal(testStudent.phone);
                    newStudent.location.country.should.equal(testStudent.location.country);
                    newStudent.location.city.should.equal(testStudent.location.city);

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
                        work[i].should.have.property('startPeriod');
                        work[i].should.have.property('endPeriod');
                        work[i].should.have.property('description');
                    }

                    //education
                    let education = newStudent.education;
                    education.should.be.a('array');
                    for(let i=0; i<education.length; i++){
                        education[i].should.have.property('studentId');
                        education[i].should.have.property('educationId');
                        education[i].should.have.property('description');
                        education[i].should.have.property('startPeriod');
                        education[i].should.have.property('endPeriod');
                        education[i].should.have.property('majorId');
                        education[i].should.have.property('degreeId');
                        education[i].should.have.property('institutionId');
                    }

                    done();
                })
        })

        it('should return a 500 server error when the skills are not able to be saved', (done) => {
            
            let saveInfo = testStudent.skills.technicalSkills[0].id;
            testStudent.skills.technicalSkills[0].id = 1000000;

            chai.request(server)
                .post('/student')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send(testStudent)
                .end((err, response) => {
                    response.should.have.status(500);
                    response.should.have.property('text');

                    testStudent.skills.technicalSkills[0].id = saveInfo;

                    done();
                })
        })

        it('should return a 500 server error when the education experiences are not saved', (done) => {
            
            let saveInfo = testStudent.education[0].degreeId;
            testStudent.education[0].degreeId = 1000000;

            chai.request(server)
                .post('/student')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send(testStudent)
                .end((err, response) => {
                    response.should.have.status(500);
                    response.should.have.property('text');

                    testStudent.education[0].degreeId = saveInfo;
                    done();
                })
        })

        after(async () =>{
            await chai.request(server)
                .delete('/student/' + testStudent.id)
                .set('Authorization', `Bearer ${sessionToken}`);
            await chai.request(server)
                .delete('/user/' + userId)
                .set('Authorization', `Bearer ${sessionToken}`);
        });

    })

    describe('GET /student/:id', () => {
        let studentId;
        let userId;
        let sessionToken;

        before(async () =>{
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
        })

        it('should get the student details', (done) => {
            
            chai.request(server)
                .get('/student/' + studentId)
                .set('Authorization', `Bearer ${sessionToken}`)
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
                            response.body.should.have.property('description');
                            response.body.should.have.property('skills');
                            let skills = response.body.skills;
                            skills.should.be.a('array');
                            for(let i = 0; i < skills.length; i++){
                                skills[i].should.be.a('object');
                                skills[i].should.have.property('id');
                                skills[i].should.have.property('name');
                                skills[i].should.have.property('type');
                            }
                            response.body.should.have.property('location');
                            response.body.location.should.be.a('object');
                            response.body.location.should.have.property('id');
                            response.body.location.should.have.property('country');
                            response.body.location.should.have.property('city');
                            response.body.should.have.property('education');
                            let education = response.body.education;
                            education.should.be.a('array');
                            for(let i = 0; i < education.length; i++){
                                education[i].should.be.a('object');
                                education[i].should.have.property('degree');
                                education[i].should.have.property('major');
                                education[i].should.have.property('institution');
                                education[i].should.have.property('id');
                                education[i].should.have.property('description');
                                education[i].should.have.property('start_period');
                                education[i].should.have.property('end_period');
                            }
                            response.body.should.have.property('work');
                            let work = response.body.work;
                            work.should.be.a('array');
                            for(let i = 0; i < work.length; i++){
                                work[i].should.be.a('object');
                                work[i].should.have.property('id');
                                work[i].should.have.property('company_name');
                                work[i].should.have.property('position');
                                work[i].should.have.property('start_period');
                                work[i].should.have.property('end_period');
                                work[i].should.have.property('description');
                            }
                        done();
                    })
                })
            
        })
    })

})