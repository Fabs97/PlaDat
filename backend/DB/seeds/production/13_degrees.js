
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('degree').del()
    .then(function () {
      // Inserts seed entries
      return knex('degree').insert([
        {name: 'Bachelor'},
        {name: 'Master'},
        {name: 'PhD'}
      ]);
    });
};