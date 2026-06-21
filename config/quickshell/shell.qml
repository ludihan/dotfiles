//@ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Io
import qs.Bar
import qs.AudioOSD
import qs.Mixer
import qs.Lock

ShellRoot {
    Loader {
        id: audioOSD
        sourceComponent: AudioOSD {}
    }
    Loader {
        sourceComponent: Bar {}
    }
    Loader {
        sourceComponent: Background {}
    }

    Loader {
        id: mixer

        sourceComponent: Mixer {
            onEscape: () => {
                mixer.item.visible = false;
                audioOSD.active = !audioOSD.active;
            }
        }
        Component.onCompleted: {
            mixer.item.visible = false;
        }
    }

    Loader {
        id: launcher

        sourceComponent: Launcher {}
        Component.onCompleted: {
            launcher.item.visible = false;
        }
    }

    Loader {
        id: lock
        sourceComponent: Lock {}
    }

    Loader {
        id: notification
        sourceComponent: Notification {}
    }

    IpcHandler {
        target: "mixer"

        function open() {
            audioOSD.active = !audioOSD.active;
            launcher.item.visible = false;
            mixer.item.visible = !mixer.item.visible;
        }
    }

    IpcHandler {
        target: "launcher"

        function open() {
            launcher.item.clear();
            mixer.item.visible = false;
            launcher.item.visible = !launcher.item.visible;
        }
    }

    IpcHandler {
        target: "lock"

        function lock() {
            lock.item.lock();
        }
    }
}
