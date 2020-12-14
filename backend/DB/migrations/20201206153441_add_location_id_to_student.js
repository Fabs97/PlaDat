
exports.up = function(knex, Promise) {
    return knex.schema.table('student', function(table) {
        table.integer('location_id').unsigned().references('id').inTable('location');
    })
  
};

exports.down = function(knex) {
    return knex.schema.table('student', function(table) {
        table.dropColumn('location_id')
      })
};
