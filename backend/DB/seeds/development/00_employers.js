
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('employer').del()
    .then(function () {
      // Inserts seed entries
      return knex('employer').insert([
        {name: "Google", description: 'Friendly work place'},
        {name: "Amazon", description: 'Friendly work place'},
        {name: "Instagram", description: 'Friendly work place'},
        {name: "Pinterest", description: 'Friendly work place'},
        {name: "Facebook", description: 'Friendly work place'},
        {name: "Reply", description: 'Friendly work place'},
        {name: "Oracle", description: 'Friendly work place'}
      ])
    });
};
