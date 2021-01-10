exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('student')
    let hasColumn = await knex.schema.hasColumn('student', 'user_id');
    return hasTable && !hasColumn ? knex.schema.table('student', (table) => {
        table.integer('user_id').unsigned().notNullable();
        table.foreign('user_id').references('registration.id').onDelete('CASCADE');
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.table('student', (table)=>{
        table.dropColumn('user_id');
    });
};