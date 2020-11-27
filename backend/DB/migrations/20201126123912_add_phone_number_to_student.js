
exports.up = function(knex, Promise) {
  return knex.schema.table('student', function(table) {
        table.string('phone')
      });

};

exports.down = function(knex, Promise) {
  return knex.schema.table('student', function(table) {
        table.dropColumn('phone')
      })
};
