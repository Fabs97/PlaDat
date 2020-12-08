
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student_has_education').del()
    .then( async function () {

      let students = await knex('student')
        .select('id', 'name')
        .whereIn('name', ['Alice #TEST','Fabrizio #TEST','Anna #TEST','Aida #TEST','Andela #TEST','William #TEST','Bassam #TEST','Jhonny #TEST','Maryl #TEST','Freddy #TEST']);
      
      let education = await knex('education')
        .select('id')
        .limit(3)

      let experiences = [];
      for (let i=0; i<students.length; i++) {
        experiences.push({
          student_id: students[i].id,
          education_id: education[i%3].id,
          description: "Difficult study",
          period: "September 2020 - October 2021"
        })
      }

      // Inserts seed entries
      return knex('student_has_education').insert(experiences);
    })
};