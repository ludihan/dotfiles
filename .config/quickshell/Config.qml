pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property string background: "#1A1A1A"
    readonly property string foreground: "#FFFFFF"
    readonly property string muted: "#777777"
    readonly property string fontFamily: "Iosevka"
    readonly property int fontPointSize: 12
    readonly property string socketPath: Quickshell.env("NIRI_SOCKET")
    readonly property int iconSize: 18
    readonly property color highlight: "#505050"
}
