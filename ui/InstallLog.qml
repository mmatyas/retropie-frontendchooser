import QtQuick 2.0

FocusScope {
    property bool taskRunning: installer.taskRunning
    property bool taskFailed: installer.taskFailed
    property string logText: installer.log
    property int boxPadding: vpx(20)

    signal close

    anchors.fill: parent


    Rectangle {
        anchors.fill: parent
        color: "#8f000000"
    }

    Rectangle {
        width: parent.width * 0.95
        height: parent.height * 0.95
        anchors.centerIn: parent
        color: "#334"
        border.color: "#112"
        border.width: vpx(2)
        radius: vpx(10)

        Text {
            id: title
            text: "Installation"
            color: "#dde"
            font.bold: true
            font.pixelSize: vpx(35)

            anchors.left: parent.left; anchors.leftMargin: boxPadding * 1.5
            anchors.top: parent.top; anchors.topMargin: boxPadding
        }

        Rectangle {
            anchors {
                top: title.bottom; bottom: button.top
                left: parent.left; right: parent.right
                margins: boxPadding
            }
            radius: vpx(5)
            color: "#112"
            clip: true

            Flickable {
                anchors.fill: parent
                anchors.margins: vpx(10)
                contentHeight: log.height
                contentY: Math.max(contentHeight - height, 0);

                Text {
                    id: log
                    text: logText
                    width: parent.width
                    color: "#cce"
                    font.pixelSize: vpx(14)
                    font.family: "monospace"
                    wrapMode: Text.Wrap
                }
            }
        }

        Rectangle {
            id: button
            width: parent.width * 0.25
            height: vpx(50)
            color: taskRunning ? "#445" : "#3d4"
            radius: vpx(5)
            anchors.right: parent.right; anchors.rightMargin: boxPadding
            anchors.bottom: parent.bottom; anchors.bottomMargin: boxPadding

            function closeWindow() {
                if (!taskRunning)
                    close();
            }

            focus: true
            Keys.onEnterPressed: closeWindow()
            Keys.onReturnPressed: closeWindow()

            Text {
                text: taskRunning ? "Please wait..." : "Ok"
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: vpx(18)
                color: taskRunning ? "#778" : "#eee"
            }
        }

        Text {
            text: "The installation has failed -- check the log for more details."
            color: "#e11"
            font.bold: true
            font.pixelSize: vpx(18)

            visible: taskFailed

            anchors.left: parent.left; anchors.leftMargin: boxPadding
            anchors.verticalCenter: button.verticalCenter
        }
    }
}
