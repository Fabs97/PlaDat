
exports.up = async function(knex) {
    //add cascade on some foreign keys
    await knex.schema.alterTable('student_has_skills', async function(table) {
        await table.dropPrimary()
        table.dropForeign('student_id')
        table.dropForeign('skill_id')
        table.integer('student_id').references('id').inTable('student').onDelete('CASCADE').alter();
        table.integer('skill_id').references('id').inTable('skill').onDelete('CASCADE').alter();
        table.primary(['student_id', 'skill_id']);
    });

    await knex.schema.alterTable('placement_has_skills', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('skill_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('CASCADE').alter();
        table.integer('skill_id').references('id').inTable('skill').onDelete('CASCADE').alter();
        table.primary(['placement_id', 'skill_id']);
    });

    await knex.schema.alterTable('placement_has_institution', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('institution_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('CASCADE').alter();
        table.integer('institution_id').references('id').inTable('institutions').onDelete('CASCADE').alter();
        table.primary(['placement_id', 'institution_id']);
    });

    await knex.schema.alterTable('placement_has_major', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('major_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('CASCADE').alter();
        table.integer('major_id').references('id').inTable('majors').onDelete('CASCADE').alter();
        table.primary(['placement_id', 'major_id']);
    });

    await knex.schema.alterTable('student_has_placement', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('student_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('CASCADE').alter();
        table.integer('student_id').references('id').inTable('student').onDelete('CASCADE').alter();
        table.primary(['student_id', 'placement_id']);
    });

    await knex.schema.alterTable('placements', async function(table) {
        table.dropForeign('employer_id')
        table.integer('employer_id').references('id').inTable('employer').onDelete('CASCADE').alter();
    });

    return true;
};

exports.down = async function(knex) {
    await knex.schema.alterTable('student_has_skills', async function(table) {
        await table.dropPrimary()
        table.dropForeign('student_id')
        table.dropForeign('skill_id')
        table.integer('student_id').references('id').inTable('student').onDelete('NO ACTION').alter();
        table.integer('skill_id').references('id').inTable('skill').onDelete('NO ACTION').alter();
        table.primary(['student_id', 'skill_id']);
    });

    await knex.schema.alterTable('placement_has_skills', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('skill_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('NO ACTION').alter();
        table.integer('skill_id').references('id').inTable('skill').onDelete('NO ACTION').alter();
        table.primary(['placement_id', 'skill_id']);
    });

    await knex.schema.alterTable('placement_has_institution', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('institution_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('NO ACTION').alter();
        table.integer('institution_id').references('id').inTable('institutions').onDelete('NO ACTION').alter();
        table.primary(['placement_id', 'institution_id']);
    });

    await knex.schema.alterTable('placement_has_major', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('major_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('NO ACTION').alter();
        table.integer('major_id').references('id').inTable('majors').onDelete('NO ACTION').alter();
        table.primary(['placement_id', 'major_id']);
    });

    await knex.schema.alterTable('student_has_placement', async function(table) {
        await table.dropPrimary()
        table.dropForeign('placement_id')
        table.dropForeign('student_id')
        table.integer('placement_id').references('id').inTable('placements').onDelete('NO ACTION').alter();
        table.integer('student_id').references('id').inTable('student').onDelete('NO ACTION').alter();
        table.primary(['student_id', 'placement_id']);
    });

    await knex.schema.alterTable('placements', async function(table) {
        table.dropForeign('employer_id')
        table.integer('employer_id').references('id').inTable('employer').onDelete('NO ACTION').alter();
    });

    return true;
};
