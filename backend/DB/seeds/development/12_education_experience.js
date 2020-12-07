
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('education').del()
    .then(function () {
      // Inserts seed entries
      return knex('education').insert([
        {
          student_id: 1,
          education_id: 2,
          description: "Difficult Master",
          period: "September 2020 - October 2021"
        },
        {
          student_id: 2,
          education_id: 1,
          description: "Difficult Master",
          period: "September 2020 - October 2021"
        },
        {
          student_id: 3,
          education_id: 2,
          description: "Difficult Master",
          period: "September 2020 - October 2021"
        }
      ]);
    })
};