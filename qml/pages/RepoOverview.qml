import QtQuick 2.0
import Sailfish.Silica 1.0

import "../Api.js" as API
import "../Helper.js" as Helper


Page {

    Component.onCompleted: {
            console.log(currentRepo.url)
            API.get_Url(currentRepo.url, repoLoaded)

    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        id: label


        Row {

            spacing: 3
            Label {
                text: currentRepo.owner.login
                opacity: 0.7
            }

            Label {
                text: currentRepo.name
            }
        }
        Item {
            height: rowFork.height
            width: parent.width
            Row {
                id: rowFork
                visible: typeof(currentRepo.parent) != 'undefined'
                spacing: 3
                Label {
                    text: "Forked from"
                }
                Label {
                    text: currentRepo.parent.owner.login
                    opacity: 0.7
                }

                Label {
                    text: currentRepo.parent.name
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentRepo = currentRepo.parent
                }
            }
        }



        Label {
            text: currentRepo.description
            width: parent.width
            wrapMode:Text.Wrap
        }

        Label {
            text: currentRepo.stargazers_count + " stargazers"
        }

        Label {
            text: currentRepo.watchers_count + " watchers"
        }

        Label {
            text: currentRepo.forks_count + " forks"
        }
        Item {
            height: issuesLabel.height
            width: parent.width
            Label {
                id: issuesLabel
                text: currentRepo.open_issues_count + " open issues"

            }
            MouseArea {
                anchors.fill: parent
                onClicked: pageStack.push(Qt.resolvedUrl("IssuesPage.qml"))



            }
        }





    }
    function repoLoaded(data) {
        console.log(Helper.serialize(data))

        currentRepo =data
    }
}
