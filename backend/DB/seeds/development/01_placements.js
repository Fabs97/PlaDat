
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placements').del()
    .then(function () {
      // Inserts seed entries
      return knex('placements').insert([
        {position: 'Frontend Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'Backend Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'Fullstack Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'Project Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'Quality Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'DevOps', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'Designer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'Accountant', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'Business Analyst', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {position: 'IT Project Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"}
      ]);
    });
};
