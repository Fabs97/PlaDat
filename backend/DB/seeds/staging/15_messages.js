const { limit } = require("../../connection");

exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('message').del()
    .then(async function () {
      // Inserts seed entries
      let matches = await knex('student_has_placement')
        .select('placement_id', 'student_id')
        .where('status', 'ACCEPTED')
        .limit(5);
      let placementIDs =  matches.map(match => match.placement_id);
      matches = await knex('student_has_placement as shp')
        .select('p.employer_id', 'shp.student_id')
        .leftJoin('placements as p', 'p.id', 'shp.placement_id')
        .whereIn('shp.placement_id', placementIDs);

      return knex('message').insert([
        {employer_id: matches[0].employer_id, student_id: matches[0].student_id, message: "Hello, thank you for accepting me!", send_date: (new Date()), sender: 'STUDENT'},
        {employer_id: matches[0].employer_id, student_id: matches[0].student_id, message: "You're welcome! You have a great profile", send_date: (new Date()), sender: 'EMPLOYER'},
        {employer_id: matches[1].employer_id, student_id: matches[1].student_id, message: "Hello, thank you for your interest!", send_date: (new Date()), sender: 'EMPLOYER'},
        {employer_id: matches[1].employer_id, student_id: matches[1].student_id, message: "Hello, thank you for accepting me!", send_date: (new Date()), sender: 'STUDENT'},
        {employer_id: matches[1].employer_id, student_id: matches[1].student_id, message: "When do you think we can have a call?", send_date: (new Date()), sender: 'EMPLOYER'},
        {employer_id: matches[2].employer_id, student_id: matches[2].student_id, message: "Hello, thank you for accepting me!", send_date: (new Date()), sender: 'STUDENT'},
       
      ]);
    });
};
