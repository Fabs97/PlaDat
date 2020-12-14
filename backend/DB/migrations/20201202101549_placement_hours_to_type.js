
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable('placements');
    let checkWH = await knex.schema.hasColumn('placements', 'working_hours');
    let checkET = await knex.schema.hasColumn('placements', 'employment_type');
    return (hasTable && checkWH && !checkET) ? knex.schema.table('placements', (table) => {
        table.dropColumn('working_hours');
        table.enum("employment_type", ["FULL_TIME", "PART_TIME", "CONTRACT", "INTERNSHIP"]);
    }) : null;
};

exports.down = function(knex) {
  return knex.schema.table('placements', (table)=>{
      table.dropColumn('employment_type');
      table.integer('working_hours');
    });
};
