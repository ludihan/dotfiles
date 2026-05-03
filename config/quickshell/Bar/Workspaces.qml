import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Row {
    id: root

    property var workspaces
    property var focusedWindow

    function sendSocketCommand(sock, command) {
        if (sock.connected) {
            sock.write(JSON.stringify(command) + "\n");
            sock.flush();
        }
    }

    function request(command) {
        root.sendSocketCommand(niriRequestSocket, command);
    }

    Component.onCompleted: {
        if (niriEventStreamSocket.connected) {
            root.sendSocketCommand(niriEventStreamSocket, "EventStream");
        } else {
            console.warn("Niri event socket not connected on completed.");
        }

        if (niriRequestSocket.connected) {
            root.request("Workspaces");
            root.request("FocusedWindow");
        } else {
            console.warn("Niri request socket not connected on completed.");
        }
    }

    Socket {
        id: niriEventStreamSocket
        connected: true
        path: Quickshell.env("NIRI_SOCKET")

        parser: SplitParser {
            onRead: message => {
                const event = JSON.parse(message);

                root.request("Workspaces");
                root.request("FocusedWindow");

                if (event.WindowFocusChanged) {
                    if (event.WindowFocusChanged.id === null) {
                        root.focusedWindow = null;
                    }
                }
            }
        }
    }

    Socket {
        id: niriRequestSocket
        connected: true
        path: Quickshell.env("NIRI_SOCKET")

        parser: SplitParser {
            onRead: message => {
                const response = JSON.parse(message);

                if (response.Err) {
                    console.log(response.Err);
                    return;
                }

                const res = response.Ok;

                if (res.Workspaces) {
                    root.workspaces = res.Workspaces.sort((x, y) => x.idx - y.idx);
                }

                if (res.FocusedWindow) {
                    root.focusedWindow = res.FocusedWindow;
                }
            }
        }
    }

    RowLayout {
        spacing: 10
        RowLayout {
            spacing: 0
            Repeater {
                model: root.workspaces

                Rectangle {
                    property var ws: modelData
                    width: 22
                    height: 22

                    color: false ? "#505050" : "#111111"

                    CustomText {
                        anchors.centerIn: parent
                        text: index + 1
                        color: ws.is_active ? "white" : "#666666"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var cmd = {
                                "Action": {
                                    "FocusWorkspace": {
                                        reference: {
                                            Id: parent.ws.id
                                        }
                                    }
                                }
                            };
                            root.request(cmd);
                        }
                        onWheel: wheel => {
                            if (wheel.angleDelta.y < 0) {
                                var cmd = {
                                    "Action": {
                                        "FocusWorkspaceDown": {}
                                    }
                                };
                                root.request(cmd);
                            } else if (wheel.angleDelta.y > 0) {
                                var cmd = {
                                    "Action": {
                                        "FocusWorkspaceUp": {}
                                    }
                                };
                                root.request(cmd);
                            }
                        }
                    }
                }
            }
        }

        CustomText {
            text: root.focusedWindow ? root.focusedWindow.title : ""
            color: "#666666"
            Layout.preferredHeight: 22
            Layout.fillWidth: true
            Layout.maximumWidth: 1000
            verticalAlignment: Text.AlignVCenter
            clip: true
            elide: Text.ElideRight
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
