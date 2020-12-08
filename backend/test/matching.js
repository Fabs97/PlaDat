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
        let placementId;
        it('should get all the placements that the student has matched with', (done) => {
           chai.request(server)
            .get('/students/last')
            .end((err, response) => {
                let studentId = response.body.id
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
                })
            })
            
        }).timeout(10000)
    })

})