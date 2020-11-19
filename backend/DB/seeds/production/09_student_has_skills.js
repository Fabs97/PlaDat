
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student_has_skills').del()
    .then(function () {
      // Inserts seed entries
      return knex('student_has_skills').insert([
        {student_id: 1, skill_id: 1},
        {student_id: 1, skill_id: 2},
        {student_id: 1, skill_id: 17},
        {student_id: 1, skill_id: 18},
        {student_id: 2, skill_id: 2},
        {student_id: 2, skill_id: 3},
        {student_id: 2, skill_id: 18},
        {student_id: 3, skill_id: 2},
        {student_id: 3, skill_id: 3},
        {student_id: 3, skill_id: 4},
        {student_id: 3, skill_id: 19},
        {student_id: 3, skill_id: 20},
        {student_id: 4, skill_id: 4},
        {student_id: 4, skill_id: 22},
        {student_id: 5, skill_id: 5},
        {student_id: 5, skill_id: 6},
        {student_id: 5, skill_id: 7},
        {student_id: 5, skill_id: 21},
        {student_id: 5, skill_id: 22},
        {student_id: 6, skill_id: 8},
        {student_id: 6, skill_id: 18},
        {student_id: 7, skill_id: 9},
        {student_id: 7, skill_id: 10},
        {student_id: 7, skill_id: 13},
        {student_id: 8, skill_id: 3},
        {student_id: 8, skill_id: 20},
        {student_id: 9, skill_id: 6},
        {student_id: 9, skill_id: 8},
        {student_id: 9, skill_id: 17},
        {student_id: 9, skill_id: 18},
        {student_id: 10, skill_id: 11},
        {student_id: 10, skill_id: 12},
        {student_id: 10, skill_id: 13},
        {student_id: 10, skill_id: 17},
        {student_id: 10, skill_id: 18}
        
      ]);
    });
};

