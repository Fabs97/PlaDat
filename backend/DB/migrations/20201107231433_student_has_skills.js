
exports.up = function(knex) {
    return knex.schema.createTable('student_has_skills', (table)=>{
        
        table.integer('student_id').unsigned().references('id').inTable('student').notNullable();
        table.integer('skill_id').unsigned().references('id').inTable('skill').notNullable();
        table.primary(['student_id', 'skill_id']);
    })
};

exports.down = function(knex) {
    return knex.schema.dropTable('student_has_skills');

};
