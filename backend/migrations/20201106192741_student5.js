
exports.up = function(knex) {
    return knex.schema.createTable('student5', (table)=>{
        table.increments();
        table.string("name");
    })
};

exports.down = function(knex) {
    return knex.schema.dropTable('student5');
};
