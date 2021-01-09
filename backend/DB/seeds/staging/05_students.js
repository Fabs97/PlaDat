exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student').del()
    .then(async function () {

      let users = await knex('registration')
      .select('id')
      .where('type', 'STUDENT');

      let locations = await knex('location')
        .select('id')
        .whereIn('city', ['Milan', 'Rome', 'Naples', 'Helsinki', 'New York', 'Los Angeles']);

      // Inserts seed entries

      // LOCATION MISSING
      // WORK EXPERIENCE MISSING
      // delete email, delete password
      return knex('student').insert([
        {name: "Alice #TEST", surname: "Casali", description: "Engineer student", user_id: users[0].id, location_id: locations[0].id},
        {name: "Fabrizio #TEST", surname: "Siciliano", description: "Engineer student" , user_id: users[1].id, location_id: locations[4].id},
        {name: "Anna #TEST", surname: "Bergamsco", description: "Engineer student" , user_id: users[2].id, location_id: locations[3].id},
        {name: "Aida #TEST", surname: "Opirlesc", description: "Engineer student", user_id: users[3].id, location_id: locations[1].id },
        {name: "Andela #TEST", surname: "Zoric", description: "Engineer student" , user_id: users[4].id, location_id: locations[5].id},
        {name: "William #TEST", surname: "Nordberg", description: "Engineer student" , user_id: users[5].id, location_id: locations[2].id},
        {name: "Bassam #TEST", surname: "Zabad", description: "Engineer student" , user_id: users[6].id, location_id: locations[4].id},
        {name: "Jhonny #TEST", surname: "Depp", description: "Engineer student" , user_id: users[7].id, location_id: locations[0].id},
        {name: "Maryl #TEST", surname: "Streep", description: "Engineer student" , user_id: users[8].id, location_id: locations[4].id},
        {name: "Freddy #TEST", surname: "Mercury", description: "Engineer student" , user_id: users[9].id, location_id: locations[3].id},
      ]);
    });
};