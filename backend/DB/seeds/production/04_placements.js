
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placements').del()
    .then(async function () {
      let employers = await knex('employer')
        .select('id', 'name')
        .whereIn('name', ['Google', 'Amazon', 'Instagram', 'Pinterest', 'Facebook', 'Reply', 'Oracle']);
      // Inserts seed entries
      return knex('placements').insert([
        {position: 'Frontend Developer', employment_type: "FULL_TIME", start_period: "2021/01/30", end_period: "2021/06/30", salary: "14000", description_role: "Interesting role to improve personal skills", location_id: locations[1].id, employer_id: employers[0].id, status: 'OPEN'},
        {position: 'Backend Developer', employment_type: "FULL_TIME", start_period: "2021/01/30", end_period: "2021/06/30", salary: "13000", description_role: "Interesting role to improve personal skills", location_id: locations[1].id, employer_id: employers[0].id, status: 'OPEN'},
        {position: 'Fullstack Developer', employment_type: "PART_TIME", start_period: "2021/01/30", end_period: "2021/06/30", salary: "10000", description_role: "Interesting role to improve personal skills", location_id: locations[1].id, employer_id: employers[0].id, status: 'OPEN'},
        {position: 'Project Manager', employment_type: "PART_TIME", start_period: "2021/01/30", end_period: "2021/06/30", salary: "13500", description_role: "Interesting role to improve personal skills", location_id: locations[1].id, employer_id: employers[1].id, status: 'OPEN'},
        {position: 'Quality Manager', employment_type: "PART_TIME", start_period: "2021/01/30", end_period: "2021/06/30", salary: "20000", description_role: "Interesting role to improve personal skills", location_id: locations[2].id, employer_id: employers[1].id, status: 'OPEN'},
        {position: 'DevOps', employment_type: "INTERNSHIP", start_period: "2021/01/30", end_period: "2021/06/30", salary: "17500", description_role: "Interesting role to improve personal skills", location_id: locations[2].id, employer_id: employers[2].id, status: 'OPEN'},
        {position: 'Designer', employment_type: "INTERNSHIP", start_period: "2021/01/30", end_period: "2021/06/30", salary: "18500", description_role: "Interesting role to improve personal skills", location_id: locations[2].id, employer_id: employers[2].id, status: 'OPEN'},
        {position: 'Accountant', employment_type: "INTERNSHIP", start_period: "2021/01/30", end_period: "2021/06/30", salary: "18000", description_role: "Interesting role to improve personal skills", location_id: locations[2].id, employer_id: employers[3].id, status: 'OPEN'},
        {position: 'Business Analyst', employment_type: "CONTRACT", start_period: "2021/01/30", end_period: "2021/06/30", salary: "16000", description_role: "Interesting role to improve personal skills", location_id: locations[3].id, employer_id: employers[4].id, status: 'OPEN'},
        {position: 'IT Project Manager', employment_type: "CONTRACT", start_period: "2021/01/30", end_period: "2021/06/30", salary: "15000", description_role: "Interesting role to improve personal skills", location_id: locations[3].id, employer_id: employers[5].id, status: 'OPEN'}
      ]);
    });
};
