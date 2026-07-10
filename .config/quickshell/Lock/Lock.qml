import Quickshell.Wayland
import QtQuick
import Quickshell

Scope {
    function lock() {
        lock.locked = true
    }

    LockContext {
        id: lockContext

        onUnlocked: {
            // Unlock the screen before exiting, or the compositor will display a
            // fallback lock you can't interact with.
            lock.locked = false;
        }
    }

    WlSessionLock {
        id: lock

        // Lock the session immediately when quickshell starts.
        locked: false

        WlSessionLockSurface {
            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
