
exports.up = function(knex) {
    return knex.schema.createTable('student_has_placement', (table) => {
        table.integer('student_id').unsigned().references('id').inTable('student').notNullable();
        table.integer('placement_id').unsigned().references('id').inTable('placements').notNullable();
        table.boolean('student_accept');
        table.boolean('placement_accept');
        table.enum('status', ['PENDING','ACCEPTED','REJECTED']);
        table.primary(['student_id', 'placement_id']);
    })
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_placement');
};
