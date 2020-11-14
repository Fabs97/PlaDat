
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placements')
    return !hasTable ? knex.schema.createTable('placements', (table) => {
        table.increments();
        table.string("position");
        table.integer("working_hours");
        table.date("start_period");
        table.date("end_period");
        table.integer("salary");
        table.string("description_role");
        table.string("institution");
        table.string("major");
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('placements');
};
