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


    Title {
        id: mainTitle

        anchors.top: parent.top
        anchors.topMargin: windowMargin
        anchors.left: grid.left
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
        anchors.topMargin: vpx(50)
        anchors.horizontalCenter: parent.horizontalCenter

        width: vpx(1180)
        height: cellHeight * 2
        clip: true

        model: frontendModel
        delegate: FrontendDelegate {
            width: grid.cellWidth
            height: grid.cellHeight
            selected: GridView.isCurrentItem && grid.focus
            itemName: model.name
            itemDesc: model.desc
            itemLogo: "qrc:/ui/logo/" + model.logo
        }

        cellWidth: width / 2
        cellHeight: vpx(170)

        focus: true
        KeyNavigation.down: rebootButton
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
