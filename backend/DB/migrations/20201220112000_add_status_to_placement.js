
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placements');
    return hasTable ? knex.schema.table('placements', function(table){
        table.enum('status', ['OPEN', 'CLOSED']);
  }) : null;
};

exports.down = function(knex) {
  return knex.schema.table('placements', (table) => {
      table.dropColumn('status');
  })
};
