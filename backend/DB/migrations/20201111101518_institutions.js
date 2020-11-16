
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('institutions')
    return !hasTable ? knex.schema.createTable('institutions', (table) => {
        table.increments();
        table.string('name');
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('institutions');
};

