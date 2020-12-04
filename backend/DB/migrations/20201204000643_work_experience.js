exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('education')
    return !hasTable ? knex.schema.createTable('education', (table) => {
        table.increments();
        table.integer('institution_id').unsigned().references('id').inTable('institutions').notNullable();
        table.integer('degree_id').unsigned().references('id').inTable('degree').notNullable();
        table.integer('major_id').unsigned().references('id').inTable('majors').notNullable();
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('education');
};