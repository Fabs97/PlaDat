
exports.up = async function(knex) {
    let hasTable = await knex.schema.hasTable("placements");
    return hasTable ? knex.schema.table('placements', (table) => {
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
