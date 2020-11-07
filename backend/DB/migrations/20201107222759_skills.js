
exports.up = function(knex) {
    return knex.schema.createTable('skill', (table)=>{
        table.increments();
        table.string('name');
        table.enum('type', ['TECH', 'SOFT', 'OTHER']);
    })
};

exports.down = function(knex) {
    return knex.schema.dropTable('skill');
};
