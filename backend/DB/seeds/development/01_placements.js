
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placements').del()
    .then(function () {
      // Inserts seed entries
      return knex('placements').insert([
        {id: 1, position: 'Frontend Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 2, position: 'Backend Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 3, position: 'Fullstack Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 4, position: 'Project Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 5, position: 'Quality Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 6, position: 'DevOps', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 7, position: 'Designer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 8, position: 'Accountant', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 9, position: 'Business Analyst', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"},
        {id: 10, position: 'IT Project Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills"}
      ]);
    });
};
