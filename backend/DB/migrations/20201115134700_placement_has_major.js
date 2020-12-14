
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placement_has_major')
    return !hasTable ? knex.schema.createTable('placement_has_major', (table)=>{
        table.integer('placement_id').unsigned().notNullable();
        table.foreign('placement_id').references('placements.id').onDelete('CASCADE');
        table.integer('major_id').unsigned().notNullable();
        table.foreign('major_id').references('majors.id').onDelete('CASCADE');
        table.primary(['placement_id', 'major_id']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('placement_has_major');
};