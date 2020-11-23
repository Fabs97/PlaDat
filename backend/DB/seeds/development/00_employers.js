
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('employer').del()
    .then(function () {
      // Inserts seed entries
      return knex('employer').insert([
        {name: "Google", location: 'Zurich', urllogo: 'https://source.unsplash.com/random'},
        {name: "Amazon", location: 'Luxembourg', urllogo: 'https://source.unsplash.com/random'},
        {name: "Instagram", location: 'Dublin', urllogo: 'https://source.unsplash.com/random'},
        {name: "Pinterest", location: 'Zurich', urllogo: 'https://source.unsplash.com/random'},
        {name: "Facebook", location: 'Dublin', urllogo: 'https://source.unsplash.com/random'},
        {name: "Reply", location: 'Milano', urllogo: 'https://source.unsplash.com/random'},
        {name: "Oracle", location: 'Silicon Valley', urllogo: 'https://source.unsplash.com/random'},
      ])
    });
};
