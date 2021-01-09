
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('registration').del()
    .then(function () {
      // Inserts seed entries
      return knex('registration').insert([
        //12345678
        {email: "google@google.com", password: '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'EMPLOYER'},
        {email: "amazon@amazon.com", password: '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'EMPLOYER'},
        {email: "Instagram@Instagram.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'EMPLOYER'},
        {email: "Pinterest@Pinterest.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'EMPLOYER'},
        {email: "Facebook@Facebook.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'EMPLOYER'},
        {email: "Reply@Reply.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'EMPLOYER'},
        {email: "Oracle@Oracle.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'EMPLOYER'},
        {email: "Alice@test.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Fabrizio@test.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Anna@test.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Aida@test.com",  password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Andela@test.com",  password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "William@test.com",  password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Bassam@test.com",  password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Jhonny@test.com",  password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Maryl@test.com", password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'},
        {email: "Freddy@test.com",  password:  '$2b$10$RMoFltIgzqy8QO8.nhcD0.Ovv.mhVuBAsoXZtLE3PA9x3v3XAda4a', type: 'STUDENT'}
      ])
    });
};