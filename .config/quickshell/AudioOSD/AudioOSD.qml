import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

Scope {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    Timer {
        id: osdTimer
        interval: 1000
        onTriggered: root.showOsd = false
    }

    property bool showOsd: false

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.showOsd = true;
            osdTimer.restart();
        }

        function onMutedChanged() {
            root.showOsd = true;
            osdTimer.restart();
        }
    }

    Connections {
        target: Pipewire.defaultAudioSource?.audio

        function onVolumeChanged() {
            root.showOsd = true;
            osdTimer.restart();
        }

        function onMutedChanged() {
            root.showOsd = true;
            osdTimer.restart();
        }
    }

    LazyLoader {
        active: root.showOsd

        RowLayout {
            anchors.bottomMargin: 1
            AudioLevel {
                label: "VOL"
                margins.bottom: screen.height / 8
                audio: Pipewire.defaultAudioSink?.audio
            }
            AudioLevel {
                label: "MIC"
                margins.bottom: screen.height / 5
                audio: Pipewire.defaultAudioSource?.audio
            }
        }
    }
}
