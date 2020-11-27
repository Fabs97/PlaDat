
exports.up = function(knex) {
    return knex.schema.table('student', function(table) {
      if(knex.schema.hasColumn(table, "imgurl")) {table.dropColumn('imgurl') }  
      
      })
};

exports.down = function(knex, Promise) {
    return knex.schema.table('student', function(table) {
        table.string('imgurl')
      });
};
