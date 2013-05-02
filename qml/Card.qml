import QtQuick 2.0

Rectangle {
    id: card
    property alias title: t.text
    property alias description: desc.text
    property bool detailsVisible: false
    property bool synced: false
    property string status: "open"

    width: 300
    height: detailsVisible ? 100 : 30
    radius: 10
    border.color: synced ? "#008000" : "#6A8020"

    MouseArea {
        TextInput {
            id: t
            anchors.horizontalCenter: parent.horizontalCenter
            y: 5
            text: "Title"
            font.pointSize: 12
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
        }
        Image {
            source: "images/arrow-right.png"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 5
            MouseArea {
                anchors.fill: parent
                onClicked: card.status = "progress"
            }
        }

        anchors.fill: parent
        onPressed: t.forceActiveFocus()
        onReleased: detailsVisible = !detailsVisible
    }

    Behavior on height {
        NumberAnimation { duration: 100 }
    }
}

