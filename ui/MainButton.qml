import QtQuick 2.0


Rectangle {
    property alias text: label.text

    implicitWidth: parent.width
    implicitHeight: vpx(100)
    color: focus ? "#569" : "#335"
    radius: vpx(5)

    border.color: "#446"
    border.width: vpx(2)

    Text {
        id: label
        anchors.centerIn: parent
        color: "#dde"
        font {
            bold: true
            pixelSize: vpx(20)
        }
    }
}
