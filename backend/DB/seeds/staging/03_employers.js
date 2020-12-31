
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('employer').del()
    .then(async function () {
      
      let domains = await knex('domain_of_activity')
        .select('id')

      let locations = await knex('location')
        .select('id')
        .limit(7)
        
      
      let employers = [
        {name: "Google", description: 'Friendly work place'},
        {name: "Amazon", description: 'Friendly work place'},
        {name: "Instagram", description: 'Friendly work place'},
        {name: "Pinterest", description: 'Friendly work place'},
        {name: "Facebook", description: 'Friendly work place'},
        {name: "Reply", description: 'Friendly work place'},
        {name: "Oracle", description: 'Friendly work place'}
      ]

      for(let i=0; i<employers.length; i++){
        employers[i].domain_of_activity_id = domains[9].id;
        employers[i].location_id = locations[i].id;
      }
      return knex('employer').insert(employers)
    });
};
