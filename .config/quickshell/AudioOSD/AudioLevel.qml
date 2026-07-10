import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Overlay
    focusable: false
    anchors.bottom: true
    implicitWidth: 400
    implicitHeight: 60
    color: "transparent"
    mask: Region {}
    exclusiveZone: 0

    function percent(value: real): string {
        return `${String(Math.round(value * 100)).padStart(3, '0')} %`;
    }

    required property PwNodeAudio audio
    required property string label

    property bool muted: audio?.muted ?? false
    property real vol: audio?.volume ?? 0

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "#80000000"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 20
            spacing: 12

            CustomText {
                text: root.label
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 10
                radius: 20
                color: "#50ffffff"

                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    implicitWidth: parent.width * root.vol
                    color: root.muted ? "#ff5555" : "white"
                    radius: parent.radius
                }
            }

            CustomText {
                text: root.percent(root.vol)
            }
        }
    }
}
