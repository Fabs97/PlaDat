exports.up = function(knex, Promise) {
    return knex.schema.table('placements', function(table) {
        table.integer('location_id').unsigned().references('id').inTable('location');
    })
  
};

exports.down = function(knex) {
    return knex.schema.table('placements', function(table) {
        table.dropColumn('location_id')
      })
};