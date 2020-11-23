exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placement_has_major').del()
    .then(function () {
      let placements = await knex('placements')
        .select('id', 'position')
        .whereIn('position', ['Frontend Developer', 'Backend Developer', 'Fullstack Developer', 'Project Manager', 'Quality Manager', 'DevOps', 'Designer', 'Accountant', 'Business Analyst', 'IT Project Manager']);
      let majors = await knex('majors')
        .select('id', 'name')
        .whereIn('name', ['Computer Science and Engineering', 'Management Engineering', 'Architecture', 'CyberSecurity Engineering', 'Geolocalization Engineering', 'Philosophy', 'Natural History', 'Polical Sciences', 'History', 'Meccanical Engineering']);
      // Inserts seed entries
      return knex('placement_has_major').insert([
        {placement_id: placements[1].id, major_id: majors[0].id},
        {placement_id: placements[2].id, major_id: majors[0].id},
        {placement_id: placements[3].id, major_id: majors[1].id},
        {placement_id: placements[4].id, major_id: majors[1].id},
        {placement_id: placements[5].id, major_id: majors[2].id},
        {placement_id: placements[6].id, major_id: majors[3].id},
        {placement_id: placements[7].id, major_id: majors[4].id},
        {placement_id: placements[8].id, major_id: majors[5].id},
        {placement_id: placements[9].id, major_id: majors[6].id},
        {placement_id: placements[0].id, major_id: majors[6].id}
      ]);
    });
};