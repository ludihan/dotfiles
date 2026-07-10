pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.SystemTray
import Quickshell
import Quickshell.Widgets
import qs

Row {
    id: systemTrayContainer
    property QsWindow window

    spacing: 2

    Repeater {
        model: SystemTray.items

        delegate: Rectangle {
            id: trayItem
            width: Config.iconSize
            height: Config.iconSize
            color: "transparent"

            required property SystemTrayItem modelData

            IconImage {
                id: icon
                anchors.centerIn: parent
                width: Config.iconSize
                height: Config.iconSize
                source: trayItem.modelData.icon
                visible: true

                MouseArea {
                    id: area
                    anchors.fill: parent
                    acceptedButtons: Qt.AllButtons

                    onClicked: mouse => {
                        switch (mouse.button) {
                        case Qt.LeftButton:
                            trayItem.modelData.activate();
                            break;
                        case Qt.MiddleButton:
                            trayItem.modelData.secondaryActivate();
                            break;
                        case Qt.RightButton:
                            var globalPos = area.mapToGlobal(mouse.x, mouse.y);

                            trayItem.modelData.display(systemTrayContainer.window, globalPos.x, globalPos.y);
                            break;
                        }
                    }
                }
            }
        }
    }
}
