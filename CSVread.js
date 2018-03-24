var csv = require('csv');
var fs = require('fs');

var csv_obj = csv(); //used version 0.3.7

function Repos_CSV(user, repo) {
  this.User = user;
  this.Repository = repo;
};

var repos_data = [];

csv_obj.from.path('repos.csv').to.array(function (data) {
    for (var index = 0; index < data.length; index++) {
        repos_data.push(new Repos_CSV(data[index][0], data[index][1], data[index][2]));
    }
    // console.log(repos_data);
    var repoJSON = JSON.stringify(repos_data);
    fs.writeFile("repos.json", repoJSON, (error) => { console.log(repoJSON) });
});
