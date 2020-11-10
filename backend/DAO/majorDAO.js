const database = require('../DB/connection');

module.exports = {

  getMajors: () => {
        return database('majors')
            .select('id', 'name');
  }


  
};