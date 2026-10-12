import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    visible: true
    width: 1440
    height: 900
    minimumWidth: 900
    minimumHeight: 620
    title: "aliceOS"
    color: "#0b1020"

    property bool launcherOpen: false
    property bool quickSettingsOpen: false
    property string activeApp: "Overview"
    property string searchText: ""

    readonly property color ink: "#f4f6ff"
    readonly property color muted: "#9aa8c7"
    readonly property color panel: "#151d33"
    readonly property color panelSoft: "#1c2945"
    readonly property color accent: "#9b8cff"
    readonly property color mint: "#71e4cf"

    // Decorative wallpaper is intentionally self-contained: no external assets required.
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#101a35" }
            GradientStop { position: 0.48; color: "#17213d" }
            GradientStop { position: 1.0; color: "#0b1020" }
        }
    }
    Rectangle {
        width: 680; height: 680; radius: 340
        x: parent.width * 0.48; y: -220
        color: "#6556d9"; opacity: 0.16
        layer.enabled: true
        layer.effect: MultiEffect { blurEnabled: true; blur: 1.0; blurMax: 64 }
    }
    Rectangle {
        width: 540; height: 540; radius: 270
        x: -260; y: parent.height * 0.32
        color: "#35c9b4"; opacity: 0.10
        layer.enabled: true
        layer.effect: MultiEffect { blurEnabled: true; blur: 1.0; blurMax: 64 }
    }

    component GlassCard: Rectangle {
        radius: 22
        color: "#d91b2945"
        border.color: "#32ffffff"
        border.width: 1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 30
        anchors.bottomMargin: 104
        spacing: 22

        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            ColumnLayout {
                spacing: 2
                Label { text: "Good afternoon"; color: root.muted; font.pixelSize: 14 }
                Label { text: "Welcome back."; color: root.ink; font.pixelSize: 30; font.weight: Font.DemiBold }
            }
            Item { Layout.fillWidth: true }
            Rectangle {
                radius: 18; color: "#b51b2945"; border.color: "#30ffffff"
                Layout.preferredWidth: 270; Layout.preferredHeight: 46
                RowLayout {
                    anchors.fill: parent; anchors.leftMargin: 14; anchors.rightMargin: 14
                    Label { text: "⌕"; font.pixelSize: 22; color: root.muted }
                    TextField {
                        Layout.fillWidth: true
                        placeholderText: "Search everything…"
                        color: root.ink
                        placeholderTextColor: root.muted
                        background: null
                        onAccepted: {
                            root.searchText = text
                            root.launcherOpen = true
                        }
                    }
                    Label { text: "⌘ K"; color: root.muted; font.pixelSize: 11 }
                }
            }
            Rectangle {
                width: 46; height: 46; radius: 16
                color: "#d92b3856"; border.color: "#35ffffff"
                Label { anchors.centerIn: parent; text: "A"; color: "white"; font.pixelSize: 18; font.bold: true }
            }
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: root.width < 1050 ? 2 : 4
            rowSpacing: 16
            columnSpacing: 16

            GlassCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                Layout.columnSpan: root.width < 1050 ? 2 : 2
                Layout.rowSpan: 2
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 24; spacing: 14
                    RowLayout {
                        Label { text: "✦"; color: root.mint; font.pixelSize: 20 }
                        Label { text: "aliceOS"; color: root.ink; font.pixelSize: 17; font.bold: true }
                        Item { Layout.fillWidth: true }
                        Label { text: "PREVIEW"; color: root.mint; font.pixelSize: 10; font.bold: true }
                    }
                    Item { Layout.fillHeight: true }
                    Label {
                        text: "A little more\nroom to create."
                        color: root.ink; font.pixelSize: 35; font.weight: Font.DemiBold
                        lineHeight: 1.12
                    }
                    Label {
                        text: "Your workspace, thoughtfully arranged."
                        color: root.muted; font.pixelSize: 14
                    }
                    Item { Layout.fillHeight: true }
                    RowLayout {
                        spacing: 10
                        Rectangle {
                            radius: 14; color: root.accent
                            Layout.preferredHeight: 44; Layout.preferredWidth: 150
                            RowLayout {
                                anchors.centerIn: parent; spacing: 9
                                Label { text: "✣"; color: "#14122a"; font.pixelSize: 18 }
                                Label { text: "Explore apps"; color: "#14122a"; font.bold: true }
                            }
                            TapHandler { onTapped: root.launcherOpen = !root.launcherOpen }
                        }
                        Rectangle {
                            radius: 14; color: "#252f4a"; border.color: "#3cffffff"
                            Layout.preferredHeight: 44; Layout.preferredWidth: 115
                            Label { anchors.centerIn: parent; text: "Preferences"; color: root.ink }
                            TapHandler { onTapped: root.activeApp = "Settings" }
                        }
                    }
                }
            }

            GlassCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 20; spacing: 10
                    Label { text: "MONDAY, OCTOBER 11"; color: root.muted; font.pixelSize: 10; font.bold: true }
                    Label { text: "16:20"; color: root.ink; font.pixelSize: 38; font.weight: Font.Light }
                    Label { text: "A good moment to begin."; color: root.muted; font.pixelSize: 12; wrapMode: Text.Wrap }
                    Item { Layout.fillHeight: true }
                    RowLayout {
                        spacing: 6
                        Repeater {
                            model: 7
                            Rectangle {
                                Layout.fillWidth: true; height: 4; radius: 2
                                color: index < 4 ? root.accent : "#39445e"
                            }
                        }
                    }
                }
            }

            GlassCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 20; spacing: 12
                    RowLayout {
                        Label { text: "◉"; color: root.mint; font.pixelSize: 19 }
                        Label { text: "System"; color: root.ink; font.pixelSize: 15; font.bold: true }
                        Item { Layout.fillWidth: true }
                        Label { text: "DEMO"; color: root.muted; font.pixelSize: 9 }
                    }
                    Label { text: "Everything feels quiet."; color: root.ink; font.pixelSize: 13; wrapMode: Text.Wrap }
                    RowLayout {
                        spacing: 8
                        Rectangle { Layout.fillWidth: true; height: 6; radius: 3; color: "#303b58"; Rectangle { width: parent.width * 0.32; height: parent.height; radius: 3; color: root.mint } }
                        Label { text: "32%"; color: root.muted; font.pixelSize: 11 }
                    }
                    Label { text: "System metrics are illustrative until a nos telemetry service is connected."; color: root.muted; font.pixelSize: 10; wrapMode: Text.Wrap }
                }
            }

            GlassCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                Layout.columnSpan: root.width < 1050 ? 2 : 2
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 20; spacing: 12
                    RowLayout {
                        Label { text: "⌘"; color: root.accent; font.pixelSize: 21 }
                        Label { text: "Pick up where you left off"; color: root.ink; font.pixelSize: 15; font.bold: true; wrapMode: Text.Wrap }
                    }
                    Repeater {
                        model: [
                            {icon: "▣", title: "Terminal", detail: "Command line workspace", name: "Terminal"},
                            {icon: "◫", title: "System settings", detail: "Personalize your desktop", name: "Settings"},
                            {icon: "▤", title: "Software center", detail: "Discover applications", name: "Software"}
                        ]
                        delegate: Rectangle {
                            Layout.fillWidth: true; height: 53; radius: 13
                            color: mouse.containsMouse ? "#302f4c" : "#10182a"
                            RowLayout {
                                anchors.fill: parent; anchors.margins: 10; spacing: 12
                                Rectangle {
                                    width: 32; height: 32; radius: 10; color: "#302e52"
                                    Label { anchors.centerIn: parent; text: modelData.icon; color: root.accent; font.pixelSize: 17 }
                                }
                                ColumnLayout {
                                    spacing: 1
                                    Label { text: modelData.title; color: root.ink; font.pixelSize: 12; font.bold: true }
                                    Label { text: modelData.detail; color: root.muted; font.pixelSize: 10 }
                                }
                                Item { Layout.fillWidth: true }
                                Label { text: "↗"; color: root.muted }
                            }
                            MouseArea {
                                id: mouse; anchors.fill: parent; hoverEnabled: true
                                onClicked: root.activeApp = modelData.name
                            }
                        }
                    }
                }
            }

            GlassCard {
                Layout.fillWidth: true; Layout.fillHeight: true
                ColumnLayout {
                    anchors.fill: parent; anchors.margins: 20; spacing: 10
                    Label { text: "QUICK CONTROLS"; color: root.muted; font.pixelSize: 10; font.bold: true }
                    RowLayout {
                        spacing: 8
                        Rectangle {
                            Layout.fillWidth: true; height: 42; radius: 13; color: "#3b3765"
                            Label { anchors.centerIn: parent; text: "◉  Wi-Fi"; color: root.ink; font.pixelSize: 12 }
                        }
                        Rectangle {
                            Layout.fillWidth: true; height: 42; radius: 13; color: "#202c46"
                            Label { anchors.centerIn: parent; text: "ᛒ  Bluetooth"; color: root.ink; font.pixelSize: 12 }
                        }
                    }
                    Label { text: "Controls are visual placeholders; hardware services are not connected yet."; color: root.muted; font.pixelSize: 10; wrapMode: Text.Wrap }
                    Item { Layout.fillHeight: true }
                    TapHandler { onTapped: root.quickSettingsOpen = true }
                }
            }
        }
    }

    // Bottom dock / panel.
    Rectangle {
        id: dock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: Math.min(parent.width - 40, 660)
        height: 66
        radius: 23
        color: "#e0162038"
        border.color: "#40ffffff"
        RowLayout {
            anchors.fill: parent; anchors.leftMargin: 12; anchors.rightMargin: 12
            spacing: 7
            Repeater {
                model: [
                    {icon: "✣", label: "Launcher", app: "Launcher"},
                    {icon: "▦", label: "Overview", app: "Overview"},
                    {icon: "▤", label: "Files", app: "Files"},
                    {icon: ">_", label: "Terminal", app: "Terminal"},
                    {icon: "⚙", label: "Settings", app: "Settings"}
                ]
                delegate: Rectangle {
                    Layout.preferredWidth: 46; Layout.preferredHeight: 46
                    radius: 15
                    color: root.activeApp === modelData.app ? "#534b86" : (hoverDock.containsMouse ? "#2a3654" : "transparent")
                    Label { anchors.centerIn: parent; text: modelData.icon; color: root.ink; font.pixelSize: 19 }
                    ToolTip.visible: hoverDock.containsMouse
                    ToolTip.text: modelData.label
                    MouseArea {
                        id: hoverDock; anchors.fill: parent; hoverEnabled: true
                        onClicked: {
                            if (modelData.app === "Launcher") root.launcherOpen = !root.launcherOpen
                            else root.activeApp = modelData.app
                        }
                    }
                }
            }
            Rectangle { width: 1; height: 32; color: "#40ffffff" }
            Item { Layout.fillWidth: true }
            Rectangle {
                Layout.preferredWidth: 90; Layout.preferredHeight: 44; radius: 14
                color: root.quickSettingsOpen ? "#534b86" : "#25314c"
                Column {
                    anchors.centerIn: parent; spacing: 2
                    Label { anchors.horizontalCenter: parent.horizontalCenter; text: "◉  ᛒ"; color: root.ink; font.pixelSize: 14 }
                    Label { anchors.horizontalCenter: parent.horizontalCenter; text: "16:20"; color: root.muted; font.pixelSize: 10 }
                }
                TapHandler { onTapped: root.quickSettingsOpen = !root.quickSettingsOpen }
            }
        }
    }

    // Launcher popover.
    Rectangle {
        visible: root.launcherOpen
        z: 10
        anchors.bottom: dock.top
        anchors.bottomMargin: 14
        anchors.left: dock.left
        width: Math.min(390, root.width - 32)
        height: 410
        radius: 24
        color: "#f018223a"
        border.color: "#4dffffff"
        ColumnLayout {
            anchors.fill: parent; anchors.margins: 22; spacing: 14
            RowLayout {
                Label { text: "Application launcher"; color: root.ink; font.pixelSize: 19; font.bold: true }
                Item { Layout.fillWidth: true }
                ToolButton { text: "✕"; onClicked: root.launcherOpen = false }
            }
            TextField {
                Layout.fillWidth: true; placeholderText: "Search applications…"
                text: root.searchText; onTextChanged: root.searchText = text
            }
            GridLayout {
                Layout.fillWidth: true; columns: 3; rowSpacing: 12; columnSpacing: 12
                Repeater {
                    model: [
                        {icon:"▤", name:"Terminal"},
                        {icon:"▦", name:"Files"},
                        {icon:"⚙", name:"Settings"},
                        {icon:"◈", name:"Software"},
                        {icon:"◉", name:"System"},
                        {icon:"✎", name:"Editor"}
                    ]
                    delegate: Rectangle {
                        visible: root.searchText.length === 0 || modelData.name.toLowerCase().includes(root.searchText.toLowerCase())
                        Layout.fillWidth: true; Layout.preferredHeight: 88; radius: 15
                        color: "#252f4b"; border.color: "#20ffffff"
                        Column {
                            anchors.centerIn: parent; spacing: 7
                            Label { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.icon; color: root.accent; font.pixelSize: 24 }
                            Label { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.name; color: root.ink; font.pixelSize: 12 }
                        }
                        TapHandler {
                            onTapped: {
                                root.activeApp = modelData.name
                                root.launcherOpen = false
                                root.searchText = ""
                            }
                        }
                    }
                }
            }
            Item { Layout.fillHeight: true }
            Label { text: "Applications will be discovered from the aliceOS app registry."; color: root.muted; font.pixelSize: 10; wrapMode: Text.Wrap }
        }
    }

    // Quick settings drawer.
    Rectangle {
        visible: root.quickSettingsOpen
        z: 11
        anchors.right: parent.right; anchors.top: parent.top
        anchors.margins: 22
        width: 320; height: 370; radius: 24
        color: "#f018223a"; border.color: "#4dffffff"
        ColumnLayout {
            anchors.fill: parent; anchors.margins: 20; spacing: 14
            RowLayout {
                Label { text: "Quick settings"; color: root.ink; font.pixelSize: 18; font.bold: true }
                Item { Layout.fillWidth: true }
                ToolButton { text: "✕"; onClicked: root.quickSettingsOpen = false }
            }
            Repeater {
                model: [
                    {title:"Wi-Fi", subtitle:"Network service unavailable", icon:"◉"},
                    {title:"Bluetooth", subtitle:"Device service unavailable", icon:"ᛒ"},
                    {title:"Night light", subtitle:"Display preference preview", icon:"☾"},
                    {title:"Power mode", subtitle:"Balanced (preview)", icon:"ϟ"}
                ]
                delegate: Rectangle {
                    Layout.fillWidth: true; height: 58; radius: 14; color: "#252f4b"
                    RowLayout {
                        anchors.fill: parent; anchors.margins: 12; spacing: 12
                        Label { text: modelData.icon; color: root.mint; font.pixelSize: 20 }
                        ColumnLayout {
                            spacing: 2
                            Label { text: modelData.title; color: root.ink; font.pixelSize: 13; font.bold: true }
                            Label { text: modelData.subtitle; color: root.muted; font.pixelSize: 10 }
                        }
                    }
                }
            }
            Item { Layout.fillHeight: true }
            Label { text: "System controls require a connected privileged service."; color: root.muted; font.pixelSize: 10; wrapMode: Text.Wrap }
        }
    }

    // App window placeholder: makes the dock and launcher usable in the shell prototype.
    Rectangle {
        visible: root.activeApp !== "Overview" && root.activeApp !== "Launcher"
        z: 8
        anchors.centerIn: parent
        width: Math.min(660, root.width - 80)
        height: Math.min(470, root.height - 180)
        radius: 22
        color: "#f0162038"
        border.color: "#50ffffff"
        ColumnLayout {
            anchors.fill: parent; anchors.margins: 22; spacing: 14
            RowLayout {
                Label { text: root.activeApp; color: root.ink; font.pixelSize: 21; font.bold: true }
                Item { Layout.fillWidth: true }
                ToolButton { text: "—"; onClicked: root.activeApp = "Overview" }
                ToolButton { text: "✕"; onClicked: root.activeApp = "Overview" }
            }
            Rectangle { Layout.fillWidth: true; height: 1; color: "#30ffffff" }
            Label {
                Layout.fillWidth: true
                text: root.activeApp === "Terminal"
                    ? "alice@nos:~$ help\n\nWelcome to the aliceOS terminal preview.\nCommands are not executed by this prototype.\n\nAvailable preview commands: help, clear, neofetch"
                    : root.activeApp === "Settings"
                    ? "Personalization\n\nAppearance   •   Dark / Light\nWorkspace    •   Panels and desktop\nDevices      •   Awaiting system services\nNetwork      •   Awaiting network manager\nUsers        •   Requires account service"
                    : root.activeApp === "Software"
                    ? "Discover software\n\nThe package service is not connected yet.\nSigned repositories and verified packages are required before installation is enabled."
                    : root.activeApp === "Files"
                    ? "Home\n\nDocuments     Downloads     Pictures\nDesktop       Music         Videos\n\nFilesystem browsing requires the nos VFS/userspace API."
                    : root.activeApp + "\n\nThis application is a shell placeholder."
                color: root.activeApp === "Terminal" ? root.mint : root.ink
                font.family: root.activeApp === "Terminal" ? "monospace" : "sans-serif"
                font.pixelSize: 14
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignTop
            }
            Item { Layout.fillHeight: true }
            Label { text: "Prototype UI • no privileged actions are performed"; color: root.muted; font.pixelSize: 10 }
        }
    }
}
