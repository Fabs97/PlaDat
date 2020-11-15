
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student_has_placement')
    return !hasTable ? knex.schema.createTable('student_has_placement', (table)=>{
        table.integer('student_id').unsigned().references('id').inTable('student').notNullable();
        table.integer('placement_id').unsigned().references('id').inTable('placements').notNullable();
        table.boolean('student_accept');
        table.boolean('placement_accept');
        table.enum('status', ['ACCEPTED', 'REJECTED', 'PENDING']);
        table.primary(['student_id', 'placement_id']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_placement');

};