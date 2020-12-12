
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('work').del()
    .then(async function () {
      // Inserts seed entries
      return knex('work').insert([
        {
          company_name: "Google",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: "2020/01/30",
          end_period: "2020/06/30",
        },
        {
          company_name: "Facebook",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: "2020/01/30",
          end_period: "2020/06/30",
        },
        {
          company_name: "Airbnb",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: "2020/01/30",
          end_period: "2020/06/30",
        },
        {
          company_name: "Amazon",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: "2020/01/30",
          end_period: "2020/06/30",
        },
        {
          company_name: "Netflix",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: "2020/01/30",
          end_period: "2020/06/30",
        },
        {
          company_name: "Spotify",
          position: "Junior Developer",
          description: "Difficult job",
          start_period: "2020/01/30",
          end_period: "2020/06/30",
        }
      ]);
    })
};