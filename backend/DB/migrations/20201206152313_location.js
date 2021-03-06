
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('location');
    return !hasTable ? knex.schema.createTable('location', (table) => {
        table.increments();
        table.string('country');
        table.string('city');
    }) : null;
  
};

exports.down = function(knex) {
    return knex.schema.dropTable('location');
  
};
