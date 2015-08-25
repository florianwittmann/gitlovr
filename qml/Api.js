.pragma library

var coverImage = "";
var coverUsername =""
var BASE="https://api.github.com"
var access_token = "";
var selfId;

function request(verb, endpoint, obj, cb, includeBase) {
    print('request: ' + verb + ' ' + (includeBase? BASE:'') + (endpoint? endpoint:''))
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if(xhr.readyState === XMLHttpRequest.DONE) {
            if(cb) {
                var res;
                try {
                    res = JSON.parse(xhr.responseText.toString())
                } catch(err) {
                    res = {}
                    res['error'] = xhr.responseText.toString()
                }
                cb(res);

            }
        }
    }
    xhr.open(verb, (includeBase? BASE:'')  + (endpoint? endpoint:''));
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader('Accept', includeBase? 'application/vnd.github.v3+json' : 'application/json');
    var data = obj?obj:''
    xhr.send(data)
}

function authorize(code,cb) {
    var  client_id = 'CLIENTID'
    var client_secret ='CLIENTSECRET'
    request('POST', 'https://github.com/login/oauth/access_token?client_id=' + client_id + '&client_secret=' + client_secret + '&code=' + code, null, cb, false)
}
function get_Url(url, cb) {
    request('GET', url + '?access_token=' + access_token, null, cb, false)
}
function get_Repos(cb) {
    request('GET', '/user/repos?sort=updated&access_token=' + access_token, null, cb, true)
}
function get_IssuesOfRepo(user, repo, cb) {
    request('GET', '/repos/' + user + '/' + repo + '/issues' + '?access_token=' + access_token, null, cb, true)
}

