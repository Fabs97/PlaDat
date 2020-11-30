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

describe('placement API', () => {

    describe('POST /placement/new-placement', () => {
        let placementId;
        it('should add a new placement to the db and return the details with the id', (done) => {
            chai.request(server)
                .post('/placement/new-placement')
                .set('content-type', 'application/json')
                .send({
                        position: "test position",
                        workingHours: 0,
                        startDate: "test start date",
                        endDate: "test end date",
                        salary: 0,
                        descriptionRole: "test description role", 
                        employerID: 0,
                        institutions: [],
                        majors: [],
                        skills: []})
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('object');
                    response.body.should.have.property('id');
                    placementId = response.body.id;
                    response.body.should.have.property('position');
                    response.body.should.have.property('working_hours');
                    response.body.should.have.property('start_period');
                    response.body.should.have.property('end_period');
                    response.body.should.have.property('salary');
                    response.body.should.have.property('description_role');
                    response.body.should.have.property('institutions');
                    let institutions = response.body.institutions;
                    institutions.should.be.a('array');
                    for(let i=0; i<institutions.length; i++){
                        institutions[i].should.be.a('object');
                        institutions[i].should.have.property('id');
                        institutions[i].should.have.property('name');
                    }
                    response.body.should.have.property('majors');
                    let majors = response.body.majors;
                    majors.should.be.a('array')
                    for(let i=0; i<majors.length; i++){
                        majors[i].should.be.a('object');
                        majors[i].should.have.property('id');
                        majors[i].should.have.property('name');
                    }
                    response.body.should.have.property('skills');
                    let skills = response.body.skills;
                    skills.should.be.a('array');
                    for(let i=0; i<skills.length; i++){
                        skills[i].should.be.a('object');
                        skills[i].should.have.property('id');
                        skills[i].should.have.property('name');
                        skills[i].should.have.property('type');
                    }
                    //response.body.should.have.property('employer_id');
                    done();
                })
        })

        afterEach(async () =>{
            await chai.request(server)
                .delete('/placement/' + placementId)
        })
    })

    describe('GET /placement/:id', () => {
        

        it('should return the placement with all its details', (done) => {
            chai.request(server)
            .get('/placement')
            .end((err, response) => {
                let placementId = response.body[0].id
                chai.request(server)
                .get('/placement/' + placementId)
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('object');
                    response.body.should.have.property('id');
                    response.body.id.should.equal(placementId);
                    response.body.should.have.property('position');
                    response.body.should.have.property('working_hours');
                    response.body.should.have.property('start_period');
                    response.body.should.have.property('end_period');
                    response.body.should.have.property('salary');
                    response.body.should.have.property('description_role');
                    response.body.should.have.property('employer');
                    let employer = response.body.employer;
                    if(employer != null){
                        employer.should.be.a('object');
                        employer.should.have.property('name');
                        employer.should.have.property('location');
                        employer.should.have.property('urllogo');
                    }
                    response.body.should.have.property('institutions');
                    let institutions = response.body.institutions;
                    institutions.should.be.a('array');
                    for(let i=0; i<institutions.length; i++){
                        institutions[i].should.be.a('object');
                        institutions[i].should.have.property('id');
                        institutions[i].should.have.property('name');
                    }
                    response.body.should.have.property('majors');
                    let majors = response.body.majors;
                    majors.should.be.a('array')
                    for(let i=0; i<majors.length; i++){
                        majors[i].should.be.a('object');
                        majors[i].should.have.property('id');
                        majors[i].should.have.property('name');
                    }
                    response.body.should.have.property('skills');
                    let skills = response.body.skills;
                    skills.should.be.a('array');
                    for(let i=0; i<skills.length; i++){
                        skills[i].should.be.a('object');
                        skills[i].should.have.property('id');
                        skills[i].should.have.property('name');
                        skills[i].should.have.property('type');
                    }

                    done();
                })
            })
            
        }).timeout(10000)
    })

    describe('GET /placement', () => {
        it('should return an array with all the ids of all the placements', (done) => {
            chai.request(server)
                .get('/placement')
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    let ids = response.body;
                    for(let i=0; i<ids.length; i++){
                        ids[i].should.be.a('object');
                        ids[i].should.have.property('id')
                    }
                    done();
                })
        })
    })

    describe('GET /employer/:employerId/placements', () => {
        it('should get an array of placements with a little details on them', (done) => {
            chai.request(server)
                .get('/employers/last')
                .end((err, response) => {
                    chai.request(server)
                        .get('/employer/' + response.body.id + '/placements')
                        .end((err, response) => {
                            response.should.have.status(200);
                            response.body.should.be.a('array');
                            let placements = response.body;
                            for(let i=0; i<placements.length; i++){
                                placements[i].should.be.a('object');
                                placements[i].should.have.property('id');
                                placements[i].should.have.property('position');
                                placements[i].should.have.property('working_hours');
                                placements[i].should.have.property('start_period');
                                placements[i].should.have.property('end_period');
                                placements[i].should.have.property('salary');
                                placements[i].should.have.property('description_role');
                                placements[i].should.have.property('employer_id');
                            }
                            done();
                        })
                })
            
        })
    })

})