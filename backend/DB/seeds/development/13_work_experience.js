
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('education').del()
    .then(function () {
      // Inserts seed entries
      return knex('education').insert([
        {
          company_name: "Google",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: 1
        },
        {
          company_name: "Facebook",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: 2
        },
        {
          company_name: "Airbnb",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: 3
        }
      ]);
    })
};