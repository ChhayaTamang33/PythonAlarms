import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15


ApplicationWindow {
    id: window
    width: 400
    height: 500
    visible: true
    Material.theme: Material.Dark
    Material.accent: Material.Green
    title: "Alarms"

    ListView {
        id: alarmListView
        anchors.fill: parent
        delegate: ItemDelegate {
                id: root
                width: parent.width
                checkable: true

                onClicked: ListView.view.currentIndex = index

                contentItem: ColumnLayout {
                    spacing: 0

                    RowLayout {
                        ColumnLayout {
                            id: dateColumn

                            readonly property date alarmDate: new Date(
                                model.year, model.month - 1, model.day, model.hour, model.minute)
                                
                            Label {
                                id: timeLabel
                                font.pixelSize: Qt.application.font.pixelSize * 2
                                text: dateColumn.alarmDate.toLocaleTimeString(window.locale, Locale.ShortFormat)
                            }

                            RowLayout {
                                Label {
                                    id: dateLabel
                                    text: dateColumn.alarmDate.toLocaleDateString(window.locale, Locale.ShortFormat)
                                }
                                Label {
                                    id: alarmAbout
                                    text: "." + model.label
                                    visible: model.label.length > 0 && !root.checked
                                }
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        Switch {
                            checked: model.activated
                            Layout.alignment: Qt.AlignTop
                            onClicked: model.activated = checked
                        }
                    }
                    CheckBox {
                        id: alarmRepeat
                        text: qsTr("Repeat")
                        checked: model.repeat
                        onToggled: model.repeat = checked
                    }
                    Flow {
                        visible: root.checked && model.repeat
                        Layout.fillWidth: true

                        Repeater {
                            id: dayRepeater
                            model: daysToRepeat
                            delegate: RoundButton {
                                text: Qt.locale().dayName(model.dayOfWeek, Locale.NarrowFormat)
                                flat: true
                                checked: model.repeat
                                checkable: true
                                Material.background: checked ? Material.accent : "transparent"
                                onToggled: model.repeat = checked
                            }
                        }
                    }
                    TextField {
                        id: alarmDescriptionTextField
                        placeholderText: ("Enter Description here")
                        cursorVisible: true
                        visible: root.checked
                        text: model.label
                        onTextEdited: model.label = text
                    }
                    Button {
                        id: deleteAlarmButton
                        text: qsTr("Delete")
                        width: 40
                        height: 40
                        visible: root.checked
                        onClicked: root.ListView.view.model.remove(root.ListView.view.currenIndex, 1)
                    }
                }
            
        }
        // This is alarm model home screen
        model:  ListModel {
                    id: alarmModel

                    ListElement{
                        hour: 6
                        minute: 0
                        day: 2
                        month: 8
                        year: 2018
                        activated: true
                        label: "Wake up"
                        repeat: true
                        daysToRepeat: [
                            ListElement { dayOfWeek: 0; repeat: false },
                            ListElement { dayOfWeek: 1; repeat: false },
                            ListElement { dayOfWeek: 2; repeat: false },
                            ListElement { dayOfWeek: 3; repeat: false },
                            ListElement { dayOfWeek: 4; repeat: false },
                            ListElement { dayOfWeek: 5; repeat: false },
                            ListElement { dayOfWeek: 6; repeat: false}
                        ]
                    }
                    ListElement {
                        hour: 6
                        minute: 0
                        day: 3
                        month: 8
                        year: 2018
                        activated: true
                        label: "Wake up"
                        repeat: true
                        daysToRepeat: [
                            ListElement { dayOfWeek: 0; repeat: false },
                            ListElement { dayOfWeek: 1; repeat: false },
                            ListElement { dayOfWeek: 2; repeat: false },
                            ListElement { dayOfWeek: 3; repeat: false },
                            ListElement { dayOfWeek: 4; repeat: false },
                            ListElement { dayOfWeek: 5; repeat: false },
                            ListElement { dayOfWeek: 6; repeat: false}
                        ]
                    }
                    ListElement {
                        hour: 7
                        minute: 0
                        day: 3
                        month: 8
                        year: 2018
                        activated: true
                        label: "Work out"
                        repeat: false
                        daysToRepeat: [
                            ListElement { dayOfWeek: 0; repeat: false },
                            ListElement { dayOfWeek: 1; repeat: false },
                            ListElement { dayOfWeek: 2; repeat: false },
                            ListElement { dayOfWeek: 3; repeat: false },
                            ListElement { dayOfWeek: 4; repeat: false },
                            ListElement { dayOfWeek: 5; repeat: false },
                            ListElement { dayOfWeek: 6; repeat: false }
                        ]
                    }
                    ListElement {
                        hour: 5
                        minute: 15
                        day: 1
                        month: 9
                        year: 2018
                        activated: true
                        label: ""
                        repeat: false
                        daysToRepeat: [
                            ListElement { dayOfWeek: 0; repeat: false },
                            ListElement { dayOfWeek: 1; repeat: false },
                            ListElement { dayOfWeek: 2; repeat: false },
                            ListElement { dayOfWeek: 3; repeat: false },
                            ListElement { dayOfWeek: 4; repeat: false },
                            ListElement { dayOfWeek: 5; repeat: false },
                            ListElement { dayOfWeek: 6; repeat: false}
                        ]
                    }
                    ListElement {
                        hour: 4
                        minute: 15
                        day: 1
                        month: 9
                        year: 2018
                        activated: true
                        label: ""
                        repeat: false
                        daysToRepeat: [
                            ListElement { dayOfWeek: 0; repeat: false },
                            ListElement { dayOfWeek: 1; repeat: false },
                            ListElement { dayOfWeek: 2; repeat: false },
                            ListElement { dayOfWeek: 3; repeat: false },
                            ListElement { dayOfWeek: 4; repeat: false },
                            ListElement { dayOfWeek: 5; repeat: false },
                            ListElement { dayOfWeek: 6; repeat: false}
                        ]
                    }
                }
        
   
    }

    RoundButton {
        id: addAlarmButton
        text: "+"
        anchors.bottom: alarmListView.bottom
        anchors.bottomMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: alarmDialog.open()
    }

    AlarmDialog {
        id: alarmDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        // Material.theme: Material.Dark
        // Material.accent: Material.Green
        // alarmModel: alarmListView.model
        title: "Set New Alarm"
        padding: 10
        standardButtons: Dialog.Ok | Dialog.Cancel

        contentItem:
            RowLayout {
                RowLayout{
                    id: rowTumbler

                    Tumbler{
                        id: hoursTumbler
                        model: 24
                        delegate: TumblerDelegate {
                            text: (modelData)
                        }
                    }
                    Tumbler{
                        id: minutesTumbler
                        model: 60
                        delegate: TumblerDelegate{
                            text: (modelData)
                        }
                    }
                }
                RowLayout{
                    id: datePicker
                    Layout.leftMargin:20

                    property alias dayTumbler: dayTumbler
                    property alias monthTumbler: monthTumbler
                    property alias yearTumbler: yearTumbler

                    readonly property var days: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

                    Tumbler{
                        id: dayTumbler

                        function updateModel(){
                            var previousIndex = dayTumbler.currentIndex
                            var array = []
                            var newDays = datePicker.days[monthTumbler.currentIndex]
                            for (var i = 1; i<= newDays; ++i)
                                array.push(i)
                            dayTumbler.model = array
                            dayTumbler.currentIndex = Math.min(newDays - 1, previousIndex)
                        }

                        Component.onCompleted: updateModel()

                        delegate: TumblerDelegate {
                            text: (modelData)
                        }
                    }
                    Tumbler{
                        id: monthTumbler

                        onCurrentIndexChanged: dayTumbler.updateModel()

                        model: 12
                        delegate: TumblerDelegate{
                            text: window.locale.standaloneMonthName(modelData, Locale.ShortFormat)
                        }
                    }
                    Tumbler{
                        id: yearTumbler

                        readonly property var years:(function(){
                            var currentYear = new Date().getFullYear()
                            return [0,1,2].map(function(value){ return value + currentYear; })
                        })()

                        model: years
                        delegate: TumblerDelegate{
                            text: (modelData)
                        }
                    }
                }
            }
        onAccepted: {
           // alarmModel from AlarmModel
            alarmModel.append({
                    "hour": hoursTumbler.currentIndex,
                    "minute": minutesTumbler.currenIndex,
                    "day": dayTumbler.currenIndex + 1,
                    "month": monthTumbler.currenIndex + 1,
                    "year": yearTumbler.year[yearTumbler.currenIndex],
                    "activated": true,
                    "label":"",
                    "repeat": false,
                    "daysToRepeat": [
                        {"daysOfWeek":0, "repeat": false},
                        {"daysOfWeek":1, "repeat": false},
                        {"daysOfWeek":2, "repeat": false},
                        {"daysOfWeek":3, "repeat": false},
                        {"daysOfWeek":4, "repeat": false},
                        {"daysOfWeek":5, "repeat": false},
                        {"daysOfWeek":6, "repeat": false}
                    ]
                
            })
        }
        onRejected: Dialog.Close
    }
}