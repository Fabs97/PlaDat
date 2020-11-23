exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('placement_has_institution').del()
    .then(function () {
      // Inserts seed entries
      let placements = await knex('placements')
        .select('id', 'position')
        .whereIn('position', ['Frontend Developer', 'Backend Developer', 'Fullstack Developer', 'Project Manager', 'Quality Manager', 'DevOps', 'Designer', 'Accountant', 'Business Analyst', 'IT Project Manager']);
      let institutions = await knex('institutions')
        .select('id', 'name')
        .whereIn('name', ['Politecnico di Milano', 'Politecnico di Torino', 'Universita di Napoli', 'Universita di Bari', 'MDH', 'MIT', 'FER']);

      return knex('placement_has_institution').insert([
        {placement_id: placements[1].id, institution_id: institutions[0].id},
        {placement_id: placements[2].id, institution_id: institutions[0].id},
        {placement_id: placements[3].id, institution_id: institutions[1].id},
        {placement_id: placements[4].id, institution_id: institutions[1].id},
        {placement_id: placements[5].id, institution_id: institutions[2].id},
        {placement_id: placements[6].id, institution_id: institutions[3].id},
        {placement_id: placements[7].id, institution_id: institutions[4].id},
        {placement_id: placements[8].id, institution_id: institutions[5].id},
        {placement_id: placements[9].id, institution_id: institutions[6].id},
        {placement_id: placements[0].id, institution_id: institutions[6].id}
      ]);
    });
};
