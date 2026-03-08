import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property bool inhibited: false

    preferredRepresentation: compactRepresentation

    Plasmoid.icon: root.inhibited
        ? Qt.resolvedUrl("../icons/caffeine-on.svg")
        : Qt.resolvedUrl("../icons/caffeine-off.svg")
    toolTipMainText: "Plasma Caffeine"
    toolTipSubText: root.inhibited
        ? i18n("Inhibiting sleep. Click to disable.")
        : i18n("Sleep allowed. Click to inhibit.")

    Component.onCompleted: checkStatus()

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []

        onNewData: function(sourceName, data) {
            var stdout = data["stdout"].trim()
            if (sourceName.indexOf("status") !== -1) {
                root.inhibited = (stdout === "running")
            }
            disconnectSource(sourceName)
        }
    }

    function exec(cmd) {
        executable.connectSource(cmd)
    }

    function checkStatus() {
        exec("$HOME/.local/bin/plasma-caffeine status")
    }

    function toggleInhibit() {
        if (root.inhibited) {
            exec("$HOME/.local/bin/plasma-caffeine stop")
            root.inhibited = false
        } else {
            exec("$HOME/.local/bin/plasma-caffeine start")
            root.inhibited = true
        }
    }

    compactRepresentation: Item {
        Layout.minimumWidth: Kirigami.Units.iconSizes.small
        Layout.minimumHeight: Kirigami.Units.iconSizes.small
        Layout.preferredWidth: Kirigami.Units.iconSizes.medium
        Layout.preferredHeight: Kirigami.Units.iconSizes.medium

        Kirigami.Icon {
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height)
            height: width
            isMask: true
            source: root.inhibited
                ? Qt.resolvedUrl("../icons/caffeine-on.svg")
                : Qt.resolvedUrl("../icons/caffeine-off.svg")
            active: mouseArea.containsMouse
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onClicked: root.toggleInhibit()
        }
    }

    fullRepresentation: Item {
        Layout.preferredWidth: Kirigami.Units.gridUnit * 12
        Layout.preferredHeight: Kirigami.Units.gridUnit * 6

        ColumnLayout {
            anchors.centerIn: parent
            spacing: Kirigami.Units.smallSpacing

            Kirigami.Icon {
                Layout.alignment: Qt.AlignHCenter
                width: Kirigami.Units.iconSizes.huge
                height: width
                source: root.inhibited
                ? Qt.resolvedUrl("../icons/caffeine-on.svg")
                : Qt.resolvedUrl("../icons/caffeine-off.svg")
            }

            PlasmaComponents.Label {
                Layout.alignment: Qt.AlignHCenter
                text: root.inhibited
                    ? i18n("Sleep inhibited")
                    : i18n("Sleep allowed")
            }

            PlasmaComponents.Button {
                Layout.alignment: Qt.AlignHCenter
                text: root.inhibited ? i18n("Disable") : i18n("Enable")
                onClicked: root.toggleInhibit()
            }
        }
    }
}
