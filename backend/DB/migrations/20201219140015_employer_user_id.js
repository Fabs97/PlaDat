exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('employer')
    let hasColumn = await knex.schema.hasColumn('employer', 'user_id');
    return hasTable && !hasColumn ? knex.schema.table('employer', (table) => {
        table.integer('user_id').unsigned().notNullable();
        table.foreign('user_id').references('registration.id').onDelete('CASCADE');
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.table('employer', (table)=>{
        table.dropColumn('user_id');
    });
};