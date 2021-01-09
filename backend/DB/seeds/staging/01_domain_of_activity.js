
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('domain_of_activity').del()
    .then(function () {
      // Inserts seed entries

      // Source of the data: NACE Rev. 2, Statistical classification of economic activities in the European Community, Eurostat

      return knex('domain_of_activity').insert([
        {name: 'Agriculture, forestry and fishing'},
        {name: 'Mining and quarrying'},
        {name: 'Manufacturing'},
        {name: 'Energy and utilities'},
        {name: 'Water supply and waste management'},
        {name: 'Construction'},
        {name: 'Wholesal, retail and repairs'},
        {name: 'Accommodation and food services'},
        {name: 'Transportation and storage'},
        {name: 'Information and communication'},
        {name: 'Financial and insurance'},
        {name: 'Real estate'},
        {name: 'Professional, scientific and technical'},
        {name: 'Administration and support'},
        {name: 'Public administration and defence'},
        {name: 'Education'},
        {name: 'Human health and social security'},
        {name: 'Arts, entertainment and recreation'},
        {name: 'Other services'},
        {name: 'Households as employers'},
        {name: 'Extraterritorial organisation'}
      ]);
    });
};
