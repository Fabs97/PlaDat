const database = require('../DB/connection');

module.exports = {

  getDegrees: () => {
    return database('degree')
      .select('id', 'name');
  },

  getDegreeById: async (id) => {
    let degree = await database('degree')
      .select('id', 'name')
      .where('id', id);
    return degree[0];
  },

};