const octokit = require('@octokit/rest')()

// Compare: https://developer.github.com/v3/repos/#list-organization-repositories
octokit.repos.getLanguages({
  owner: 'prl327',
  repo: 'LetsPlayCraps'
}).then(({data}) => {
  console.log(data);
})
