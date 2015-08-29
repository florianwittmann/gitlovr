import QtQuick 2.0
import Sailfish.Silica 1.0

import "../Api.js" as API
import "../Helper.js" as Helper


Page {
    allowedOrientations: Orientation.All

    property var repo;

    Component.onCompleted: {
        API.get_Url(repo.url, repoLoaded)

    }


    SilicaFlickable {
        anchors.fill: parent
        contentHeight: repoOverviewCol.height

        Column {
            anchors.left: parent.left
            anchors.right: parent.right
            id: repoOverviewCol
            PageHeader {
                id: page_header
                title: repo.owner.login + " / " + repo.name
            }

            BackgroundItem {
                height: Theme.itemSizeMedium
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                visible: typeof(repo.parent) != 'undefined'

                Row {

                    anchors.verticalCenter: parent.verticalCenter
                    id: rowFork
                    Label {
                        text: "Forked from "
                    }
                    Label {
                        text:  typeof(repo.parent) != 'undefined' ? repo.parent.owner.login : ""
                        opacity: 0.7
                    }
                    Label {
                        text: " / "
                        opacity: 0.7
                    }

                    Label {
                        text: typeof(repo.parent) != 'undefined' ? repo.parent.name : ""
                    }
                }
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("RepoOverview.qml"),{repo: repo.parent})
                }

            }



            Label {
                anchors.topMargin: Theme.paddingSmall
                anchors.bottomMargin: Theme.paddingSmall
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                text: repo.description
                color: Theme.secondaryHighlightColor
                wrapMode:Text.Wrap
            }

            BackgroundItem {
                height: Theme.itemSizeMedium
                width: parent.width

                Label {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    text: repo.stargazers_count + " stargazers"
                }


            }

            BackgroundItem {
                height: Theme.itemSizeMedium
                width: parent.width

                Label {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    text: repo.watchers_count + " watchers"

                }

            }

            BackgroundItem {
                height: Theme.itemSizeMedium
                width: parent.width
                Label {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    text: repo.forks_count + " forks"
                }

            }
            BackgroundItem {
                height: Theme.itemSizeMedium
                width: parent.width
                Label {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.rightMargin: Theme.paddingLarge
                    id: issuesLabel
                    anchors.verticalCenter: parent.verticalCenter
                    text: repo.open_issues_count + " open issues"

                }

                onClicked: pageStack.push(Qt.resolvedUrl("IssuesPage.qml"),{repo:repo})




            }





        }
        VerticalScrollDecorator {}

    }

    function repoLoaded(data) {
        repo =data
    }
}
