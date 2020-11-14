
exports.up = function(knex) {
    return knex.schema.createTable('placement_has_institution', (table)=>{
        
        table.integer('placement_id').unsigned().references('id').inTable('placements').notNullable();
        table.integer('institution_id').unsigned().references('id').inTable('institutions').notNullable();
        table.primary(['placement_id', 'institution_id']);
    })
};

exports.down = function(knex) {
    return knex.schema.dropTable('placement_has_institution');
};


