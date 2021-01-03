
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('location').del()
    .then(function () {
      // Inserts seed entries
      return knex('location').insert([
        {country: 'Italy', city: 'Rome'},
        {country: 'Italy', city: 'Milan'},
        {country: 'Sweden', city: 'Stockolm'},
        {country: 'United Kingdom', city: 'London'},
        {country: 'Finland', city: 'Helsinki'},
        {country: 'United States of America', city: 'New York'},
        {country: 'France', city: 'Paris'}
      ]);
    });
};
