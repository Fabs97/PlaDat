const database = require('../DB/connection');

module.exports = {

  getPlacements: () => {
    return database('placements')
    .select('id',
        'position',
        'working_hours',
        'start_period',
        'end_period',
        'salary',
        'description_role',
        'institution',
        'major');
  }
};