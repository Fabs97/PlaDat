
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
        {name: 'Electricity, gas, steam and air conditioning supply'},
        {name: 'Water supply, sewerage, waste management and remediation activities'},
        {name: 'Construction'},
        {name: 'Wholesale and retail trade; repair of motor vehicles and motorcycles'},
        {name: 'Accommodation and food service activities'},
        {name: 'Transportation and storage'},
        {name: 'Information and communication'},
        {name: 'Financial and insurance activities'},
        {name: 'Real estate activities'},
        {name: 'Professional, scientific and technical activities'},
        {name: 'Administrative and support service activities'},
        {name: 'Public administration and defence; compulsory social security'},
        {name: 'Education'},
        {name: 'Human health and social work activities'},
        {name: 'Arts, entertainment and recreation'},
        {name: 'Other service activities'},
        {name: 'Activities of households as employers; undifferentiated goods- and services-producing activities of households for own use'},
        {name: 'Activities of extraterritorial organisations and bodies'}
      ]);
    });
};
