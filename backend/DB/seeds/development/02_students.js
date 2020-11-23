exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student').del()
    .then(function () {
      // Inserts seed entries
      return knex('student').insert([
        {name: "Alice #TEST", surname: "Casali", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Fabrizio #TEST", surname: "Siciliano", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Anna #TEST", surname: "Bergamsco", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Aida #TEST", surname: "Opirlesc", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Andela #TEST", surname: "Zoric", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "William #TEST", surname: "Nordberg", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Bassam #TEST", surname: "Zabad", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Jhonny #TEST", surname: "Depp", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Maryl #TEST", surname: "Streep", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
        {name: "Freddy #TEST", surname: "Mercury", email: "abcd@gmail.com", password: "1234", description: "Engineer student", imgurl: "https://source.unsplash.com/random"},
       
      ]);
    });
};