
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placement_has_skills')
    return !hasTable ? knex.schema.createTable('placement_has_skills', (table) => {
        table.integer('placement_id').unsigned().notNullable();
        table.foreign('placement_id').references('placements.id').onDelete('CASCADE');
        table.integer('skill_id').unsigned().notNullable();
        table.foreign('skill_id').references('skill.id').onDelete('CASCADE');
        table.primary(['placement_id', 'skill_id']);
    }) : null;
};

exports.down = function(knex) {
    return knex.schema.dropTable('placement_has_skills');

};
