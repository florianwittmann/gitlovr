import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Api.js" as API
import "../Helper.js" as Helper

Page {

    allowedOrientations: Orientation.All
    property var repo;

    property var issuesData : null


    Component.onCompleted: {
        API.get_IssuesOfRepo(repo.owner.login, repo.name, issuesLoaded)
    }

    SilicaListView {
        anchors.fill: parent
        model: issuesModel
        header: PageHeader {
            id: page_header
            title: "Issues"
        }

        delegate: BackgroundItem {
            height: issue.height + Theme.paddingSmall*2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge

            Column {
                anchors.verticalCenter: parent.verticalCenter
                id: issue
                Column {
                    spacing: 3

                    Label {
                        text: title
                        color: highlighted ? Theme.highlightColor : Theme.primaryColor

                    }

                    Label {
                        text: "#" + number + " opened by " + user.login
                        font.pixelSize: Theme.fontSizeSmall
                        color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                    }
                }
            }


            onClicked: {
                pageStack.push(Qt.resolvedUrl("IssueDetails.qml"),{issue:issuesData[index]})
            }

        }
    }

    ListModel {
        id: issuesModel
    }

    function issuesLoaded(data) {
        issuesModel.clear()
        for (var i = 0; i < data.length; i++) {
            issuesModel.append(data[i])
        }
        issuesData = data
    }

}
