import QtQuick 2.0


FocusScope {
    id: root

    property string frontendName

    signal accept
    signal cancel

    anchors.fill: parent
    Keys.onEscapePressed: cancel()

    property int boxPadding: vpx(30)
    property int buttonTextSize: vpx(18)
    property int buttonHeight: vpx(50)
    property color buttonGreen: "#3d4"
    property color buttonRed: "#d43"
    property color buttonWhite: "#eee"

    Rectangle {
        anchors.fill: parent
        color: "#8f000000"
    }

    Rectangle {
        width: vpx(530)
        height: descText.height + boxPadding * 2 + buttonHeight
        anchors.centerIn: parent

        Text {
            id: descText
            text: "The selected frontend (%1) is not yet installed. Would you like to install it now?".arg(frontendName)
            color: "#111"
            font.pixelSize: vpx(20)
            wrapMode: Text.Wrap
            width: parent.width - boxPadding * 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top; anchors.topMargin: vpx(30)
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: buttonOk
            width: parent.width * 0.5
            height: buttonHeight
            color: focus ? buttonGreen : Qt.lighter(buttonGreen)
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            Keys.onReturnPressed: root.accept()
            Keys.onEnterPressed: root.accept()

            Text {
                text: "Ok"
                color: buttonWhite
                font.pixelSize: buttonTextSize
                font.bold: true
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: buttonCancel
            width: buttonOk.width
            height: buttonHeight
            color: focus ? buttonRed : Qt.lighter(buttonRed)
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            focus: true
            KeyNavigation.left: buttonOk
            Keys.onReturnPressed: root.cancel()
            Keys.onEnterPressed: root.cancel()

            Text {
                text: "Cancel"
                color: buttonWhite
                font.pixelSize: buttonTextSize
                font.bold: true
                anchors.centerIn: parent
            }
        }
    }
}
