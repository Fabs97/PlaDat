
exports.up = function(knex) {
    return knex.schema.createTable('placement_has_skills', (table)=>{
        
        table.integer('placement_id').unsigned().references('id').inTable('placements').notNullable();
        table.integer('skill_id').unsigned().references('id').inTable('skill').notNullable();
        table.primary(['placement_id', 'skill_id']);
    })
};

exports.down = function(knex) {
    return knex.schema.dropTable('placement_has_skills');

};
