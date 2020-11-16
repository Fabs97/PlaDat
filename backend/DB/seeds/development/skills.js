
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('skills').del()
    .then(function () {
      // Inserts seed entries
      return knex('skills').insert([
        {id: 1, name: 'JavaScript', type: "TECH"},
        {id: 2, name: 'Java', type: "TECH"},
        {id: 3, name: 'C++', type: "TECH"},
        {id: 4, name: 'CSS', type: "TECH"},
        {id: 5, name: 'PHP', type: "TECH"},
        {id: 6, name: 'NPM', type: "TECH"},
        {id: 7, name: 'Python', type: "TECH"},
        {id: 8, name: 'TypeScript', type: "TECH"},
        {id: 9, name: 'Vim', type: "TECH"},
        {id: 10, name: 'GitHub', type: "TECH"},
        {id: 11, name: 'Docker', type: "TECH"},
        {id: 12, name: 'Jenkins', type: "TECH"},
        {id: 13, name: 'Flutter', type: "TECH"},
        {id: 14, name: 'Vue.js', type: "TECH"},
        {id: 15, name: 'Angular.js', type: "TECH"},
        {id: 16, name: 'React.js', type: "TECH"},
        {id: 17, name: 'Time Management', type: "SOFT"},
        {id: 18, name: 'Team Management', type: "SOFT"},
        {id: 19, name: 'Communications', type: "SOFT"},
        {id: 20, name: 'Project Management', type: "SOFT"},
        {id: 21, name: 'Public Speaking', type: "SOFT"},
        {id: 22, name: 'Anger Management', type: "SOFT"},
      ]);
    });
};
