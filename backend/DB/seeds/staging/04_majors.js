
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('majors').del()
    .then(function () {
      // Inserts seed entries
      return knex('majors').insert([
        {name: 'Computer Science and Engineering'},
        {name: 'Management Engineering'},
        {name: 'Architecture'},
        {name: 'CyberSecurity Engineering'},
        {name: 'Geolocalization Engineering'},
        {name: 'Philosophy'},
        {name: 'Natural History'},
        {name: 'Polical Sciences'},
        {name: 'History'},
        {name: 'Meccanical Engineering'},
      ]);
    });
};
