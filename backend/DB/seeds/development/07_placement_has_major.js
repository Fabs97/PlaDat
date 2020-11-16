exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placement_has_major').del()
    .then(function () {
      // Inserts seed entries
      return knex('placement_has_major').insert([
        {placement_id: 1, major_id: 1},
        {placement_id: 2, major_id: 1},
        {placement_id: 3, major_id: 2},
        {placement_id: 4, major_id: 2},
        {placement_id: 5, major_id: 3},
        {placement_id: 6, major_id: 4},
        {placement_id: 7, major_id: 5},
        {placement_id: 8, major_id: 6},
        {placement_id: 9, major_id: 7},
        {placement_id: 10, major_id: 7}
      ]);
    });
};