
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('work')
    return !hasTable ? knex.schema.createTable('work', (table) => {
        table.increments();
        table.string('company_name');
        table.string('position');
        table.string('work_period');
        table.text('description');
        table.integer('student_id').references('id').inTable('student').onDelete('CASCADE').alter();
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('work');
};
