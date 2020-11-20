exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placements')
    return hasTable ? knex.schema.table('placements', (table)=>{
        table.integer('employer_id').unsigned().references('id').inTable('employer').notNullable();
    }) : null;
};
  
exports.down = function(knex) {
    return knex.schema.table('placements', (table)=>{
        table.dropColumn('employer_id');
    });
};