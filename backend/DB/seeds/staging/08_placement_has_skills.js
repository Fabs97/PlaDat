exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placement_has_skills').del()
    .then(function () {
      // Inserts seed entries
      return knex('placement_has_skills').insert([
        {placement_id: 1, skill_id: 1},
        {placement_id: 1, skill_id: 2},
        {placement_id: 1, skill_id: 17},
        {placement_id: 1, skill_id: 18},
        {placement_id: 2, skill_id: 2},
        {placement_id: 2, skill_id: 3},
        {placement_id: 2, skill_id: 19},
        {placement_id: 3, skill_id: 3},
        {placement_id: 3, skill_id: 4},
        {placement_id: 3, skill_id: 19},
        {placement_id: 3, skill_id: 20},
        {placement_id: 4, skill_id: 3},
        {placement_id: 4, skill_id: 4},
        {placement_id: 4, skill_id: 20},
        {placement_id: 5, skill_id: 4},
        {placement_id: 5, skill_id: 5},
        {placement_id: 5, skill_id: 6},
        {placement_id: 5, skill_id: 21},
        {placement_id: 5, skill_id: 22},
        {placement_id: 6, skill_id: 5},
        {placement_id: 6, skill_id: 6},
        {placement_id: 6, skill_id: 18},
        {placement_id: 7, skill_id: 7},
        {placement_id: 7, skill_id: 8},
        {placement_id: 7, skill_id: 19},
        {placement_id: 7, skill_id: 2},
        {placement_id: 8, skill_id: 2},
        {placement_id: 8, skill_id: 1},
        {placement_id: 9, skill_id: 8},
        {placement_id: 9, skill_id: 9},
        {placement_id: 9, skill_id: 17},
        {placement_id: 9, skill_id: 18},
        {placement_id: 9, skill_id: 19},
        {placement_id: 10, skill_id: 7},
        {placement_id: 10, skill_id: 8},
        {placement_id: 10, skill_id: 20},
      ]);
    });
};

