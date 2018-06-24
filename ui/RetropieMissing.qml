import QtQuick 2.0


Rectangle {
    signal accepted

    anchors.fill: parent
    color: "#80000000"

    Keys.onReturnPressed: accepted()


    Rectangle {
        width: vpx(700)
        height: vpx(300)
        radius: vpx(10)
        anchors.centerIn: parent

        Text {
            id: errorLabel
            text: "Error"
            color: "#e11"
            font {
                bold: true
                pixelSize: vpx(30)
                capitalization: Font.AllUppercase
            }
            anchors.top: parent.top; anchors.topMargin: vpx(30);
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "This program is for RetroPie, but RetroPie doesn't seem to be installed. The program will now close."
            color: "#112"
            font.pixelSize: vpx(20)
            wrapMode: Text.Wrap
            width: parent.width - vpx(40)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: errorLabel.bottom; anchors.topMargin: vpx(15)
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: button
            width: parent.width * 0.6
            height: vpx(40)
            color: "#38c"
            radius: vpx(5)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: errorLabel.anchors.topMargin

            Text {
                text: "OK"
                color: "#eee"
                font.pixelSize: vpx(18)
                font.bold: true
                anchors.centerIn: parent
            }
        }
    }
}
