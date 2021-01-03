
exports.up = async function(knex) {

    let hasTable = await knex.schema.hasTable('domain_of_activity')
    return !hasTable ? knex.schema.createTable('domain_of_activity', (table) => {
        table.increments();
        table.string('name');
    }) : null;
  
};

exports.down = function(knex) {
  
    return knex.schema.dropTable('domain_of_activity')
};
