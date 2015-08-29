import QtQuick 2.0
import Sailfish.Silica 1.0

import "../Api.js" as API
import "../Helper.js" as Helper


Page {
    allowedOrientations: Orientation.All

    property var reposData : null

    onVisibleChanged: {
        if(visible && reposData == null) {
            API.get_Repos(reposLoaded)
        }
    }

    SilicaListView {
        anchors.fill: parent

        header: PageHeader {
            id: page_header
            title: "Your repositories"
        }


        model: repoModel
        delegate: BackgroundItem {
            height: repo.height + Theme.paddingSmall*2
            anchors.left: parent.left
            anchors.right: parent.right

            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                anchors.verticalCenter: parent.verticalCenter
                id: repo
                Row {

                    Label {
                        text: owner.login
                        opacity: 0.7
                        color: highlighted ? Theme.highlightColor : Theme.primaryColor
                    }

                    Label {
                        text: " / "
                        opacity: 0.7
                        color: highlighted ? Theme.highlightColor : Theme.primaryColor
                    }

                    Label {
                        text: name
                        color: highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                }
                Row {
                    Label {
                        text: stargazers_count + " stargazers"
                        font.pixelSize: Theme.fontSizeSmall
                        color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                    }
                }
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl("RepoOverview.qml"),{repo:reposData[index]})
            }


        }
        VerticalScrollDecorator {}
    }

    ListModel {
        id: repoModel
    }


    function reposLoaded(data) {
        repoModel.clear()
        for (var i = 0; i < data.length; i++) {
            repoModel.append(data[i])
        }
        reposData = data
    }

}
