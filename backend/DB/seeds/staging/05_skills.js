
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('skill').del()
    .then(function () {
      // Inserts seed entries
      return knex('skill').insert([
        {name: 'JavaScript', type: "TECH"},
        {name: 'Java', type: "TECH"},
        {name: 'C++', type: "TECH"},
        {name: 'CSS', type: "TECH"},
        {name: 'PHP', type: "TECH"},
        {name: 'NPM', type: "TECH"},
        {name: 'Python', type: "TECH"},
        {name: 'TypeScript', type: "TECH"},
        {name: 'Vim', type: "TECH"},
        {name: 'GitHub', type: "TECH"},
        {name: 'Docker', type: "TECH"},
        {name: 'Jenkins', type: "TECH"},
        {name: 'Flutter', type: "TECH"},
        {name: 'Vue.js', type: "TECH"},
        {name: 'Angular.js', type: "TECH"},
        {name: 'React.js', type: "TECH"},
        {name: 'Time Management', type: "SOFT"},
        {name: 'Team Management', type: "SOFT"},
        {name: 'Communications', type: "SOFT"},
        {name: 'Project Management', type: "SOFT"},
        {name: 'Public Speaking', type: "SOFT"},
        {name: 'Anger Management', type: "SOFT"},
      ]);
    });
};
