import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Api.js" as API
import "../Helper.js" as Helper


Page {
    property var issue
    allowedOrientations: Orientation.All


    SilicaFlickable {
        anchors.fill: parent
        contentHeight: issueDetail.height
        Column {
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: Theme.paddingSmall
            id: issueDetail


            PageHeader {
                id: page_header
                title: "Issue #" + issue.number
            }


            Label {
                text: issue.title
                width: parent.width
                wrapMode:Text.Wrap
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Label {
                text: "Opened by " + issue.user.login
                width: parent.width
                wrapMode:Text.Wrap
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                color: Theme.secondaryHighlightColor

            }
            Label {
                text: issue.body
                width: parent.width
                wrapMode:Text.Wrap
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                color: Theme.secondaryHighlightColor

            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                text: "Created at: " + issue.created_at
                color: Theme.secondaryHighlightColor

            }
            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge
                text: issue.comments + " Comments"
                color: Theme.primaryColor

            }

        }
        VerticalScrollDecorator {}
    }


}
