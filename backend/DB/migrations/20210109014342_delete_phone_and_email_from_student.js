
exports.up = async function(knex) {
    let check1 = await knex.schema.hasColumn('student', "email");
    let check2 = await knex.schema.hasColumn('student', "password");
    return knex.schema.table('student', function(table) {
      if(check1 && check2) {
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
