
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('work')
    return !hasTable ? knex.schema.createTable('work', (table) => {
        table.increments();
        table.string('company_name');
        table.string('position');
        table.string('work_period');
        table.text('description');
        table.integer('student_id').unsigned().notNullable();
        table.foreign('student_id').references('student.id').onDelete('CASCADE');
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('work');
};
