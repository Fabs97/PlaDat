
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placement_has_institution')
    return !hasTable ? knex.schema.createTable('placement_has_major', (table)=>{
        table.integer('placement_id').unsigned().references('id').inTable('placements').notNullable();
        table.integer('major_id').unsigned().references('id').inTable('majors').notNullable();
        table.primary(['placement_id', 'major_id']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('placement_has_major');
};
