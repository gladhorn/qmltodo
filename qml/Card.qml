import QtQuick 2.0

Rectangle {
    property alias title: t.text
    property alias description: desc.text
    property bool detailsVisible: false
    property bool synced: false

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

        anchors.fill: parent
        onReleased: detailsVisible = !detailsVisible
    }

    Behavior on height {
        NumberAnimation { duration: 100 }
    }
}

