pragma ComponentBehavior: Bound
import Quickshell.Services.UPower
import Quickshell.Services.Notifications
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs

Scope {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
            diskProc.running = true;
        }
    }

    Process {
        id: memProc
        property int memUsage: 0
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var total = parseInt(parts[1]) || 1;
                var used = parseInt(parts[2]) || 0;
                memProc.memUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: cpuProc
        property int cpuUsage: 0
        property var lastCpuIdle: 0
        property var lastCpuTotal: 0
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var user = parseInt(parts[1]) || 0;
                var nice = parseInt(parts[2]) || 0;
                var system = parseInt(parts[3]) || 0;
                var idle = parseInt(parts[4]) || 0;
                var iowait = parseInt(parts[5]) || 0;
                var irq = parseInt(parts[6]) || 0;
                var softirq = parseInt(parts[7]) || 0;

                var total = user + nice + system + idle + iowait + irq + softirq;
                var idleTime = idle + iowait;

                if (cpuProc.lastCpuTotal > 0) {
                    var totalDiff = total - cpuProc.lastCpuTotal;
                    var idleDiff = idleTime - cpuProc.lastCpuIdle;
                    if (totalDiff > 0) {
                        cpuProc.cpuUsage = Math.round(100 * (totalDiff - idleDiff) / totalDiff);
                    }
                }
                cpuProc.lastCpuTotal = total;
                cpuProc.lastCpuIdle = idleTime;
            }
        }

        Component.onCompleted: running = true
    }

    Process {
        id: diskProc
        property int diskUsage: 0
        command: ["sh", "-c", "df / | tail -1"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var percentStr = parts[4] || "0%";
                diskProc.diskUsage = parseInt(percentStr.replace('%', '')) || 0;
            }
        }
        Component.onCompleted: running = true
    }

    Variants {
        model: Quickshell.screens
        delegate: PanelWindow {
            id: root
            function percent(label: string, value: int): string {
                return `${label}: ${String(value).padStart(3, '0')} %`;
            }
            required property var modelData
            screen: modelData
            implicitHeight: 22

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent
                color: "#111111"

                RowLayout {
                    anchors.fill: parent
                    anchors.rightMargin: 5
                    spacing: 15

                    Workspaces {}

                    Item {
                        Layout.fillWidth: true
                    }

                    Tray {
                        window: root
                    }

                    Separator {}

                    CustomText {
                        text: `BAT: ${UPower.displayDevice.percentage * 100}%`
                    }

                    Separator {}

                    CustomText {
                        text: root.percent("CPU", cpuProc.cpuUsage)
                    }

                    Separator {}

                    CustomText {
                        text: root.percent("MEM", memProc.memUsage)
                    }

                    Separator {}

                    CustomText {
                        text: root.percent("DISK", diskProc.diskUsage)
                    }

                    Separator {}

                    CustomText {
                        text: Qt.formatDateTime(clock.date, "hh:mm:ss - yyyy-MM-dd")
                    }
                }
            }
        }
    }
}
