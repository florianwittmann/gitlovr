import QtQuick 2.0
import Sailfish.Silica 1.0

import "../Api.js" as API
import "../Helper.js" as Helper


Page {

    property var reposData : null

    onVisibleChanged: {
        if(visible && reposData == null) {
            API.get_Repos(reposLoaded)
        }
    }

    SilicaListView {
        anchors.fill: parent
        model: repoModel
        delegate: Item {
            height: label.height
            anchors.left: parent.left
            anchors.right: parent.right

            Column {
                id: label
                Row {

                    spacing: 3
                    Label {
                        text: owner.login
                        opacity: 0.7
                    }

                    Label {
                        text: name
                    }
                }
                Row {
                    Label {
                        text: stargazers_count + " stargazers"
                    }
                }
            }




            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentRepo = reposData[index]
                    pageStack.push(Qt.resolvedUrl("RepoOverview.qml"))
                }
            }
        }
    }

    ListModel {
        id: repoModel
    }


    function reposLoaded(data) {
        console.log(Helper.serialize(data))
        repoModel.clear()
        for (var i = 0; i < data.length; i++) {
            repoModel.append(data[i])
        }
        reposData = data
    }

}
