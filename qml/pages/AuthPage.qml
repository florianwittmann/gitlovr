import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../urlParams.js" as URL
import "../Api.js" as API
import "../Helper.js" as Helper
import "../Sha.js" as SHA
import "../Storage.js" as Storage

import QtWebKit 3.0

Page {

    property string redirect_uri: "http://localhost:3850/Home/Auth"

    property string authState: "";

    property string auth_url: "https://github.com/login/oauth/authorize/?client_id=" + clientid
                              + "&scope=user+repo&redirect_uri=" + redirect_uri

    property bool showWebview: false

    property bool logout: false

    Column {
        id: col
        spacing: 15
        visible: !showWebview
        anchors.fill: parent

        Label {
            text: qsTr("Welcome.")
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            wrapMode: Text.Wrap
            textFormat: Text.RichText
            color: Theme.highlightColor
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Continue")
            onClicked: {
                authState = createState();
                webview.url = auth_url + "&state=" + authState
                webview.visible = true
                showWebview = true
            }
        }
    }

    WebView {
        id: webview
        visible: showWebview
        anchors.fill: parent
        onUrlChanged: {
            console.log("Auth: " + url)
            if (url.toString() === "")
                return

            if (url.toString().indexOf(redirect_uri) == 0) {
                //Success
                console.log(url)
                var params = URL.get_params(url.toString())
                console.log("Current state: " + authState)
                if (params.state === authState) {

                    API.authorize(params.code, SHA.Sha1.hash(params.code + authhash), authurl, authentificated)
                } else {
                    console.log("wrong state")
                }
            }

        }
    }

    function authentificated(data) {
        console.log(Helper.serialize(data))
        API.access_token = data.access_token
        console.log(API.access_token)
        Storage.set("authtoken", API.access_token)
        pageStack.replace(Qt.resolvedUrl("StartPage.qml"))
    }

    function createState()
    {
        var state = "";
        var allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        for( var i=0; i < 20; i++ ) {
            state += allowedChars.charAt(Math.floor(Math.random() * allowedChars.length));
        }
        return state;
    }
}
