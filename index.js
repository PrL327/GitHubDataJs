const octokit = require('@octokit/rest')();

//used to increase number of queries an hour
octokit.authenticate({
    type: 'basic',
    username: '',
    password: ''
});

// Compare: https://developer.github.com/v3/repos/#list-organization-repositories
octokit.repos.getRepos({
  owner: 'prl327',
  repo: 'JavaFXMusicLibrary'
}).then(({data}) => {
  console.log(data);
});

Need to Loop through it
octokit.repos.getCommits({
  owner: 'prl327',
  repo: 'ravenIM'
}).then(({data}) => {
  console.log(data);
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
    console.log(total/totUsers)
}

async function getCommitsPerRepo(owner){
  result = await ocktokit.repos.getCommits({
    username: owner,
    repo: getReposNames(owner)
  });

  return result;
}

async function test2() {
  userLst = await getUsers(totUsers);
  for (i = 0; i < userLst.length; i++) {
      commits = await getCommitsPerRepo(userLst[i]);

  }
}
// Get Contributers
