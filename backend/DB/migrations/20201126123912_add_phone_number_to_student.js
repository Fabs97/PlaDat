
exports.up = async function(knex, Promise) {
  let check = await knex.schema.hasColumn('student','phone');
  return !check ? knex.schema.table('student', function(table) {
        table.string('phone')
      }) : null;

};

exports.down = function(knex, Promise) {
  return knex.schema.table('student', function(table) {
        table.dropColumn('phone')
      })
};
