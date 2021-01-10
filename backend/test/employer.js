const chai = require('chai');
const server = require('../index');
const chaiHttp = require('chai-http');
const chaiJsonSchema = require('chai-json-schema');
const router = require('../routes/studentRoute');
const { response } = require('express');
const { request } = require('chai');
const { post, setMaxListeners } = require('../index');
const { getPlacementsByEmployerId } = require('../DAO/placementDAO');

//Assertion style
chai.should();

chai.use(chaiHttp);
chai.use(chaiJsonSchema);

describe('employer API', () => {

    describe('POST /employer', () => {

        let domId;
        let employerId;
        let locationId; 
        let userId;
        let sessionToken;

        beforeEach(async () => {

            let newUser = {
                email: 'test_employer@mail.com',
                password: '12345678',
                type: 'EMPLOYER'
            }
            let account = (await chai.request(server)
                .post('/registration')
                .set('content-type', 'application/json')
                .send(newUser)).body;
            let session = (await chai.request(server)
                .post('/login')
                .set('content-type', 'application/json')
                .send({email: newUser.email, password: newUser.password})).body;
       

            // console.log(session);
            userId = session.userID;
            sessionToken = session.token;

            let doms = (await chai.request(server)
                .get('/domainOfActivity').set('Authorization', `Bearer ${sessionToken}`)).body;
            domId = doms[0].id;

        })

        it('should post the profile in the database and returns all the details', (done) => {

            chai.request(server)
                .post('/employer')
                .set('content-type', 'application/json')
                .set('Authorization', `Bearer ${sessionToken}`)
                .send({
                    name: "test company",
                    description: "test description",
                    domainOfActivityId: domId,
                    location: {
                        country: "test employer country",
                        city: "test employer city"
                    },
                })
                .end((err, response) => {
                    response.should.have.status(200);
                    response.body.should.be.a('object');
                    response.body.should.have.property('id');
                    employerId = response.body.id;
                    response.body.should.have.property('name');
                    response.body.name.should.equal('test company');
                    response.body.should.have.property('description');
                    response.body.description.should.equal('test description');
                    response.body.should.have.property('location');
                    response.body.location.should.be.a('object');
                    response.body.location.should.have.property('id');
                    locationId = response.body.location.id;
                    response.body.location.should.have.property('city');
                    response.body.location.city.should.equal('test employer city');
                    response.body.location.should.have.property('country');
                    response.body.location.country.should.equal('test employer country');
                    response.body.should.have.property('domain_of_activity_id');
                    response.body.domain_of_activity_id.should.equal(domId);
                    done();
                })

        })

        afterEach(async () => {
            await chai.request(server)
                .delete('/employer/' + employerId)
                .set('Authorization', `Bearer ${sessionToken}`);
            await chai.request(server)
                .delete('/user/' + userId)
                .set('Authorization', `Bearer ${sessionToken}`);
            await chai.request(server)
                .delete('/location/' + locationId)
                .set('Authorization', `Bearer ${sessionToken}`);
        })

    })

})