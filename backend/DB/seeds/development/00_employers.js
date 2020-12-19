
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('employer').del()
    .then(async function () {

      let users = await knex('registration')
        .select('id')
        .where('type', 'EMPLOYER');
    
      // Inserts seed entries
      return knex('employer').insert([
        {name: "Google", location: 'Zurich', urllogo: 'https://source.unsplash.com/random', user_id: users[0].id},
        {name: "Amazon", location: 'Luxembourg', urllogo: 'https://source.unsplash.com/random', user_id: users[1].id},
        {name: "Instagram", location: 'Dublin', urllogo: 'https://source.unsplash.com/random', user_id: users[2].id},
        {name: "Pinterest", location: 'Zurich', urllogo: 'https://source.unsplash.com/random', user_id: users[3].id},
        {name: "Facebook", location: 'Dublin', urllogo: 'https://source.unsplash.com/random', user_id: users[4].id},
        {name: "Reply", location: 'Milano', urllogo: 'https://source.unsplash.com/random', user_id: users[5].id},
        {name: "Oracle", location: 'Silicon Valley', urllogo: 'https://source.unsplash.com/random', user_id: users[6].id},
      ])
    });
};
