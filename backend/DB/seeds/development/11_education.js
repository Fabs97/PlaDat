
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('education').del()
    .then(function () {
      // Inserts seed entries
      return knex('education').insert([
        {
          major_id: 1,
          degree_id: 2,
          institution_id: 3
        },
        {
          major_id: 2,
          degree_id: 1,
          institution_id: 3
        },
        {
          major_id: 3,
          degree_id: 1,
          institution_id: 2
        }
      ]);
    })
};