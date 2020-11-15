
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placement_has_institution')
    return !hasTable ? knex.schema.createTable('placement_has_institution', (table)=>{  
        table.integer('placement_id').unsigned().references('id').inTable('placements').notNullable();
        table.integer('institution_id').unsigned().references('id').inTable('institutions').notNullable();
        table.primary(['placement_id', 'institution_id']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('placement_has_institution');
};


