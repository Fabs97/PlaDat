
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('degree')
    return !hasTable ? knex.schema.createTable('degree', (table) => {
        table.increments();
        table.string('name');
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('degree');
};


