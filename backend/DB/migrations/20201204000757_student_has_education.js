exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student_has_education')
    return !hasTable ? knex.schema.createTable('student_has_education', (table) => {
        table.integer('student_id').unsigned().references('id').inTable('student').onDelete('CASCADE').notNullable();
        table.integer('education_id').unsigned().references('id').inTable('education').onDelete('CASCADE').notNullable();
        table.text('description');
        table.string('period');
        table.primary(['student_id', 'education_id']);
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_education');
};