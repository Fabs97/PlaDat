
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student_has_skills').del()
    .then(async function () {
      // Inserts seed entries
      let students = await knex('student')
        .select('id', 'name')
        .whereIn('name', ['Alice #TEST','Fabrizio #TEST','Anna #TEST','Aida #TEST','Andela #TEST','William #TEST','Bassam #TEST','Jhonny #TEST','Maryl #TEST','Freddy #TEST']);
      let skills = await knex('skill')
        .select('id', 'name')
        .whereIn('name', ['JavaScript', 'Java', 'C++', 'CSS', 'PHP', 'NPM', 'Python', 'TypeScript', 'Vim', 'GitHub', 'Docker', 'Jenkins', 'Flutter', 'Vue.js', 'Angular.js', 'React.js', 'Time Management', 'Team Management', 'Communications', 'Project Management', 'Public Speaking', 'Anger Management', 'Problem-solving', 'Care for details','Punctuality', 'Open mindness', 'Flexibility']);
      return knex('student_has_skills').insert([
        {student_id: students[0].id, skill_id: skills[0].id},
        {student_id: students[0].id, skill_id: skills[1].id},
        {student_id: students[0].id, skill_id: skills[2].id},
        {student_id: students[0].id, skill_id: skills[3].id},
        {student_id: students[0].id, skill_id: skills[16].id},
        {student_id: students[0].id, skill_id: skills[17].id},
        {student_id: students[0].id, skill_id: skills[18].id},
        {student_id: students[1].id, skill_id: skills[2].id},
        {student_id: students[1].id, skill_id: skills[3].id},
        {student_id: students[1].id, skill_id: skills[4].id},
        {student_id: students[1].id, skill_id: skills[5].id},
        {student_id: students[1].id, skill_id: skills[6].id},
        {student_id: students[1].id, skill_id: skills[23].id},
        {student_id: students[1].id, skill_id: skills[24].id},
        {student_id: students[2].id, skill_id: skills[5].id},
        {student_id: students[2].id, skill_id: skills[6].id},
        {student_id: students[2].id, skill_id: skills[7].id},
        {student_id: students[2].id, skill_id: skills[8].id},
        {student_id: students[2].id, skill_id: skills[19].id},
        {student_id: students[2].id, skill_id: skills[20].id},
        {student_id: students[2].id, skill_id: skills[21].id},
        {student_id: students[2].id, skill_id: skills[22].id},
        {student_id: students[2].id, skill_id: skills[23].id},
        {student_id: students[3].id, skill_id: skills[1].id},
        {student_id: students[3].id, skill_id: skills[2].id},
        {student_id: students[3].id, skill_id: skills[3].id},
        {student_id: students[3].id, skill_id: skills[17].id},
        {student_id: students[3].id, skill_id: skills[18].id},
        {student_id: students[3].id, skill_id: skills[19].id},
        {student_id: students[4].id, skill_id: skills[6].id},
        {student_id: students[4].id, skill_id: skills[7].id},
        {student_id: students[4].id, skill_id: skills[8].id},
        {student_id: students[4].id, skill_id: skills[21].id},
        {student_id: students[4].id, skill_id: skills[22].id},
        {student_id: students[4].id, skill_id: skills[23].id},
        {student_id: students[4].id, skill_id: skills[24].id},
        {student_id: students[5].id, skill_id: skills[0].id},
        {student_id: students[5].id, skill_id: skills[2].id},
        {student_id: students[5].id, skill_id: skills[4].id},
        {student_id: students[5].id, skill_id: skills[6].id},
        {student_id: students[5].id, skill_id: skills[8].id},
        {student_id: students[5].id, skill_id: skills[17].id},
        {student_id: students[5].id, skill_id: skills[19].id},
        {student_id: students[5].id, skill_id: skills[21].id},
        {student_id: students[5].id, skill_id: skills[23].id},
        {student_id: students[6].id, skill_id: skills[0].id},
        {student_id: students[6].id, skill_id: skills[1].id},
        {student_id: students[6].id, skill_id: skills[2].id},
        {student_id: students[6].id, skill_id: skills[17].id},
        {student_id: students[6].id, skill_id: skills[18].id},
        {student_id: students[6].id, skill_id: skills[22].id},
        {student_id: students[6].id, skill_id: skills[23].id},
        {student_id: students[7].id, skill_id: skills[3].id},
        {student_id: students[7].id, skill_id: skills[4].id},
        {student_id: students[7].id, skill_id: skills[5].id},
        {student_id: students[7].id, skill_id: skills[6].id},
        {student_id: students[7].id, skill_id: skills[7].id},
        {student_id: students[7].id, skill_id: skills[8].id},
        {student_id: students[7].id, skill_id: skills[20].id},
        {student_id: students[8].id, skill_id: skills[1].id},
        {student_id: students[8].id, skill_id: skills[2].id},
        {student_id: students[8].id, skill_id: skills[6].id},
        {student_id: students[8].id, skill_id: skills[7].id},
        {student_id: students[8].id, skill_id: skills[16].id},
        {student_id: students[8].id, skill_id: skills[19].id},
        {student_id: students[8].id, skill_id: skills[20].id},
        {student_id: students[8].id, skill_id: skills[21].id},
        {student_id: students[8].id, skill_id: skills[24].id},
        {student_id: students[9].id, skill_id: skills[2].id},
        {student_id: students[9].id, skill_id: skills[3].id},
        {student_id: students[9].id, skill_id: skills[16].id},
        {student_id: students[9].id, skill_id: skills[17].id},
        {student_id: students[9].id, skill_id: skills[18].id},
        {student_id: students[9].id, skill_id: skills[21].id},
        {student_id: students[9].id, skill_id: skills[22].id}
      ]);
    });
};

