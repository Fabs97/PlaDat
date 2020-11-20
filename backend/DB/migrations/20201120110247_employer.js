exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('employer')
    return !hasTable ? knex.schema.createTable('employer', (table)=>{
        table.increments();
        table.string('name');
        table.string('location');
        table.text('urllogo');
    }) : null;
};
  
exports.down = function(knex) {
    return knex.schema.dropTable('employer');
};
