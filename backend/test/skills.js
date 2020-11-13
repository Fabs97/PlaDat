const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema')

//Assertion style
chai.should();

chai.use(chaiHttp);
chai.use(chaiJsonSchema);

//Schema
const skillSchema = require('../DB/schema');

// chai.tv4.addSchema('../DB/schema', schema)
// var schema = chai.tv4.getSchema('../DB/schema');

describe('skills api', () => {
    /*
        Test the GET route 
    */

    describe('GET /skills', () => {
        it('should get all the tech and soft skills', (done) => {
            chai.request(server)
                .get('/skills')
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('object');
                    response.body.should.have.property('technicalSkills');
                    response.body.should.have.property('softSkills');
                    
                    const technicalSkills = response.body.technicalSkills;
                    const softSkills = response.body.softSkills;

                    technicalSkills.should.be.a('array');
                    for(let i=0; i<technicalSkills.length; i++) {
                        technicalSkills[i].should.have.property('id');
                        technicalSkills[i].should.have.property('name');
                        technicalSkills[i].should.have.property('type');
                    }

                    softSkills.should.be.a('array');
                    for(let i=0; i<technicalSkills.length; i++) {
                        softSkills[i].should.have.property('id');
                        softSkills[i].should.have.property('name');
                        softSkills[i].should.have.property('type');
                    }

                    // response.body.should.be.jsonSchema(skillSchema);
                    done();
                })
        })
    })

});