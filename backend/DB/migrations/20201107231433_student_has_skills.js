
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student_has_skills')
    return !hasTable ? knex.schema.createTable('student_has_skills', (table)=>{
        table.integer('student_id').unsigned().notNullable();
        table.foreign('student_id').references('student.id').onDelete('CASCADE');
        table.integer('skill_id').unsigned().notNullable();
        table.foreign('skill_id').references('skill.id').onDelete('CASCADE');
        table.primary(['student_id', 'skill_id']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_skills');

};
