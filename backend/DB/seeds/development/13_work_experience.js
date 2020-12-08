
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('work').del()
    .then(async function () {
      let students = await knex('student')
        .select('id', 'name')
        .whereIn('name', ['Alice #TEST','Fabrizio #TEST','Anna #TEST','Aida #TEST','Andela #TEST','William #TEST','Bassam #TEST','Jhonny #TEST','Maryl #TEST','Freddy #TEST']);
      
      // Inserts seed entries
      return knex('work').insert([
        {
          company_name: "Google",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: students[0].id
        },
        {
          company_name: "Facebook",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: students[1].id
        },
        {
          company_name: "Airbnb",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: students[2].id
        },
        {
          company_name: "Amazon",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: students[3].id
        },
        {
          company_name: "Netflix",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: students[4].id
        },
        {
          company_name: "Spotify",
          position: "Junior Developer",
          description: "Difficult job",
          work_period: "September 2020 - October 2021",
          student_id: students[5].id
        }
      ]);
    })
};