
exports.up =  async function(knex) {
    let hasTable = await knex.schema.hasTable('skill')
    return !hasTable ? knex.schema.createTable('skill', (table)=>{
        table.increments();
        table.string('name');
        table.enum('type', ['TECH', 'SOFT', 'OTHER']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('skill');
};
