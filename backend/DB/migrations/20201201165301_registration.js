
exports.up = async function(knex) {
  let hasTable = await knex.schema.hasTable('registration')
  return !hasTable ? knex.schema.createTable('registration', table => {
        table.increments();
        table.string('email');
        table.string('password');
        table.enum('type', ['EMPLOYER', 'STUDENT']);
  }) : null;
};

exports.down = function(knex) {
  return knex.schema.dropTable('registration');
};
