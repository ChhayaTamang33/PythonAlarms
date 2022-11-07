import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    id:newAlarm
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
        //alarmModel from AlarmModel
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
            ],
        })
    }
    onRejected: Dialog.Close
}
