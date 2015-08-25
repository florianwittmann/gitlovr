import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Api.js" as API
import "../Helper.js" as Helper

Page {

    property var issuesData : null

    onVisibleChanged: {
        if(visible && currentRepo != null) {
            API.get_IssuesOfRepo(currentRepo.owner.login, currentRepo.name, issuesLoaded)
        }
    }

    Button {
        text: "Back"
        onClicked: currentSite =2
        anchors.top: parent.top
        id: backBtn
    }

    ListView {
        anchors.top: backBtn.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: issuesModel
        delegate: Item {
            height: label.height
            anchors.left: parent.left
            anchors.right: parent.right

            Column {
                id: label
                Row {

                    spacing: 3

                    Label {
                        text: title
                    }
                }


            }




            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentIssue = issuesData[index]
                    pageStack.push(Qt.resolvedUrl("IssueDetails.qml"))
                }
            }
        }
    }

    ListModel {
        id: issuesModel
    }

    function issuesLoaded(data) {
        console.log(Helper.serialize(data))
        issuesModel.clear()
        for (var i = 0; i < data.length; i++) {
            issuesModel.append(data[i])
        }
        issuesData = data
    }

}
