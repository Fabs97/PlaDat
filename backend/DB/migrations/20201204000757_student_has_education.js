exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student_has_education')
    return !hasTable ? knex.schema.createTable('student_has_education', (table) => {
        table.integer('student_id').unsigned().notNullable();
        table.foreign('student_id').references('student.id').onDelete('CASCADE');
        table.integer('education_id').unsigned().notNullable();
        table.foreign('education_id').references('education.id').onDelete('CASCADE');
        table.text('description');
        table.string('period');
        table.primary(['student_id', 'education_id']);
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_education');
};