import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import qs

ColumnLayout {
    required property PwNode node

    // bind the node so we can read its properties
    PwObjectTracker {
        objects: [node]
    }

    RowLayout {
        Label {
            color: "#FFFFFF"
            font.family: Config.fontFamily
            font.pixelSize: 18
            elide: Text.ElideRight
            Layout.maximumWidth: 400
            Layout.minimumWidth: 400
            text: {
                // application.name -> description -> name
                const app = node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
                const media = node.properties["media.name"];
                return media != undefined ? `${app} - ${media}` : app;
            }
        }

        Slider {
            id: control
            Layout.fillWidth: true
            value: node.audio.volume
            background: Rectangle {
                x: control.leftPadding
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 4
                width: control.availableWidth
                height: implicitHeight
                radius: 2
                color: Config.muted

                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    color: "white"
                    radius: 2
                }
            }

            handle: Rectangle {
                x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 20
                implicitHeight: 20
                radius: 13
                color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }

            onValueChanged: node.audio.volume = value
        }

        Label {
            color: "#FFFFFF"
            font.family: Config.fontFamily
            font.pixelSize: 18
            Layout.preferredWidth: 50
            text: `${Math.floor(node.audio.volume * 100)}%`
        }

        Button {
            text: node.audio.muted ? "unmute" : "mute"
            font.family: Config.fontFamily
            font.pixelSize: 18
            onClicked: node.audio.muted = !node.audio.muted
        }
    }

    RowLayout {}
}
