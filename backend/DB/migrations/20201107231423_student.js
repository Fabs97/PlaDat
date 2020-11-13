
exports.up = function(knex) {
    return knex.schema.createTable('student', (table)=>{
        table.increments();
        table.string('name');
        table.string('surname');
        table.string('email');
        table.text('password');
        table.text('description');
        table.text('imgurl');
    })
};
  
exports.down = function(knex) {
    return knex.schema.dropTable('student');
    
};