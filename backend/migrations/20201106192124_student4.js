
exports.up = function(knex) {
    return knex.schema.createTable('student4', (table)=>{
        table.increments();
        table.string("name");
    })
  };
  
  exports.down = function(knex) {
      return knex.schema.dropTable('student4');
    
  };