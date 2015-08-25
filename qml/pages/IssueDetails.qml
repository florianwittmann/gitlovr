import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Api.js" as API
import "../Helper.js" as Helper


Page {
    property var issue : null
    onVisibleChanged: {
        if(visible) {
            issue = currentIssue
            //API.get_Url(currentIssue.url, issueLoaded)
        }
    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        id: label
        Button {
            text: "Back"
            onClicked: currentSite = 3
        }


        Label {
            text: issue.title
            width: parent.width
            wrapMode:Text.Wrap
        }
        Label {
            text: issue.user.login
            width: parent.width
            wrapMode:Text.Wrap
        }
        Label {
            text: issue.body
            width: parent.width
            wrapMode:Text.Wrap
        }

        Label {
            text: "Created at: " + issue.created_at
        }
        Label {
            text: issue.comments + " Comments"
        }








    }
    function issueLoaded(data) {
        console.log(Helper.serialize(data))

        issue = data
    }
}
