import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    WlrLayershell.layer: WlrLayer.Background
    exclusionMode: ExclusionMode.Ignore

    Rectangle {
        id: desktopBackground
        width: parent.width
        height: parent.height
        color: "#222222"
    }
}
