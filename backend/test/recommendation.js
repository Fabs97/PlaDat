const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema');
const { response } = require('express');

//Assertion style
chai.should();

chai.use(chaiHttp);
chai.use(chaiJsonSchema);

describe('recommendation API', () => {

    describe('GET /recommendation/:id/seePlacements', () => {

        let studentId;
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
        })

        it('should get a list of placements based on the id of a student', (done) => {
        
            chai.request(server)
                .get('/recommendation/' + studentId + '/seePlacements')
                .set('Authorization', `Bearer ${sessionToken}`)
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    let placements = response.body;
                    for(let i = 0; i < placements.length; i++) {
                        placements[i].should.be.a('object');
                        placements[i].should.have.property('id');
                        placements[i].should.have.property('position');
                        placements[i].should.have.property('employment_type');
                        placements[i].should.have.property('employer_id');
                        placements[i].should.have.property('start_period');
                        placements[i].should.have.property('end_period');                                
                        placements[i].should.have.property('salary');
                        placements[i].should.have.property('description_role');
                        placements[i].should.have.property('skills');
                        let skills = placements[i].skills;
                        skills.should.be.a('array');
                        for(let j = 0; j < skills.length; j++){
                            skills[j].should.be.a('object');
                            skills[j].should.have.property('id');
                            skills[j].should.have.property('name');
                            skills[j].should.have.property('type');
                        }
                        if(placements[i].location){
                            placements[i].location.should.be.a('object');
                            placements[i].location.should.have.property('id');
                            placements[i].location.should.have.property('country');
                            placements[i].location.should.have.property('city');
                        }
                        placements[i].should.have.property('majors');
                        let majors = placements[i].majors;
                        majors.should.be.a('array');
                        if(majors.length) {
                            for(let j = 0; j < majors.length; j++){
                                majors[j].should.be.a('object');
                                majors[j].should.have.property('name');
                            }
                        }
                        placements[i].should.have.property('institutions');
                        let institutions = placements[i].institutions;
                        institutions.should.be.a('array');
                        if(institutions.length) {
                            for(let j = 0; j < institutions.length; j++){
                                institutions[j].should.be.a('object');
                                institutions[j].should.have.property('name');
                            }
                        }
                    }
                    done();
                })
            
            
        })

        it('should get a 400 Bad Request error if the request does not contains a valid student id', (done) => {
            chai.request(server)
                .get('/recommendation/foo/seePlacements')
                .set('Authorization', `Bearer ${sessionToken}`)
                .end((err, response) => {
                    response.should.have.status(400);
                    done();
                })
        })

    })

    describe('GET /recommendation/:id/seeStudents', () => {

        let employerId;
        let userId;
        let sessionToken;
        let placementId;

        beforeEach(async () =>{
            let employer = {
                email: 'google@google.com',
                password: '12345678',
            }
            session = (await chai.request(server)
                .post('/login')
                .set('content-type', 'application/json')
                .send(employer)).body;
            // console.log(session);
            userId = session.userID;
            sessionToken = session.token;
            employerId = session.employerID;

            placementId = (await chai.request(server)
                .get('/employer/' + employerId + '/placements')
                .set('Authorization', `Bearer ${sessionToken}`)).body[0].id
        });

        it('should get a list of students recommended based on the id of a placement', (done) => {
            
            chai.request(server)
                .get('/recommendation/' + placementId + '/seeStudents')
                .set('Authorization', `Bearer ${sessionToken}`)
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    let students = response.body;
                    for( i = 0; i < students.length; i++){
                        students[i].should.have.property('id');
                        students[i].should.have.property('name');
                        students[i].should.have.property('surname');
                        students[i].should.have.property('description');
                        if(students[i].location){
                            students[i].location.should.be.a('object');
                            students[i].location.should.have.property('id');
                            students[i].location.should.have.property('country');
                            students[i].location.should.have.property('city');
                        }
                        students[i].should.have.property('skills');
                        let skills = students[i].skills;
                        skills.should.be.a('array');
                        for(let j = 0; j < skills.length; j++){
                            skills[j].should.be.a('object');
                            skills[j].should.have.property('id');
                            skills[j].should.have.property('name');
                            skills[j].should.have.property('type');
                        }
                        students[i].should.have.property('education');
                        let educations = students[i].education;
                        educations.should.be.a('array');
                        for(let j = 0; j < educations.length; j++){
                            educations[j].should.be.a('object');
                            educations[j].should.have.property('major');
                            educations[j].should.have.property('institution');
                            educations[j].should.have.property('degree');
                            educations[j].should.have.property('start_period');
                            educations[j].should.have.property('end_period');
                            educations[j].should.have.property('description');
                        }
                        students[i].should.have.property('work');
                        let works = students[i].work;
                        works.should.be.a('array');
                        for(let j = 0; j < works.length; j++){
                            works[j].should.be.a('object');
                            works[j].should.have.property('position');
                            works[j].should.have.property('company_name');
                            works[j].should.have.property('start_period');
                            works[j].should.have.property('end_period');
                            works[j].should.have.property('description');
                        }
                    }
                     done();
                })
            
        })

        it('should get a 400 Bad Request error if the request does not contains a valid placement id', (done) => {
            chai.request(server)
                .get('/recommendation/foo/seeStudents')
                .set('Authorization', `Bearer ${sessionToken}`)
                .end((err, response) => {
                    response.should.have.status(400);
                    done();
                })
        })

    })
})