
exports.up = function(knex) {
    return knex.schema.createTable('student1', (table)=>{
        table.increments();
        table.string("name");
    })
};
  
exports.down = function(knex) {
    return knex.schema.dropTable('student1');
    
};