import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

/* ****************************************************************************
 * Energy Calculator
 */
Page
{
    title: qsTr("Energy Calculator")
    /* ************************************************************************
     * Column
     */
    Column
    {
        id: columnMain
        anchors.right: parent.right
        anchors.rightMargin: 13
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 6
        anchors.top: parent.top
        anchors.topMargin: 6
        Component.onCompleted: {
            calculatIt();
        }
        /* ********************************************************************
         * Fire Resonant Frequency
         */
        Text {
            id: appTextFrF
            text: qsTr("Enter Fire Resonant in Frequency, Wavelength or Percentage")
            color: Style.textColor
        }

        TextEdit {
            id: appTextFieldFrF
            width: 333
            text: "100"
            color: Style.textEditColor
        }

        Slider {
            id: appSliderFrf
            width: 609
            height: 42
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.left: parent.left
            anchors.leftMargin: 3
            value: 100
            to: 100
            onPositionChanged: {
                appTextFieldFrF.text = Math.round(appSliderFrf.position * 100);
                calculatIt();
            }
        }
        /* ********************************************************************
         * X
         */
        Text {
            id: appTextX
            text: qsTr("Enter X for the current value")
            color: Style.textColor
        }

        TextEdit {
            id: appTextFieldX
            width: 333
            text: "66"
            color: Style.textEditColor
        }

        Slider {
            id: appSliderX
            height: 42
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.right: parent.right
            anchors.rightMargin: 3
            value: 66
            to: 100
            onPositionChanged: {
                appTextFieldX.text = Math.round(appSliderX.position * 100);
                calculatIt();
            }
        }
        /* ********************************************************************
         * appButtonCalculate
         */
        Button {
            id: appButtonCalculate
            text: qsTr("Calculate")
            onClicked: {
                calculatIt();
            }
        }
        /* ********************************************************************
         * appTextEditAnswer
         */
        TextEdit {
            id: appTextEditAnswer
            width: 200
            text: qsTr("Energy")
            color: Style.textEditColor
        }
        /* ********************************************************************
         * appTextEditFormula
         */
        TextEdit {
            id: appTextEditFormula
            width: 200
            text: qsTr("Formula")
            color: Style.textEditColor
        }
    } // end Column
    /* ********************************************************************
     * calculatIt
     */
    function calculatIt() {
        var f = appTextFieldFrF.text;
        var x = appTextFieldX.text;
        appTextEditAnswer.text = qsTr("Energy") + " = " + (f - (f - x));
        appTextEditFormula.text = qsTr("Formula") + ": " + "E = F - (F - x) ~ E = " + f + " - (" + f + " - " + x + ")";
    }
} // end Page
/* ***************************** End of File ******************************* */

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_width:613}D{i:7;anchors_width:613}
D{i:1;anchors_height:472;anchors_width:622}
}
 ##^##*/
