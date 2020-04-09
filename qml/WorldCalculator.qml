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
    property int myHeight: 42
    visible: true
    /* ************************************************************************
     * Rectangle
     */
    Rectangle
    {
        id: pageRectangle
        color: Style.backgroundColor
        anchors.fill: parent
        /**********************************************************************
         * Column
         */
        Column
        {
            id: pageColumn
            spacing: 9
            /* ******************************************************
             * CustomComboBox
             */
            Rectangle
            {
                id: backgroundComboBoxBody
                width: pageColumn.width
                height: 42 + 66
                /* ******************************************************
                 * TextBody Select Celestial Body from Drop-down
                 */
                Text
                {
                    id: appTextBody
                    height: myHeight
                    color: Style.textColor
                    text: qsTr("Select Celestial Body from Drop-down")
                    wrapMode: Text.WrapAnywhere
                    Layout.fillWidth: true
                }
                /* ******************************************************
                 * comboBoxBody
                 */
                ComboBox
                {
                    id: comboBoxBody
                    anchors.top: appTextBody.bottom
                    width: 266
                    height: 42
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
                    onCurrentIndexChanged:
                    {
                        calculatePlanet();
                    }
                    Component.onCompleted:
                    {
                        calculatePlanet();
                    }
                } // end CustomComboBox
                /* ******************************************************
                 * Text Manual
                 */
                Text
                {
                    id: appTextManual
                    anchors.top: comboBoxBody.bottom
                    height: myHeight
                    width: pageColumn.width
                    color: Style.textColor
                    text: qsTr("or enter numbers manually")
                }
            } // Rectangle
            /**********************************************************************
             * Diameter
             */
            Rectangle
            {
                id: backgroundDiameter;
                color: (appTextFieldDiameter.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                radius: 5;
                anchors.top: backgroundComboBoxBody.bottom
                anchors.topMargin: 16
                antialiasing: true;
                height: myHeight
                width: pageColumn.width
                border
                {
                    width: 3;
                    color: (appTextFieldDiameter.activeFocus ? Style.borderColor : Style.backgroundColor);
                }
                Text
                {
                    id: appTextDiameter
                    color: Style.textColor
                    text: qsTr("Enter Celestial Body Diameter in Miles")
                }

                TextEdit
                {
                    id: appTextFieldDiameter
                    text: "0"
                    anchors.left: appTextDiameter.right
                    anchors.leftMargin: 6
                    color: Style.textEditColor
                    Layout.fillWidth: true
                }
            }
            /**********************************************************************
             * SiderealDay
             */
            Rectangle
            {
                id: backgroundSiderealDay;
                color: (appTextFieldSiderealDay.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                radius: 5;
                anchors.top: backgroundDiameter.bottom
                anchors.topMargin: 6
                antialiasing: true;
                height: myHeight
                width: pageColumn.width
                border
                {
                    width: 3;
                    color: (appTextFieldSiderealDay.activeFocus ? Style.borderColor : Style.backgroundColor);
                }
                Text
                {
                    id: appTextSiderealDay
                    color: Style.textColor
                    text: qsTr("Enter Celestial Body Sidereal Period in Days")
                }

                TextEdit
                {
                    id: appTextFieldSiderealDay
                    text: "0"
                    anchors.left: appTextSiderealDay.right
                    anchors.leftMargin: 6
                    color: Style.textEditColor
                }
            }
            /**********************************************************************
             * Celestial Body Average Rotational Speed
             */
            Rectangle
            {
                id: backgroundRotational;
                color: (appTextFieldRotational.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                radius: 5;
                anchors.top: backgroundSiderealDay.bottom
                anchors.topMargin: 6
                antialiasing: true;
                height: myHeight
                width: pageColumn.width
                border
                {
                    width: 3;
                    color: (appTextFieldRotational.activeFocus ? Style.borderColor : Style.backgroundColor);
                }

                Text
                {
                    id: appTextRotational
                    color: Style.textColor
                    text: qsTr("Celestial Body Average Rotational Speed = ")
                }

                TextEdit
                {
                    id: appTextFieldRotational
                    text: "0"
                    anchors.left: appTextRotational.right
                    anchors.leftMargin: 6
                    color: Style.textEditColor
                    Layout.fillWidth: true
                }
            }
            /**********************************************************************
             * Formula SpeedHeader
             */
            Rectangle
            {
                id: rowLayoutXFormula
                height: myHeight
                anchors.top: backgroundRotational.bottom
                anchors.topMargin: 6
                width: pageColumn.width

                Text
                {
                    id: appTextRotationalFormula
                    color: Style.textColor
                    text: qsTr("CBARS = ( Diameter * PI ) / ( Rotation * 24 )")
                }

                Text
                {
                    id: appTextOrbitalSpeedHeader
                    color: Style.textColor
                    text: qsTr("Average Orbital Speed in Miles Per Hour")
                    anchors.left: appTextRotationalFormula.right
                    anchors.leftMargin: 6
                }
            }
            /**********************************************************************
             * Orbital
             */
            Rectangle
            {
                id: backgroundOrbital;
                color: (appTextFieldOrbital.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                radius: 5;
                anchors.top: rowLayoutXFormula.bottom
                anchors.topMargin: 6
                antialiasing: true;
                height: myHeight
                width: pageColumn.width
                border
                {
                    width: 3;
                    color: (appTextFieldOrbital.activeFocus ? Style.borderColor : Style.backgroundColor);
                }

                Text
                {
                    id: appTextOrbital
                    color: Style.textColor
                    text: qsTr("Enter Celestial Body Orbital distance in Miles")
                }

                TextEdit
                {
                    id: appTextFieldOrbital
                    text: "0"
                    color: Style.textEditColor
                    Layout.fillWidth: true
                    anchors.left: appTextOrbital.right
                    anchors.leftMargin: 6
                }
            }
            /**********************************************************************
             * Days
             */
            Rectangle
            {
                id: backgroundDays;
                color: (appTextFieldDays.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                radius: 5;
                anchors.top: backgroundOrbital.bottom
                anchors.topMargin: 6
                antialiasing: true;
                height: myHeight
                width: pageColumn.width
                border
                {
                    width: 3;
                    color: (appTextFieldDays.activeFocus ? Style.borderColor : Style.backgroundColor);
                }

                Text
                {
                    id: appTextDays
                    color: Style.textColor

                    text: qsTr("Enter Celestial Body Orbital Period in Days")
                }

                TextEdit
                {
                    id: appTextFieldDays
                    text: "0"
                    color: Style.textEditColor
                    Layout.fillWidth: true
                    anchors.left: appTextDays.right
                    anchors.leftMargin: 6
                }
            }
            /**********************************************************************
             * OrbitalSpeed
             */
            Rectangle
            {
                id: backgroundOrbitalSpeed;
                color: (appTextFieldOrbitalSpeed.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                radius: 5;
                anchors.top: backgroundDays.bottom
                anchors.topMargin: 6
                antialiasing: true;
                height: myHeight
                width: pageColumn.width
                border
                {
                    width: 3;
                    color: (appTextFieldOrbitalSpeed.activeFocus ? Style.borderColor : Style.backgroundColor);
                }
                Text
                {
                    id: appTextOrbitalSpeed
                    color: Style.textColor
                    text: qsTr("Celestial Body Average Orbital Speed =")
                }

                TextEdit
                {
                    id: appTextFieldOrbitalSpeed
                    text: "0"
                    color: Style.textEditColor
                    Layout.fillWidth: true
                    anchors.left: appTextOrbitalSpeed.right
                    anchors.leftMargin: 6
                }
            }
            /**********************************************************************
             * Orbital Speed Formula
             */
            Rectangle
            {
                id: orbitalSpeedFormula
                height: myHeight
                anchors.top: backgroundOrbitalSpeed.bottom
                anchors.topMargin: 6
                width: pageColumn.width
                Text
                {
                    id: appTextappTextOrbitalSpeedFormula
                    text: qsTr("AOS = Distance / ( Days * 24 )")
                    color: Style.textColor
                }
            }
            /**********************************************************************
             * Button
             */
            Rectangle
            {
                id: buttonCalculate
                height: myHeight
                anchors.top: orbitalSpeedFormula.bottom
                anchors.topMargin: 6
                width: pageColumn.width
                Button
                {
                    id: appButtonCalculate
                    text: "Calculate"
                    onClicked:
                    {
                        Wc.calcSpeeds(appTextFieldDiameter.text.replace(',',''), appTextFieldSiderealDay.text.replace(',',''), appTextFieldOrbital.text.replace(',',''), appTextFieldDays.text.replace(',',''));
                        calculatePlanet();
                    }
                }
            }
        }  // end Column
    } // end Rectangle
    /**********************************************************************
     * calculatePlanet
     */
    function calculatePlanet()
    {
        //console.debug("Body=" + comboBoxBody.currentText);
        Wc.presetCB(comboBoxBody.currentIndex);
        appTextFieldDiameter.text = Wc.getPlanetDiameter()
        appTextFieldSiderealDay.text = Wc.getPlanetRotation();
        appTextFieldRotational.text = Wc.getRotationSpeed();

        appTextFieldOrbital.text = Wc.getOrbitalDistance();
        appTextFieldDays.text = Wc.getOrbitalPeriod();
        appTextFieldOrbitalSpeed.text = Wc.getOrbitalSpeed()
    } // end calculatePlanet
} // end Page
/* ***************************** End of File ******************************* */


/*##^##
Designer {
    D{i:7;anchors_height:42}
}
##^##*/
