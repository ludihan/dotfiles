import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs

PanelWindow {
    id: root

    function clear() {
        searchBox.clear();
    }

    function closeWindow() {
        searchBox.clear();
        root.visible = false;
    }

    function launchCurrent() {
        if (appList.currentItem) {
            appList.currentItem.launchApp();
        }
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    implicitWidth: 400
    implicitHeight: 600
    color: "#1A1A1A"

    MouseArea {
        anchors.fill: parent
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15

        TextField {
            id: searchBox
            Layout.fillWidth: true
            font.family: Config.fontFamily
            font.pixelSize: 22
            color: Config.foreground
            focus: true

            background: Rectangle {
                color: "#1A1A1A"
            }

            Keys.onEscapePressed: root.closeWindow()
            Keys.onReturnPressed: root.launchCurrent()
            Keys.onEnterPressed: root.launchCurrent()
            Keys.onDownPressed: {
                appList.incrementCurrentIndex();
            }
            Keys.onUpPressed: {
                appList.decrementCurrentIndex();
            }
            Keys.onPressed: event => {
                if (event.modifiers & Qt.ControlModifier) {
                    switch (event.key) {
                    case Qt.Key_N:
                        event.accepted = true;
                        appList.incrementCurrentIndex();
                        break;
                    case Qt.Key_P:
                        event.accepted = true;
                        appList.decrementCurrentIndex();
                        break;
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: Config.muted
            opacity: 0.5
        }

        ListView {
            id: appList
            highlightFollowsCurrentItem: true
            highlightMoveDuration: 0
            highlightMoveVelocity: -1
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            moveDisplaced: Transition {
                NumberAnimation {
                    properties: "x,y"
                    duration: 0
                }
            }

            model: ScriptModel {
                property var additionalFilters: (x => !x.keywords.includes("lsp-plugins"))
                values: DesktopEntries.applications.values.filter(x => [x.name, x.genericName, x.execString, x.comment, x.execString, ...x.categories, ...x.keywords].map(x => x.toLowerCase()).some(x => x.includes(searchBox.text.toLowerCase())) && additionalFilters(x))
            }
            delegate: ItemDelegate {
                id: delegateRoot
                width: ListView.view.width
                height: 45

                function launchApp() {
                    console.log("Launching: " + modelData.name);
                    if (!modelData.runInTerminal) {
                        modelData.execute();
                    } else {
                        Quickshell.execDetached({
                            command: ["foot", ...modelData.command],
                            workingDirectory: modelData.workingDirectory
                        });
                    }
                    root.closeWindow();
                }

                background: Rectangle {
                    readonly property bool isSelected: delegateRoot.ListView.isCurrentItem
                    color: isSelected ? Config.highlight : "transparent"
                }

                contentItem: RowLayout {
                    spacing: 10

                    Label {
                        text: modelData.name
                        Layout.fillWidth: true
                        font.family: Config.fontFamily
                        font.pixelSize: 18
                        color: Config.foreground
                        elide: Text.ElideRight
                    }
                }

                onClicked: launchApp()

                MouseArea {
                    anchors.fill: parent
                    onEntered: appList.currentIndex = index
                    onClicked: delegateRoot.launchApp()
                }
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            searchBox.forceActiveFocus();
            searchBox.text = "";
            appList.currentIndex = 0;
        }
    }
}
