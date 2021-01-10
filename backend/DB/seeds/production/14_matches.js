
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student_has_placement').del()
    .then(async function () {
      // Inserts seed entries
      let students = await knex('student')
        .select('id', 'name')
        .whereIn('name', ['Alice #TEST','Fabrizio #TEST','Anna #TEST','Aida #TEST','Andela #TEST','William #TEST','Bassam #TEST','Jhonny #TEST','Maryl #TEST','Freddy #TEST']);
        let placements = await knex('placements')
          .select('id', 'position')
          .whereIn('position', ['Frontend Developer', 'Backend Developer', 'Fullstack Developer', 'Project Manager', 'Quality Manager', 'DevOps', 'Designer', 'Accountant', 'Business Analyst', 'IT Project Manager']);
        return knex('student_has_placement').insert([
        {placement_id: placements[0].id, student_id: students[0].id, student_accept: true, placement_accept: true, status: 'ACCEPTED'},
        {placement_id: placements[0].id, student_id: students[1].id, student_accept: true, placement_accept: true, status: 'ACCEPTED'},
        {placement_id: placements[0].id, student_id: students[2].id, student_accept: true, placement_accept: true, status: 'ACCEPTED'},
        {placement_id: placements[1].id, student_id: students[0].id, student_accept: true, placement_accept: true, status: 'ACCEPTED'},
        {placement_id: placements[2].id, student_id: students[2].id, student_accept: true, placement_accept: true, status: 'ACCEPTED'},
        {placement_id: placements[3].id, student_id: students[3].id, student_accept: true, placement_accept: false, status: 'PENDING'},
        {placement_id: placements[3].id, student_id: students[2].id, student_accept: true, placement_accept: false, status: 'PENDING'},
        {placement_id: placements[1].id, student_id: students[2].id, student_accept: false, placement_accept: true, status: 'PENDING'},
        {placement_id: placements[2].id, student_id: students[1].id, student_accept: false, placement_accept: true, status: 'PENDING'}
       
      ]);
    });
};

