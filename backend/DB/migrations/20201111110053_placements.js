exports.up = function(knex) {
    return knex.schema.createTable('placements', (table) => {
        table.increments();
        table.string("position");
        table.integer("working_hours");
        table.date("start_period");
        table.date("end_period");
        table.integer("salary");
        table.string("description_role");
        table.string("institution");
        table.string("major");
    })
};

exports.down = function(knex) {
    return knex.schema.dropTable('placements');
};