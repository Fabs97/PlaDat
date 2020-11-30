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
        it('should get a list of placements based on the id of a student', (done) => {
            chai.request(server)
                .get('/students/last')
                .end((err, response) => {
                    let studentId = response.body.id;
                    chai.request(server)
                        .get('/recommendation/' + studentId + '/seePlacements')
                        .end((err, response) => {
                            response.should.have.status(200);
                            response.body.should.be.a('array');
                            let placements = response.body;
                            for(let i = 0; i < placements.length; i++) {
                                placements[i].should.have.property('id');
                                placements[i].should.have.property('position');
                                placements[i].should.have.property('working_hours');
                                placements[i].should.have.property('start_period');
                                placements[i].should.have.property('end_period');
                                placements[i].should.have.property('salary');
                                placements[i].should.have.property('description_role');
                                placements[i].should.have.property('skills');
                                let skills = placements[i].skills;
                                for(j = 0; j < skills.length; j++){
                                    skills.should.have.property('id');
                                    skills.should.have.property('name');
                                    skills.should.have.property('type');
                                }
                            }
                            done();
                        })
                })
            
        })
    })

    describe('GET /recommendation/:id/seeStudents', () => {
        it('should get a list of students based on the id of a placement', (done) => {
            chai.request(server)
            .get('/placement')
            .end((err, response) => {
                let placementId = response.body[0].id
                chai.request(server)
                        .get('/recommendation/' + placementId + '/seeStudents')
                        .end((err, response) => {
                            response.should.have.status(200);
                            response.body.should.be.a('array');
                            let students = response.body;
                            for( i = 0; i < students.length; i++){
                                students[i].should.have.property('id');
                                students[i].should.have.property('name');
                                students[i].should.have.property('surname');
                                //students[i].should.have.property('email');
                                //students[i].should.have.property('description');
                                //students[i].should.have.property('phone');
                                //students[i].should.have.property('skills');
                                let skills = students[i].skills;
                                for(j = 0; j < skills.length; j++){
                                    skills.should.have.property('id');
                                    skills.should.have.property('name');
                                    skills.should.have.property('type');
                                }
                            }
                            done();
                        })
            })
            
        })
    })
})