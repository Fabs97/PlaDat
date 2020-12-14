
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placement_has_institution')
    return !hasTable ? knex.schema.createTable('placement_has_institution', (table)=>{  
        table.integer('placement_id').unsigned().notNullable();
        table.foreign('placement_id').references('placements.id').onDelete('CASCADE');
        table.integer('institution_id').unsigned().notNullable();
        table.foreign('institution_id').references('institutions.id').onDelete('CASCADE');
        table.primary(['placement_id', 'institution_id']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('placement_has_institution');
};


