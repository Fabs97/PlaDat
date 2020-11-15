
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('majors').del()
    .then(function () {
      // Inserts seed entries
      return knex('majors').insert([
        {id: 1, name: 'Computer Science and Engineering'},
        {id: 2, name: 'Management Engineering'},
        {id: 3, name: 'Architecture'},
        {id: 4, name: 'CyberSecurity Engineering'},
        {id: 5, name: 'Geolocalization Engineering'},
        {id: 6, name: 'Philosophy'},
        {id: 7, name: 'Natural History'},
        {id: 8, name: 'Polical Sciences'},
        {id: 9, name: 'History'},
        {id: 10, name: 'Meccanical Engineering'},
      ]);
    });
};
