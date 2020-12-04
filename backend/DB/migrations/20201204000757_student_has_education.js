exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student_has_education')
    return !hasTable ? knex.schema.createTable('student_has_education', (table) => {
        table.increments();
        table.integer('student_id').unsigned().references('id').inTable('student').notNullable();
        table.integer('education_id').unsigned().references('id').inTable('education').notNullable();
        table.text('description');
        table.string('period');
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_education');
};