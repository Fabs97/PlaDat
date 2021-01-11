
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student_has_work').del()
    .then(async function () {
      // Inserts seed entries
      let students = await knex('student')
        .select('id', 'name')
        .whereIn('name', ['Alice #TEST','Fabrizio #TEST','Anna #TEST','Aida #TEST','Andela #TEST','William #TEST','Bassam #TEST','Jhonny #TEST','Maryl #TEST','Freddy #TEST']);
      let works = await knex('work')
        .select('id')
        .limit(6)
      return knex('student_has_work').insert([
        {student_id: students[0].id, work_id: works[0].id},
        {student_id: students[2].id, work_id: works[1].id},
        {student_id: students[3].id, work_id: works[2].id},
        {student_id: students[4].id, work_id: works[3].id},
        {student_id: students[8].id, work_id: works[4].id},
        {student_id: students[9].id, work_id: works[5].id}
      ]);
    });
};
