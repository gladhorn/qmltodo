/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import Enginio 1.0

import Qt.Model 1.0

ApplicationWindow {
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 300

    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem { text: "Quit"; onTriggered: Qt.quit() }
        }
        Menu {
            title: "Help"
            MenuItem { text: "About..."; enabled: false }
        }
    }

    Enginio {
        id: enginio
        backendId: "516d0cce698b3c49460010e5"
        backendSecret: "2de74ce890df2272b6c1059b8993d05e"
    }

    EnginioModel {
        id: cardList
        enginio: enginio
        query: {
            "objectType": "objects.card",
        }
        //"query": {"status": "open"}
    }

    SortFilterProxy {
        id: filter
//        model: cardList

    }

    Button {
        id: newButton
        text: "New todo"
        onClicked: cardList.append({"title": "TODO", "description": "description", "status": "open"})
        anchors.margins: 4
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    ListView {
        id: view
        model: filter
        x: 4
        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.bottom: newButton.top
        spacing: 2

        width: 300
        clip: true
        delegate: Card {
            title: model.title
            description: model.description
            synced: _synced
            onTitleChanged: timer.restart()
            onDescriptionChanged: timer.restart()
            onStatusChanged: timer.restart()

            Timer {
                id: timer
                running: false; repeat: false
                interval: 2000
                onTriggered: {
                    cardList.setProperty(index, "title", title)
                    cardList.setProperty(index, "description", description)
                    cardList.setProperty(index, "status", status)
                }
            }
        }
    }

    EnginioModel {
        id: inProgressModel
        enginio: enginio
        query: {
            "objectType": "objects.card",
            "query": {"status": "progress"}
        }
    }

    ListView {
        id: viewProgress
        model: inProgressModel
        x: 4 + 310
        height: 400
//        anchors.top: parent.top
//        anchors.topMargin: 2
//        anchors.bottom: row.top
        width: 300
        spacing: 2

        clip: true
        delegate: Card {
            title: model.title
            description: model.description
            synced: _synced
            onTitleChanged: {
                console.log("Setting new title: ", title)
                cardList.setProperty(index, title, "title")
            }
        }

    }
}
