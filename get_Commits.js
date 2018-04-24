const octokit = require('@octokit/rest')();
var fs = require("fs");

octokit.authenticate({
    type: 'basic',
    username: '',
    password: ''
});

async function getStats()
{
    var moby_commit_data = []

    for(var i = 1; i <= 349; i++)
    {
        let moby_data =  await octokit.repos.getCommits({
            owner: 'moby', 
            repo: 'moby',
            page: i,
            per_page: 100
        });
        
        for(var j = 0; j <= 99; j++)
        {   console.log(j);

            if(moby_data.data[j].commit.committer['name'] == null){
                console.log('Commit without a username')
            }
            else{
                simple_commit = 
                {
                    user: moby_data.data[j].commit.committer['name'],
                    sha: moby_data.data[j]["sha"]
                }
                moby_commit_data.push(simple_commit)
            }
        }

        json_data = JSON.stringify(moby_data, null, 4);

        fs.appendFile('mobyCommits/moby-test-commits.json', json_data, (err) => {  
             if (err) throw err;
            console.log('Data written to file');
        });
        console.log('page done:', i);
    } 

    test_data = JSON.stringify(moby_commit_data, null, 4)

            fs.writeFile('mobyCommits/moby-commits.json', test_data, (err) => {  
                if (err) throw err;
               console.log('Commit data written to file');
           });
    
}
// getStats()

async function getIndividualCommitInfo()
{
    var data = fs.readFileSync('mobyCommits/commits_details.json')
    data = JSON.parse(data)
    var commit_json = fs.readFileSync('mobyCommits/moby-commits.json')

    console.log('READ FILE')
    var commit_obj = JSON.parse(commit_json)
    console.log('PARSED DATA')
    console.log(commit_obj[1]['sha']);

    for(var i = 4951; i<= 8951; i++)
    {
        let commit_data = await octokit.repos.getCommit({
            owner: 'moby',
            repo: 'moby',
            sha: commit_obj[i]['sha']
        });
        // console.log(commit_data);
        if(commit_data.data.author ==  null){
            console.log('err w/login')
        }
        else {
            var commit_info = {
                user_name: commit_data.data.author['login'],
                additions: commit_data.data.stats.additions,
                deletions: commit_data.data.stats.deletions,
                total: commit_data.data.stats.total
            }
        }
        data.push(commit_info);
    }
    simpleData = JSON.stringify(data, null, 4);

    fs.writeFile('mobyCommits/commits_details.json', simpleData, (err) => {  
        if (err) throw err;
       console.log('Commit data written to file');
   });
}

getIndividualCommitInfo()