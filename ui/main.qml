import QtQuick 2.0
import QtQuick.Window 2.0
import QtGamepad 1.0


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

    Component.onCompleted: {
        if (!installer.retropieAvailable)
            retropieMissing.focus = true;
    }


    Gamepad {
        id: gamepad1
        deviceId: GamepadManager.connectedGamepads.length > 0 ? GamepadManager.connectedGamepads[0] : -1
    }
    Connections {
        target: GamepadManager
        onGamepadConnected: gamepad1.deviceId = deviceId
    }
    GamepadKeyNavigation {
        id: gamepadKeyNavigation
        gamepad: gamepad1
        active: true
    }

    Title {
        id: mainTitle

        anchors.top: parent.top
        anchors.topMargin: windowMargin
        anchors.left: grid.left
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
            autostarting: autorun.isAutostarting(model.modelData)

            Connections {
                target: autorun
                onSettingsChanged: autostarting = autorun.isAutostarting(model.modelData)
            }

            function enter() {
                if (installer.installed(model.modelData)) {
                    if (!autorun.setAsDefault(model.modelData))
                        autorunSetDefaultFailed.focus = true;
                }
                else {
                    installQuestion.frontend = model.modelData;
                    installQuestion.focus = true;
                }
            }

            Keys.onReturnPressed: enter()
            Keys.onEnterPressed: enter()
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

            onPressed: rebootQuestion.focus = true
            KeyNavigation.down: quitButton
        }
        MainButton {
            id: quitButton
            text: "Quit"
            height: vpx(50)

            onPressed: close()
        }
    }

    Question {
        id: installQuestion

        property var frontend: undefined

        text: "The selected frontend (%1) is not yet installed. Would you like to install it now?\nThis may require admin (`sudo`) rights."
            .arg(frontend ? frontend.name : "")

        onCancel: grid.focus = true
        onAccept: {
            installer.startInstall(frontend);
            installLog.focus = true;
        }
    }

    InstallLog {
        id: installLog
        onClose: grid.focus = true
    }

    Question {
        id: rebootQuestion

        text: "The system will reboot. Are you sure?\nThis may require admin rights."

        onCancel: rebootButton.focus = true
        onAccept: system.reboot()
    }

    Message {
        id: autorunSetDefaultFailed
        text: "ERROR: Could not change the autoruns file. Perhaps it's write-protected?"
        onAccepted: grid.focus = true
    }

    Message {
        id: retropieMissing
        text: "ERROR: This program is for RetroPie, but RetroPie doesn't seem to be installed. The program will now close."
        onAccepted: close()
    }
}
