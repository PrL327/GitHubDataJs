var fs = require("fs");

function extractData() {

    json_data = fs.readFileSync('mobyCommits/moby-commits-5.json')
    var obj = JSON.parse(json_data)
    var add_sum = 0;
    var del_sum = 0;
    // console.log(obj)
    org_json = []
    for(var i=0; i<obj.data.length; i++)
    {
        user_data = obj.data[i]["sha"];
        console.log(user_data);
        user_data = org_json.push(user_data);
    }

    fs.writeFile('sha_moby_5.json', JSON.stringify(org_json, null, 4))

    
}

extractData()