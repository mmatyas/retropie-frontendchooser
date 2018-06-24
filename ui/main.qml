import QtQuick 2.0
import QtQuick.Window 2.0


Window {
    visible: true
    width: 1280
    height: 720
    color: "#223"
    title: qsTr("Frontend Chooser for RetroPie")

    property real winScale: Math.min(width / 1280.0, height / 720.0)
    function vpx(value) {
        return winScale * value;
    }

    readonly property int windowMargin: vpx(30)

    Text {
        id: mainTitle
        text: "Frontend Chooser"
        color: "#dde"
        font {
            bold: true
            pixelSize: vpx(40)
        }

        anchors.top: parent.top
        anchors.topMargin: windowMargin
        anchors.left: grid.left
    }

    Text {
        text: "for RetroPie"
        color: "#dde"
        font {
            pixelSize: vpx(20)
        }

        anchors.baseline: mainTitle.baseline
        anchors.left: mainTitle.right
        anchors.leftMargin: font.pixelSize
    }

    ListModel {
        id: frontendModel
        ListElement {
            name: "EmulationStation"
            desc: "Frontend used by RetroPie for launching emulators (default)"
            logo: "es.png"
        }
        ListElement {
            name: "AttractMode"
            desc: "Attract-Mode is a graphical frontend for command line emulators such as MAME, MESS and Nestopia."
            logo: "attract.png"
        }
        ListElement {
            name: "mehstation"
            desc: "Open-source frontend launcher for your retrobox."
            logo: "meh.png"
        }
        ListElement {
            name: "Pegasus"
            desc: "A graphical frontend for browsing your game library and launching all kinds of emulators from the same place."
            logo: "pegasus.png"
        }
    }

    GridView {
        id: grid
        anchors.top: mainTitle.bottom
        anchors.topMargin: vpx(58)
        //anchors.bottom: buttons.top
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.centerIn: parent
        width: vpx(1180)
        height: cellHeight * 2
        clip: true

        model: frontendModel
        delegate: frontendDelegate

        cellWidth: width / 2
        cellHeight: vpx(170)

        focus: true
        KeyNavigation.down: rebootButton
    }

    Component {
        id: frontendDelegate

        Item {
            width: grid.cellWidth
            height: grid.cellHeight

            property bool selected: GridView.isCurrentItem && grid.focus

            Rectangle {
                width: parent.width - vpx(10)
                height: parent.height - vpx(10)
                anchors.centerIn: parent
                color: selected ? "#579" : "#556"
                border.color: "#112"

                Image {
                    id: logo
                    asynchronous: true
                    smooth: true
                    height: parent.height - vpx(30)
                    width: parent.width * 0.3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: vpx(15)
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/ui/logo/" + model.logo
                }

                Text {
                    id: name
                    anchors.left: logo.right; anchors.leftMargin: vpx(20)
                    anchors.top: parent.top; anchors.topMargin: vpx(20)
                    text: model.name
                    color: "#dde"
                    font {
                        bold: true
                        pixelSize: vpx(20)
                    }
                }

                Text {
                    anchors {
                        left: logo.right; leftMargin: vpx(20)
                        top: name.bottom; topMargin: vpx(10)
                        bottom: parent.bottom; bottomMargin: vpx(20)
                        right: parent.right; rightMargin: vpx(15)
                    }
                    text: model.desc
                    color: "#dde"
                    font {
                        pixelSize: vpx(16)
                    }
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    Column {
        id: buttons
        width: vpx(600)
        spacing: vpx(5)

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: windowMargin

        MainButton {
            id: rebootButton
            text: "Reboot device"
            height: vpx(80)

            KeyNavigation.down: quitButton
        }
        MainButton {
            id: quitButton
            text: "Quit"
            height: vpx(50)
        }
    }
}
