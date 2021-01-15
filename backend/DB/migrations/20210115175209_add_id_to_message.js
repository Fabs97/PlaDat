
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('message');
    return hasTable ? knex.schema.table('message', function(table){
        table.increments();
  }) : null;
};

exports.down = function(knex) {
  return knex.schema.table('message', (table) => {
      table.dropColumn('id');
  })
};