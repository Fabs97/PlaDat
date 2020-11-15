exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placement_has_institution').del()
    .then(function () {
      // Inserts seed entries
      return knex('placement_has_institution').insert([
        {placement_id: 1, institution_id: 1},
        {placement_id: 2, institution_id: 1},
        {placement_id: 3, institution_id: 2},
        {placement_id: 4, institution_id: 2},
        {placement_id: 5, institution_id: 3},
        {placement_id: 6, institution_id: 4},
        {placement_id: 7, institution_id: 5},
        {placement_id: 8, institution_id: 6},
        {placement_id: 9, institution_id: 7},
        {placement_id: 10, institution_id: 7}
      ]);
    });
};
