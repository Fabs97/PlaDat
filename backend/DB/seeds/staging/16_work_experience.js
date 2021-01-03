
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('work').del()
    .then(async function () {
      // Inserts seed entries
      let today = new Date();
      return knex('work').insert([
        {
          company_name: "Google",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: today,
          end_period: today,
        },
        {
          company_name: "Facebook",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: today,
          end_period: today,
        },
        {
          company_name: "Airbnb",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: today,
          end_period: today,
        },
        {
          company_name: "Amazon",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: today,
          end_period: today,
        },
        {
          company_name: "Netflix",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: today,
          end_period: today,
        },
        {
          company_name: "Spotify",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: today,
          end_period: today,
        }
      ]);
    })
};