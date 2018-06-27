import QtQuick 2.0


Rectangle {
    property alias text: descText.text
    signal accepted

    anchors.fill: parent
    color: "#8f000000"

    Keys.onReturnPressed: accepted()

    property int boxPadding: vpx(30)
    property int buttonTextSize: vpx(18)
    property int buttonHeight: vpx(50)
    property color buttonBlue: "#18e"
    property color buttonWhite: "#eee"


    Rectangle {
        width: vpx(550)
        height: descText.height + boxPadding * 2 + buttonHeight
        anchors.centerIn: parent

        Text {
            id: descText
            color: "#111"
            font.pixelSize: vpx(20)
            wrapMode: Text.Wrap
            width: parent.width - boxPadding * 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top; anchors.topMargin: boxPadding
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: button
            width: parent.width
            height: buttonHeight
            color: buttonBlue
            anchors.bottom: parent.bottom

            Text {
                text: "Ok"
                color: buttonWhite
                font.pixelSize: buttonTextSize
                font.bold: true
                anchors.centerIn: parent
            }
        }
    }
}
