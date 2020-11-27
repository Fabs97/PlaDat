exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('student').del()
    .then(function () {
      // Inserts seed entries
      return knex('student').insert([
        {name: "Alice", surname: "Casali", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Fabrizio", surname: "Siciliano", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Anna", surname: "Bergamsco", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Aida", surname: "Opirlesc", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Andela", surname: "Zoric", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "William", surname: "Nordberg", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Bassam", surname: "Zabad", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Jhonny", surname: "Depp", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Maryl", surname: "Streep", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  },
        {name: "Freddy", surname: "Mercury", email: "abcd@gmail.com", password: "1234", description: "Engineer student"  }
       
      ]);
    });
};