const database = require('../DB/connection');

module.exports = {

  getMajors: async () => {
        return database('majors')
      .select('id', 'name');
  }, 

  getMajorById: async (id) => {
    let major = await database('majors')
                    .select('id', 'name')
                    .where('id', id);
    return major[0];
  },


  
};