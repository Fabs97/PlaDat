
exports.up = async function(knex) {
    let check1 = await knex.schema.hasColumn('registration', "email");
    if(check1) {
        return knex.schema.alterTable('registration', function(table) {
            table.unique('email')
        })
    } 
};

exports.down = function(knex, Promise) {
    return knex.schema.alterTable('registration', function(table) {
        table.string('email')
    });
};
