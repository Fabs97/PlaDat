
exports.up = async function(knex) {
    let check = await knex.schema.hasColumn('student', "imgurl");
    return knex.schema.table('student', function(table) {
      if(check) {
          table.dropColumn('password');
          table.dropColumn('email');
        }  
      
      })
};

exports.down = function(knex, Promise) {
    return knex.schema.table('student', function(table) {
        table.string('password');
        table.string('email');
      });
};
