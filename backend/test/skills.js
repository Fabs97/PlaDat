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
                    for(let i=0; i<softSkills.length; i++) {
                        softSkills[i].should.have.property('id');
                        softSkills[i].should.have.property('name');
                        softSkills[i].should.have.property('type');
                    }

                    // response.body.should.be.jsonSchema(skillSchema);
                    done();
                })
        })

    })

    describe('GET /skills/:type', () => {
        it('should get all the techinical skills if TECH is selected', (done) => {
            chai.request(server)
                .get('/skills/TECH')
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    
                    for(let i=0; i<response.body.length; i++){
                        response.body[i].should.have.property('id');
                        response.body[i].should.have.property('name');
                        response.body[i].should.have.property('type');
                        response.body[i].type.should.equal('TECH');
                    }

                    done();
                })
        })
        it('should get all the soft skills if SOFT is selected', (done) => {
            chai.request(server)
                .get('/skills/SOFT')
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    
                    for(let i=0; i<response.body.length; i++){
                        response.body[i].should.have.property('id');
                        response.body[i].should.have.property('name');
                        response.body[i].should.have.property('type');
                        response.body[i].type.should.equal('SOFT');
                    }

                    done();
                })
        })
        it('should get all the other skills if OTHER is selected', (done) => {
            chai.request(server)
                .get('/skills/OTHER')
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('array');
                    
                    for(let i=0; i<response.body.length; i++){
                        response.body[i].should.have.property('id');
                        response.body[i].should.have.property('name');
                        response.body[i].should.have.property('type');
                        response.body[i].type.should.equal('OTHER');
                    }

                    done();
                })
        })
    })
    
});