
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('institutions').del()
    .then(function () {
      // Inserts seed entries
      return knex('institutions').insert([
        {name: 'Politecnico di Milano'},
        {name: 'Politecnico di Torino'},
        {name: 'Universita di Napoli'},
        {name: 'Universita di Bari'},
        {name: 'MDH'},
        {name: 'MIT'},
        {name: 'FER'},
      ]);
    });
};
