
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('education').del()
    .then(async function () {

      let majors = await knex('majors')
        .select('id', 'name')
        .limit(5);
      
      let degrees = await knex('degree')
        .select('id', 'name')
        .limit(3);

      let institutions = await knex('institutions')
        .select('id', 'name')
        .limit(5);

      // Inserts seed entries
      return knex('education').insert([
        {
          major_id: majors[0].id,
          degree_id: degrees[1].id,
          institution_id: institutions[0].id
        },
        {
          major_id: majors[1].id,
          degree_id: degrees[0].id,
          institution_id: institutions[1].id
        },
        {
          major_id: majors[2].id,
          degree_id: degrees[2].id,
          institution_id: institutions[2].id
        },
        {
          major_id: majors[3].id,
          degree_id: degrees[1].id,
          institution_id: institutions[1].id
        },
        {
          major_id: majors[4].id,
          degree_id: degrees[0].id,
          institution_id: institutions[0].id
        },
        {
          major_id: majors[3].id,
          degree_id: degrees[2].id,
          institution_id: institutions[2].id
        },
        {
          major_id: majors[2].id,
          degree_id: degrees[1].id,
          institution_id: institutions[3].id
        },
        {
          major_id: majors[1].id,
          degree_id: degrees[0].id,
          institution_id: institutions[4].id
        },
        {
          major_id: majors[0].id,
          degree_id: degrees[2].id,
          institution_id: institutions[3].id
        },
        {
          major_id: majors[1].id,
          degree_id: degrees[1].id,
          institution_id: institutions[2].id
        }
      ]);
    })
};