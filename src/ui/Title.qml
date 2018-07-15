import QtQuick 2.0

Row {
    spacing: mainLabel.font.pixelSize / 3

    Text {
        id: mainLabel
        text: "Frontend Chooser"
        color: "#dde"
        font.bold: true
        font.pixelSize: vpx(45)
    }

    Text {
        text: "for RetroPie"
        color: "#dde"
        font.pixelSize: vpx(20)

        anchors.baseline: mainLabel.baseline
    }
}
