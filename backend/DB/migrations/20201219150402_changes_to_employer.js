
exports.up = async function(knex) {
    let check1 = await knex.schema.hasColumn('employer', "urllogo");
    let check2 = await knex.schema.hasColumn('employer', "location");
    return knex.schema.table('employer', function(table) {
      if(check1) {table.dropColumn('urllogo') }  
      if(check2) {table.dropColumn('location') } 
      table.integer('location_id').unsigned().references('id').inTable('location');
      table.string('description');
      table.integer('domain_of_activity_id').unsigned().references('id').inTable('domain_of_activity');
      })
};

exports.down = async function(knex) {
    let check1 = await knex.schema.hasColumn('employer', "description");
    let check2 = await knex.schema.hasColumn('employer', "location");
    let check3 = await knex.schema.hasColumn('employer', "domain_of_activity_id");
    return knex.schema.table('employer', function(table) {
        table.string('urllogo');
        table.string('location');
        if(check1) {table.dropColumn('description') } 
        if(check2) {table.dropColumn('location_id') }
        if(check3) {table.dropColumn('domain_of_activity_id') }; 
      });
};
