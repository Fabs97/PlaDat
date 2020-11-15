
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('institutions').del()
    .then(function () {
      // Inserts seed entries
      return knex('institutions').insert([
        {id: 1, name: 'Politecnico di Milano'},
        {id: 2, name: 'Politecnico di Torino'},
        {id: 3, name: 'Universita di Napoli'},
        {id: 4, name: 'Universita di Bari'},
        {id: 5, name: 'MDH'},
        {id: 6, name: 'MIT'},
        {id: 7, name: 'FER'},
      ]);
    });
};
