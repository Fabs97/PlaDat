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
        let userId;
        let sessionToken;

        beforeEach(async () =>{
            let student = {
                email: 'Alice@test.com',
                password: '12345678',
            }
            session = (await chai.request(server)
                .post('/login')
                .set('content-type', 'application/json')
                .send(student)).body;
            // console.log(session);
            userId = session.userID;
            sessionToken = session.token;
            studentId = (await chai.request(server)
                .get('/student/account/' + userId)
                .set( 'Authorization', `Bearer ${session.token}`)).body.id;
            // console.log(`token works!!! ${session.token}`)
        })

        it('should get all the placements that the student has matched with', (done) => {
            chai.request(server)
            .get('/student/' + studentId + '/placements')
            .set( 'Authorization', `Bearer ${sessionToken}`)
            .end((err, response) => {
                console.log(response.body)
                // console.log(err)
                response.should.have.status(200);
                response.body.should.be.a('array');
                let placements = response.body;
                for(let i=0; i<placements.length; i++) {
                    placements[i].should.have.property('id');
                    placements[i].should.have.property('position');
                    placements[i].should.have.property('description_role');
                    placements[i].should.have.property('employer_id');
                    placements[i].should.have.property('employer_name');
                }

                done();
            });
        }).timeout(20000);
    })

    describe('GET /placement/:placementId/students', () => {
        let placementId;
        let userId;
        let sessionToken;

        beforeEach(async () =>{
            let student = {
                email: 'google@google.com',
                password: '12345678',
            }
            session = (await chai.request(server)
                .post('/login')
                .set('content-type', 'application/json')
                .send(student)).body;
            // console.log(session);
            userId = session.userID;
            sessionToken = session.token;
            placementId = (await chai.request(server)
                .get('/employer/' + session.employerID + '/placements')
                .set('Authorization', `Bearer ${sessionToken}`)).body[0].id;
            // console.log(`placement id ${placementId}`)
        })

        it('should get all the students that the placement has matched with', (done) => {
            chai.request(server)
            .get('/placement/' + placementId + '/students')
            .set('Authorization', `Bearer ${sessionToken}`)
            .end((err, response) => {
                response.should.have.status(200);
                response.body.should.be.a('array');
                // console.log(response.body)
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