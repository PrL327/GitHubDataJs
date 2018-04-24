
var fs = require("fs");

function extractData() {

    json_data = fs.readFileSync('moby.json')
    var obj = JSON.parse(json_data)
    var add_sum = 0;
    var del_sum = 0;
    // console.log(obj)
    org_json = []
    for(var i=0; i<obj.data.length; i++)
    {
        // console.log(obj.data[0].author['login']);
        username = obj.data[i].author['login']
        commit_num = obj.data[i].total

        for(j=0; j<obj.data[i].weeks.length; j++){
            add_sum += obj.data[i].weeks[j]['a']
            del_sum += obj.data[i].weeks[j]['d']
        }
        var user_data = {
            user_name: username,
            additions: add_sum,
            deletions: del_sum,
            commits: commit_num
        }
        org_json.push(user_data)
        add_sum = 0;
        del_sum = 0;
    }

    fs.writeFile('organized.json', JSON.stringify(org_json, null, 4))

    
}

extractData()