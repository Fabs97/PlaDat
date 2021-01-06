exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student').del()
    .then(async function () {

      let users = await knex('registration')
      .select('id')
      .where('type', 'STUDENT');
      // Inserts seed entries

      // LOCATION MISSING
      // WORK EXPERIENCE MISSING
      // delete email, delete password
      return knex('student').insert([
        {name: "Alice #TEST", surname: "Casali", email: "abcd@gmail.com", password: "1234", description: "Engineer student", user_id: users[0].id},
        {name: "Fabrizio #TEST", surname: "Siciliano", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[1].id},
        {name: "Anna #TEST", surname: "Bergamsco", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[2].id},
        {name: "Aida #TEST", surname: "Opirlesc", email: "abcd@gmail.com", password: "1234", description: "Engineer student", user_id: users[3].id },
        {name: "Andela #TEST", surname: "Zoric", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[4].id},
        {name: "William #TEST", surname: "Nordberg", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[5].id},
        {name: "Bassam #TEST", surname: "Zabad", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[6].id},
        {name: "Jhonny #TEST", surname: "Depp", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[7].id},
        {name: "Maryl #TEST", surname: "Streep", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[8].id},
        {name: "Freddy #TEST", surname: "Mercury", email: "abcd@gmail.com", password: "1234", description: "Engineer student" , user_id: users[9].id},
      ]);
    });
};