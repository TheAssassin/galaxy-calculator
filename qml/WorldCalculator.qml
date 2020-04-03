import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

import "WorldCalculator.js" as Wc

/* ****************************************************************************
 * World Calculator
 */
Page
{
    title: qsTr("World Planet Speed Calcalculator")
    visible: true

    Column
    {
        id: column
        x: 6
        y: 16
        anchors.rightMargin: 6
        anchors.leftMargin: 6
        anchors.topMargin: 16
        anchors.fill: parent

        Text {
            id: appTextBody
            color: Style.textColor

            text: qsTr("Select Celestial Body from Drop-down")
            wrapMode: Text.WrapAnywhere
        }
        /* ******************************************************
         * CustomComboBox
         */
        ComboBox
        {
            id: comboBoxBody
            y: 366
            width: 266
            height: 33
            implicitWidth: 266
            implicitHeight: 33
            wheelEnabled: true
            currentIndex: 3
            model: [qsTr("Sun"),
                qsTr("Mercury"),
                qsTr("Venus"),
                qsTr("Earth"),
                qsTr("Moon"),
                qsTr("Mars"),
                qsTr("Jupiter"),
                qsTr("Saturn"),
                qsTr("Uranus"),
                qsTr("Neptune")]
            onCurrentIndexChanged: {
                calcIt();
            }
            Component.onCompleted: {
                calcIt();
            }
        } // end CustomComboBox

        Text {
            id: appTextManual
            color: Style.textColor

            text: qsTr("or enter numbers manually")
        }

        Text {
            id: appTextDiameter
            color: Style.textColor

            text: qsTr("Enter Celestial Body Diameter in Miles")
        }

        TextEdit {
            id: appTextFieldDiameter
            width: 333
            text: "0"
            color: Style.textEditColor
        }

        Text {
            id: appTextSiderealDay
            color: Style.textColor

            text: qsTr("Enter Celestial Body Sidereal Period in Days")
        }

        TextEdit {
            id: appTextFieldSiderealDay
            width: 333
            text: "0"
            color: Style.textEditColor
        }

        Text {
            id: appTextRotational
            color: Style.textColor

            text: qsTr("Celestial Body Average Rotational Speed = ")
        }

        TextEdit {
            id: appTextFieldRotational
            width: 333
            text: "0"
            color: Style.textEditColor
        }

        Text {
            id: appTextRotationalFormula
            color: Style.textColor

            text: qsTr("CBARS = ( Diameter * PI ) / ( Rotation * 24 )")
        }

        Text {
            id: appTextOrbitalSpeedHeader
            color: Style.textColor

            text: qsTr("Average Orbital Speed in Miles Per Hour")
        }

        Text {
            id: appTextOrbital
            color: Style.textColor

            text: qsTr("Enter Celestial Body Orbital distance in Miles")
        }

        TextEdit {
            id: appTextFieldOrbital
            width: 333
            text: "0"
            color: Style.textEditColor
        }

        Text {
            id: appTextDays
            color: Style.textColor

            text: qsTr("Enter Celestial Body Orbital Period in Days")
        }

        TextEdit {
            id: appTextFieldDays
            width: 333
            text: "0"
            color: Style.textEditColor
        }

        Text {
            id: appTextOrbitalSpeed
            color: Style.textColor
            text: qsTr("Celestial Body Average Orbital Speed =")
        }

        TextEdit {
            id: appTextFieldOrbitalSpeed
            width: 333
            text: "0"
            color: Style.textEditColor
        }

        Text {
            id: appTextappTextOrbitalSpeedFormula
            text: qsTr("AOS = Distance / ( Days * 24 )")
            color: Style.textColor
        }


        Button {
            id: appButtonCalculate
            text: "Calculate"
            onClicked: {
                Wc.calcSpeeds(appTextFieldDiameter.text.replace(',',''), appTextFieldSiderealDay.text.replace(',',''), appTextFieldOrbital.text.replace(',',''), appTextFieldDays.text.replace(',',''));
                calcIt();
            }
        }
    }  // end Column

    function calcIt() {
        //console.debug("Body=" + comboBoxBody.currentText)
        Wc.presetCB(comboBoxBody.currentIndex);
        appTextFieldDiameter.text = Wc.getPlanetDiameter()
        appTextFieldSiderealDay.text = Wc.getPlanetRotation();
        appTextFieldRotational.text = Wc.getRotationSpeed();

        appTextFieldOrbital.text = Wc.getOrbitalDistance();
        appTextFieldDays.text = Wc.getOrbitalPeriod();
        appTextFieldOrbitalSpeed.text = Wc.getOrbitalSpeed()
    }

} // end Page
/* ***************************** End of File ******************************* */

