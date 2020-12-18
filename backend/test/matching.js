const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema');

//Assertion style
chai.should();

chai.use(chaiHttp);
chai.use(chaiJsonSchema);

describe('matching API', () => {

    describe('GET /student/:studentId/placements', () => {
        let studentId;

        beforeEach(async () =>{
            studentId = (await chai.request(server).get('/students/last')).body.id;
        })

        it('should get all the placements that the student has matched with', (done) => {
            chai.request(server)
            .get('/student/' + studentId + '/placements')
            .end((err, response) => {
                response.should.have.status(200);
                response.body.should.be.a('array');
                let placements = response.body;
                for(let i=0; i<placements.length; i++) {
                    placements[i].should.have.property('placementId');
                    placements[i].should.have.property('position');
                    placements[i].should.have.property('employerId');
                    placements[i].should.have.property('employerName');
                }
                done();
            });
        }).timeout(10000)
    })

    describe('GET /placement/:placementId/students', () => {
        let placementId;

        beforeEach(async () =>{
            placementId = (await chai.request(server).get('/placements/last')).body.id;
        })

        it('should get all the students that the placement has matched with', (done) => {
            chai.request(server)
            .get('/placement/' + placementId + '/students')
            .end((err, response) => {
                response.should.have.status(200);
                response.body.should.be.a('array');
                let students = response.body;
                for(let i=0; i<students.length; i++) {
                    students[i].should.be.a('object');
                    students[i].should.have.property('id');
                    students[i].should.have.property('name');
                    students[i].should.have.property('surname');
                    students[i].should.have.property('description');

                    let skills = students[i].skills;
                    skills.should.be.a('array');
                    for(let i=0; i<skills.length; i++){
                        skills[i].should.have.property('id');
                        skills[i].should.have.property('name');                        
                        skills[i].should.have.property('type');
                    }

                }                            

                done();
            });

        }).timeout(10000)
        
    })

})