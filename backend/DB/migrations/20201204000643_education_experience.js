exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('education')
    return !hasTable ? knex.schema.createTable('education', (table) => {
        table.increments();
        table.integer('institution_id').unsigned().notNullable();
        table.foreign('institution_id').references('institutions.id').onDelete('CASCADE');
        table.integer('degree_id').unsigned().notNullable();
        table.foreign('degree_id').references('degree.id').onDelete('CASCADE');
        table.integer('major_id').unsigned().notNullable();
        table.foreign('major_id').references('majors.id').onDelete('CASCADE');
    }) : null; 
};

exports.down = function(knex) {
    return knex.schema.dropTable('education');
};