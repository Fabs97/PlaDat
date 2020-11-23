exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placement_has_skills').del()
    .then(async function () {
      // Inserts seed entries
      let placements = await knex('placements')
        .select('id', 'position')
        .whereIn('position', ['Frontend Developer', 'Backend Developer', 'Fullstack Developer', 'Project Manager', 'Quality Manager', 'DevOps', 'Designer', 'Accountant', 'Business Analyst', 'IT Project Manager']);
      let skills = await knex('skill')
        .select('id', 'name')
        .whereIn('name', ['JavaScript', 'Java', 'C++', 'CSS', 'PHP', 'NPM', 'Python', 'TypeScript', 'Vim', 'GitHub', 'Docker', 'Jenkins', 'Flutter', 'Vue.js', 'Angular.js', 'React.js', 'Time Management', 'Team Management', 'Communications', 'Project Management', 'Public Speaking', 'Anger Management']);
      return knex('placement_has_skills').insert([
        {placement_id: placements[0].id, skill_id: skills[0].id},
        {placement_id: placements[0].id, skill_id: skills[1].id},
        {placement_id: placements[0].id, skill_id: skills[16].id},
        {placement_id: placements[0].id, skill_id: skills[17].id},
        {placement_id: placements[1].id, skill_id: skills[1].id},
        {placement_id: placements[1].id, skill_id: skills[2].id},
        {placement_id: placements[1].id, skill_id: skills[18].id},
        {placement_id: placements[2].id, skill_id: skills[2].id},
        {placement_id: placements[2].id, skill_id: skills[3].id},
        {placement_id: placements[2].id, skill_id: skills[18].id},
        {placement_id: placements[2].id, skill_id: skills[19].id},
        {placement_id: placements[3].id, skill_id: skills[2].id},
        {placement_id: placements[3].id, skill_id: skills[3].id},
        {placement_id: placements[3].id, skill_id: skills[19].id},
        {placement_id: placements[4].id, skill_id: skills[3].id},
        {placement_id: placements[4].id, skill_id: skills[4].id},
        {placement_id: placements[4].id, skill_id: skills[5].id},
        {placement_id: placements[4].id, skill_id: skills[20].id},
        {placement_id: placements[4].id, skill_id: skills[21].id},
        {placement_id: placements[5].id, skill_id: skills[4].id},
        {placement_id: placements[5].id, skill_id: skills[5].id},
        {placement_id: placements[5].id, skill_id: skills[17].id},
        {placement_id: placements[6].id, skill_id: skills[6].id},
        {placement_id: placements[6].id, skill_id: skills[7].id},
        {placement_id: placements[6].id, skill_id: skills[18].id},
        {placement_id: placements[6].id, skill_id: skills[1].id},
        {placement_id: placements[7].id, skill_id: skills[1].id},
        {placement_id: placements[7].id, skill_id: skills[0].id},
        {placement_id: placements[8].id, skill_id: skills[7].id},
        {placement_id: placements[8].id, skill_id: skills[8].id},
        {placement_id: placements[8].id, skill_id: skills[16].id},
        {placement_id: placements[8].id, skill_id: skills[17].id},
        {placement_id: placements[8].id, skill_id: skills[18].id},
        {placement_id: placements[9].id, skill_id: skills[6].id},
        {placement_id: placements[9].id, skill_id: skills[7].id},
        {placement_id: placements[9].id, skill_id: skills[19].id},
      ]);
    });
};

