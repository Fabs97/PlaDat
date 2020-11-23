
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placements').del()
    .then(async function () {
      let employers = await knex('employer')
        .select('id', 'name')
        .whereIn('name', ['Google', 'Amazon', 'Instagram', 'Pinterest', 'Facebook', 'Reply', 'Oracle']);
      // Inserts seed entries
      return knex('placements').insert([
        {position: 'Frontend Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[0].id},
        {position: 'Backend Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[0].id},
        {position: 'Fullstack Developer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[0].id},
        {position: 'Project Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[1].id},
        {position: 'Quality Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[1].id},
        {position: 'DevOps', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[2].id},
        {position: 'Designer', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[2].id},
        {position: 'Accountant', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[3].id},
        {position: 'Business Analyst', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[4].id},
        {position: 'IT Project Manager', working_hours: "25", start_period: "2021/01/30", end_period: "2021/06/30", salary: "800", description_role: "Interesting role to improve personal skills", employer_id: employers[5].id}
      ]);
    });
};
