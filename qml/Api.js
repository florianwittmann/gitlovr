.pragma library

var BASE="https://api.github.com"
var access_token = "";

function request(verb, endpoint, obj, cb, includeBase) {
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

function authorize(code, hash, url, cb) {
    request('GET', url + code + '/' + hash , null, cb, false)
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

