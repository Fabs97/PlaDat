
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student_has_work')
    return !hasTable ? knex.schema.createTable('student_has_work', (table) => {
        table.integer('student_id').unsigned().notNullable();
        table.foreign('student_id').references('student.id').onDelete('CASCADE');
        table.integer('work_id').unsigned().notNullable();
        table.foreign('work_id').references('work.id').onDelete('CASCADE');
        table.primary(['student_id', 'work_id']);
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_work');
};
