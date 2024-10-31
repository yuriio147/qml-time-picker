import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root

    enum TimeСonvention {
        AM,
        PM
    }

    enum SelectMode {
        Hours,
        Minutes
    }

    property int hours: 0
    property int minutes: 0
    property int timeConvention: TimePicker.TimeСonvention.PM
    property int selectMode: TimePicker.SelectMode.Hours

    implicitWidth: contentLayout.width
    implicitHeight: contentLayout.height

    ColumnLayout {
        id: contentLayout
        anchors.centerIn: parent

        RowLayout {
            spacing: 5

            Rectangle {
                id: hoursRect
                Layout.preferredWidth: 70
                Layout.preferredHeight: 60
                color: root.selectMode === TimePicker.SelectMode.Minutes ? "transparent" : "teal"
                radius: 8
                border {
                    color: "white"
                    width: root.selectMode === TimePicker.SelectMode.Minutes ? 1 : 0
                }

                Label {
                    id: hoursLabel
                    anchors.centerIn: parent
                    text: root.hours < 10 ? "0" + root.hours : root.hours
                    color: "white"
                    font.pixelSize: 18
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.selectMode = TimePicker.SelectMode.Hours
                        rotation.angle = internal.initAngle()
                    }
                }
            }

            Label {
                Layout.alignment: Qt.AlignVCenter
                text: ":"
                color: "white"
                font.pixelSize: 18
            }

            Rectangle {
                id: minutesRect
                Layout.preferredWidth: 70
                Layout.preferredHeight: 60
                color: root.selectMode === TimePicker.SelectMode.Hours ? "transparent" : "teal"
                radius: 8
                border {
                    color: "white"
                    width: root.selectMode === TimePicker.SelectMode.Hours ? 1 : 0
                }

                Label {
                    id: minutesLabel
                    anchors.centerIn: parent
                    text: root.minutes < 10 ? "0" + root.minutes : root.minutes
                    color: "white"
                    font.pixelSize: 18
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.selectMode = TimePicker.SelectMode.Minutes
                }
            }

            Rectangle {
                Layout.preferredWidth: 45
                Layout.preferredHeight: 60
                color: "black"
                radius: 8
                border {
                    color: "white"
                    width: 1
                }

                Rectangle {
                    anchors.fill: parent
                    color: "black"
                    radius: 8
                    border {
                        color: "white"
                        width: 1
                    }

                    Rectangle {
                        id: amRect
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                            margins: -1
                        }
                        radius: 8
                        color: root.timeConvention == TimePicker.TimeСonvention.PM ? "transparent" : "teal"
                        height: parent.height / 2

                        Rectangle {
                            anchors {
                                left: parent.left
                                right: parent.right
                                bottom: parent.bottom
                            }
                            color: parent.color
                            height: parent.height / 2
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.timeConvention = TimePicker.TimeСonvention.AM
                        }
                    }

                    Rectangle {
                        id: pmRect
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                            margins: -1
                        }
                        radius: 8
                        color: root.timeConvention == TimePicker.TimeСonvention.AM ? "transparent" : "teal"
                        height: parent.height / 2

                        Rectangle {
                            anchors {
                                left: parent.left
                                right: parent.right
                                top: parent.top
                            }
                            color: parent.color
                            height: parent.height / 2
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.timeConvention = TimePicker.TimeСonvention.PM
                        }
                    }

                    Label {
                        id: amLabel
                        anchors.centerIn: amRect
                        text: "AM"
                        color: "white"
                        font.pixelSize: 18
                    }

                    Label {
                        id: pmLabel
                        anchors.centerIn: pmRect
                        text: "PM"
                        color: "white"
                        font.pixelSize: 18
                    }
                }

            }
        }

        Rectangle {
            id: circle

            property real clockPadding: 24

            Layout.fillWidth: true
            Layout.preferredHeight: width
            radius: width / 2
            color: "teal"

            Rectangle {
                id: line
                anchors {
                    left: parent.horizontalCenter
                    top: parent.verticalCenter
                    topMargin: -height / 2
                }
                width: 78
                height: 4
                antialiasing: true
                transform: Rotation {
                    id: rotation
                    origin.x: 0
                    origin.y: line.height / 2
                    angle: internal.initAngle()
                }

                Rectangle {
                    anchors {
                        left: parent.left
                        leftMargin: -width / 2
                        top: parent.verticalCenter
                        topMargin: -height / 2
                    }
                    width: line.height
                    height: width
                    radius: width / 2
                    antialiasing: true
                }

                Rectangle {
                    id: handle
                    x: parent.width - width / 2
                    y: parent.height / 2 - height / 2
                    width: 36
                    height: width
                    radius: width / 2
                    antialiasing: true
                }
            }

            PathView {
                id: pathView

                readonly property list<string> hoursModel: ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
                readonly property list<string> minutesModel: ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]

                anchors.fill: parent
                model: root.selectMode === TimePicker.SelectMode.Hours ? pathView.hoursModel : pathView.minutesModel
                delegate: Label {
                    text: modelData
                    color: "black"
                    font.pixelSize: 18
                    width: 20
                    height: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                path: Path {
                    startX: circle.width / 2
                    startY: circle.clockPadding

                    PathArc {
                        x: circle.width / 2
                        y: circle.height - circle.clockPadding
                        radiusX: circle.width / 2 - circle.clockPadding
                        radiusY: circle.width / 2 - circle.clockPadding
                        useLargeArc: false
                    }

                    PathArc {
                        x: circle.width / 2
                        y: circle.clockPadding
                        radiusX: circle.width / 2 - circle.clockPadding
                        radiusY: circle.width / 2 - circle.clockPadding
                        useLargeArc: false
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onPressed: (mouse) => {internal.updateClockFromMouse(mouse)}
                onPositionChanged: (mouse) => {internal.updateClockFromMouse(mouse)}
                onReleased: (mouse) => {
                                if (root.selectMode === TimePicker.SelectMode.Hours) {
                                    root.selectMode = TimePicker.SelectMode.Minutes
                                }
                            }
            }
        }

        QtObject {
            id: internal

            function applyTimeConvention(hours, timeConvention) {
                return timeConvention === TimePicker.TimeСonvention.PM ? (hours === 12 ? 0 : hours + 12) : hours
            }

            function initAngle() {
                if (root.selectMode === TimePicker.SelectMode.Hours) {
                    return internal.hoursToDegrees(root.hours)
                }
                return internal.minutesToDegrees(root.minutes)
            }

            function updateClockFromMouse(mouse) {
                let angle = internal.calculateAngle({x: circle.width / 2, y: circle.height / 2}, mouse)
                if (root.selectMode === TimePicker.SelectMode.Hours) {
                    let hours = internal.degreesToHours(angle)
                    root.hours = hours
                    rotation.angle = internal.hoursToDegrees(hours)
                } else {
                    let minutes = internal.degreesToMinutes(angle)
                    root.minutes = minutes
                    rotation.angle = internal.minutesToDegrees(minutes)
                }
            }

            function calculateAngle(point1, point2) {
                const dx = point2.x - point1.x
                const dy = point2.y - point1.y
                const angleRadians = Math.atan2(dy, dx)
                const angleDegrees = angleRadians * (180 / Math.PI)
                return angleDegrees
            }

            function degreesToHours(angle) {
                angle += 90
                angle %= 360
                let hours = Math.round(angle / 30);
                if (hours === 0) {
                    hours = 12
                } else if (hours < 0) {
                    hours = 12 + hours
                }
                return hours
            }

            function hoursToDegrees(hours) {
                hours = (hours % 12) + (hours >= 12 ? 12 : 0)
                const angle = (hours * 30) - 90
                return angle
            }

            function degreesToMinutes(angle) {
                angle += 90
                angle %= 360
                let minutes = Math.round(angle / 6)
                if (minutes === 0) {
                    minutes = 0
                } else if (minutes < 0) {
                    minutes = 60 + minutes
                }
                return minutes
            }

            function minutesToDegrees(minutes) {
                minutes = (minutes % 60) + (minutes >= 60 ? 60 : 0)
                const angle = (minutes * 6) - 90
                return angle
            }
        }
    }
}
