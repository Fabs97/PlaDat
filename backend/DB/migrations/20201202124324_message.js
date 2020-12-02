
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('message')
    return !hasTable ? knex.schema.createTable('message', (table)=>{
        table.integer('student_id').unsigned().references('id').inTable('student').notNullable();
        table.integer('employer_id').unsigned().references('id').inTable('employer').notNullable();
        table.string('message');
        table.datetime('send_date');
        table.enum('sender', ['STUDENT', 'EMPLOYER']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('message');
};
