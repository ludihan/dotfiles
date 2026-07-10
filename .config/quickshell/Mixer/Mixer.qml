import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import Quickshell.Services.Mpris
import qs

PanelWindow {
    id: root
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    implicitWidth: 800
    implicitHeight: 800
    required property var onEscape
    // match the system theme background color
    color: "#1A1A1A"

    ScrollView {
        focus: true
        Keys.onEscapePressed: onEscape()// root.visible = false
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10

            // get a list of nodes that output to the default sink
            PwNodeLinkTracker {
                id: linkTracker
                node: Pipewire.defaultAudioSink
            }

            MixerEntry {
                node: Pipewire.defaultAudioSink
            }

            Rectangle {
                Layout.fillWidth: true
                color: Config.muted
                implicitHeight: 1
            }

            Repeater {
                model: linkTracker.linkGroups

                MixerEntry {
                    required property PwLinkGroup modelData
                    // Each link group contains a source and a target.
                    // Since the target is the default sink, we want the source.
                    node: modelData.source
                }
            }

            Rectangle {
                Layout.fillWidth: true
                color: Config.muted
                implicitHeight: 1
            }

            Repeater {
                model: Mpris.players

                ColumnLayout {
                    id: mpris
                    required property MprisPlayer modelData
                    RowLayout {
                        Label {
                            color: "#FFFFFF"
                            font.family: Config.fontFamily
                            font.pixelSize: 18
                            elide: Text.ElideRight
                            Layout.minimumWidth: 695
                            Layout.maximumWidth: 695
                            text: [mpris.modelData.identity || "Unkown Application", mpris.modelData.trackArtists || "Unknown Artists", mpris.modelData.trackTitle || "Unknown Track", mpris.modelData.trackAlbum || "Unknown Album",].join(" - ")
                        }
                    }
                    RowLayout {
                        ColumnLayout {
                            Layout.preferredWidth: 500
                            RowLayout {
                                Button {
                                    text: "Quit"
                                    font.family: Config.fontFamily
                                    font.pixelSize: 18
                                    onClicked: mpris.modelData.quit()
                                }
                            }
                            RowLayout {
                                Button {
                                    text: "Stop"
                                    font.family: Config.fontFamily
                                    font.pixelSize: 18
                                    onClicked: mpris.modelData.stop()
                                }
                                Button {
                                    text: "Previous"
                                    font.family: Config.fontFamily
                                    font.pixelSize: 18
                                    onClicked: mpris.modelData.previous()
                                }
                                Button {
                                    text: "Pause/Play"
                                    font.family: Config.fontFamily
                                    font.pixelSize: 18
                                    onClicked: mpris.modelData.togglePlaying()
                                }
                                Button {
                                    text: "Next"
                                    font.family: Config.fontFamily
                                    font.pixelSize: 18
                                    onClicked: mpris.modelData.next()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
