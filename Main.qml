import QtQuick

import TimePicker

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "black"

    TimePicker {
        anchors.centerIn: parent
        hours: 12
        minutes: 42
        timeConvention: TimePicker.TimeСonvention.PM
    }
}
