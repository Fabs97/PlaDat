
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student')
    return !hasTable ? knex.schema.createTable('student', (table)=>{
        table.increments();
        table.string('name');
        table.string('surname');
        table.string('email');
        table.text('password');
        table.text('description');
        table.text('imgurl');
    }) : null;
};
  
exports.down = function(knex) {
    return knex.schema.dropTable('student');
    
};