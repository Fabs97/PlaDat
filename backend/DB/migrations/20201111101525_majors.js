

exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('majors')
    return !hasTable ? knex.schema.createTable('majors', (table) => {
        table.increments();
        table.string('name');
    }) : null; 
}
  
exports.down = function(knex) {
    return knex.schema.dropTable('majors');
};

