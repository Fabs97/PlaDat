
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('employer').del()
    .then(async function () {
      
      let domains = await knex('domain_of_activity')
        .select('id')

      let locations = await knex('location')
        .select('id')
        .limit(7)

      let users = await knex('registration')
        .select('id')
        .where('type', 'EMPLOYER');
    
      // Inserts seed entries
      let employers = [
        {name: "Google",  description: 'Friendly work place', user_id: users[0].id},
        {name: "Amazon",  description: 'Friendly work place', user_id: users[1].id},
        {name: "Instagram",  description: 'Friendly work place', user_id: users[2].id},
        {name: "Pinterest",  description: 'Friendly work place', user_id: users[3].id},
        {name: "Facebook",  description: 'Friendly work place', user_id: users[4].id},
        {name: "Reply",  description: 'Friendly work place', user_id: users[5].id},
        {name: "Oracle",  description: 'Friendly work place', user_id: users[6].id},
      ];

      for(let i=0; i<employers.length; i++){
        employers[i].domain_of_activity_id = domains[9].id;
        employers[i].location_id = locations[i].id;
      }
      return knex('employer').insert(employers)
    });
};
