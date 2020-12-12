
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('work')
    return !hasTable ? knex.schema.createTable('work', (table) => {
        table.increments();
        table.string('company_name');
        table.string('position');
        table.date('start_period');
        table.date('end_period');
        table.text('description');
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('work');
};
