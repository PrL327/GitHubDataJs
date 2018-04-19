const octokit = require('@octokit/rest')();
var fs = require("fs");

//used to increase number of queries an hour
octokit.authenticate({
    type: 'basic',
    username: '',
    password: ''
});

Compare: https://developer.github.com/v3/repos/#list-organization-repositories
octokit.repos.get({
  owner: 'prl327',
  repo: 'JavaFXMusicLibrary'
}).then(({data}) => {
  // console.log(data);
});

async function getStats()
{
    let moby_data =  await octokit.repos.getStatsContributors({
        owner: 'moby', 
        repo: 'moby'
    });
    console.log(moby_data);
    json_data = JSON.stringify(moby_data, null, 4)
    fs.writeFile('moby.json', json_data, (err) => {  
        if (err) throw err;
        console.log('Data written to file');
    });
}

json_data = getStats()


octokit.repos.getCommits({
  owner: 'prl327',
  repo: 'ravenIM'
}).then(({data}) => {
  // console.log(data);
})

//gets k users
async function getUsers(k=10)
{
    let users = [];
    while (users.length < k)
    {
        let result = await octokit.users.getAll(users.length);
        result = result.data;
        result.forEach(function (a) {
          if (users.length < k)
              users.push(a.login)
        });
    }
    return users
}

async function getRepos(owner) {
    result = await octokit.repos.getForUser({
        username: owner,
        per_page: 100});
    return result.data.length
}


async function getContributersFromRepo(user, repository) {

  try {
  result = await octokit.repos.getContributors({
        owner: user,
        repo: repository
  });

  if(result.data)
    return result.data.length;
  else
    return 0;
} catch(error){
  return 0;
}

}
async function getRepoList(owner) {
    result = await octokit.repos.getForUser({
        username: owner,
        per_page: 100});
    return result.data;
}

async function getReposNames(owner) {

    result = await octokit.repos.getForUser({
        username: owner,
        per_page: 100});
    return result;
}

//use user names for info
async function test() {
    total = 0;
    totUsers = 200 ;
    userLst = await getUsers(totUsers);
    for (i = 0; i < userLst.length; i++) {
        totalRepos = await getRepos(userLst[i]);
        total += totalRepos
    }
    console.log(total/totUsers);
}

async function getCommitsPerRepo(owner){
  result = await ocktokit.repos.getCommits({
    username: owner,
    repo: getReposNames(owner)
  });

  return result;
}

async function test2() {
  totUsers = 100;
  user_sets = new Set();
  userLst = await getUsers(totUsers);
  for (i = 0; i < userLst.length; i++) {
      repoLists = await getRepoList(userLst[i]);
      if(repoLists) {

          for(j = 0; j < repoLists.length; j++){
            repo_name = repoLists[j].name;
            user_name = userLst[i];
            total_contributers = await getContributersFromRepo(user_name, repo_name);

            user_sets.add(total_contributers)
          }
    }
  }
  user_sets = Arrray.from(user_sets).sort()
  console.log(user_sets);
}

test2();
// Get Contributers
