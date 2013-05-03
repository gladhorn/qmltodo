import QtQuick 2.1

Rectangle {
    id: card
    property alias title: t.text
    property alias description: desc.text
    property bool detailsVisible: t.activeFocus || desc.activeFocus
    property bool synced: false
    property string status: "open"

    signal syncTitle
    signal syncDescription

    property bool changed: false

    width: 300
    height: detailsVisible ? 100 : 30
    radius: 10
    border.color: synced ? "#008000" : "#6A8020"

    color: changed ? "#eeeeee" : "white"

    function doSync() {
        card.syncTitle()
        card.syncDescription()
        card.changed = false
    }

    MouseArea {
        TextInput {
            id: t
            anchors.horizontalCenter: parent.horizontalCenter
            y: 5
            text: "Title"
            font.pointSize: 12
            onTextChanged: card.changed = true
            activeFocusOnPress: true
            activeFocusOnTab: true
            onAccepted: doSync()
        }
        TextEdit {
            id: desc
            visible: detailsVisible
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: t.bottom
            anchors.bottom: parent.bottom
            anchors.margins: 10
            text: "Description"
            font.pointSize: 10
            onTextChanged: card.changed = true
            activeFocusOnPress: true
//            activeFocusOnTab: true
        }
        Image {
            id: rightArrow
            source: "images/arrow-right.png"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 5
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    card.status == "progress" ? card.status = "done" : card.status = "progress"
                    console.log("New card status: ", card.status)
                }
            }
            visible: card.status != "done"
        }
        Image {
            source: "images/dialog-ok.png"
            anchors.right: rightArrow.left
            anchors.top: parent.top
            anchors.margins: 5
            MouseArea {
                anchors.fill: parent
                onClicked: doSync()
            }
            visible: card.changed
        }
        Image {
            source: "images/arrow-left.png"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 5
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    card.status == "progress" ? card.status = "open" : card.status = "progress"
                    console.log("New card status: ", card.status)
                }
            }
            visible: card.status != "open"
        }
        anchors.fill: parent
        onPressed: t.forceActiveFocus()
        //onReleased: detailsVisible = !detailsVisible
    }

    Behavior on height {
        NumberAnimation { duration: 100 }
    }

    Component.onCompleted: changed = false
}

