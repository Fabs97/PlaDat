exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placements');
    let check = await knex.schema.hasColumn('placements','employer_id');
    return (hasTable && !check) ? knex.schema.table('placements', (table)=>{
        table.integer('employer_id').unsigned().notNullable();
        table.foreign('employer_id').references('employer.id').onDelete('CASCADE');
    }) : null;
};
  
exports.down = function(knex) {
    return knex.schema.table('placements', (table)=>{
        table.dropColumn('employer_id');
    });
};