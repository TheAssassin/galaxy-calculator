import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

/* ****************************************************************************
 * Madness Meter Page
 */
Page
{
    title: qsTr("Madness Meter")
    visible: true
    /* **********************************************************
     * GroupBox
     */
    GroupBox {
        id: groupBoxUniverse
        x: 6
        y: 6
        width: 480
        height: 113
        title: "Which Universe do you believe in?"
        leftPadding: 6
        rightPadding: 16
        bottomPadding: 16
        topPadding: 16
        /* **********************************************************
         * Column
         */
        Column {
            id: column2
            width: 366
            height: 118
            spacing: 0
            /* **********************************************************
             * RadioButton
             */
            RadioButton {
                id: radioButtonDynamic
                text: qsTr("Dynamic Universe of Albert Einsteins")
                leftPadding: 6
                padding: 0
                spacing: 6
                indicator.width: 16
                indicator.height: 16
                onClicked: {
                    if (radioButtonDeity.checked || radioButtonGodless.checked && ! radioButtonLight.checked) {
                        appTextSanity.text = qsTr("Insane");
                    } else {
                        appTextSanity.text = qsTr("Partially Insane");
                    }
                }
            }
            /* **********************************************************
             * RadioButton
             */
            RadioButton {
                id: radioButtonNewtonian
                text: qsTr("Newtonian Universe")
                leftPadding: 6
                padding: 0
                indicator.width: 16
                indicator.height: 16
                onClicked: {
                    if (radioButtonDeity.checked || radioButtonGodless.checked) {
                        appTextSanity.text = qsTr("Partially Insane");
                    } else {
                        if (radioButtonLight.checked)
                            appTextSanity.text = qsTr("Sane");
                        else
                            appTextSanity.text = qsTr("Check God");
                    }
                }
            }
            /* **********************************************************
             * RadioButton
             */
            RadioButton {
                id: radioButtonOther
                text: qsTr("Other Universe")
                leftPadding: 6
                padding: 0
                indicator.width: 16
                indicator.height: 16
                onClicked: {
                    if (radioButtonDeity.checked || radioButtonGodless.checked && ! radioButtonLight.checked) {
                        appTextSanity.text = qsTr("Insane");
                    } else {
                        appTextSanity.text = qsTr("Partially Insane");
                    }
                }
            }
        } // end Column
    } // end GroupBox
    /* **********************************************************
     * GroupBox
     */
    GroupBox {
        id: groupBoxGod
        x: 6
        y: 127
        width: 480
        height: 107
        bottomPadding: 16
        title: "What do you believe God is?"
        leftPadding: 6
        topPadding: 16
        /* **********************************************************
         * Column
         */
        Column {
            id: column3
            height: 118
            /* **********************************************************
             * RadioButton
             */
            RadioButton {
                id: radioButtonDeity
                text: qsTr("Deity")
                leftPadding: 6
                padding: 0
                indicator.width: 16
                indicator.height: 16
                onClicked: {
                    if (radioButtonOther.checked || radioButtonDynamic.checked && ! radioButtonNewtonian.checked) {
                        appTextSanity.text = qsTr("Insane");
                    } else {
                        appTextSanity.text = qsTr("Partially Insane");
                    }
                }
            }
            /* **********************************************************
             * RadioButton
             */
            RadioButton {
                id: radioButtonLight
                text: qsTr("All Light without Darkness: as in Energy")
                leftPadding: 6
                padding: 0
                indicator.width: 16
                indicator.height: 16
                onClicked: {
                    if (radioButtonOther.checked || radioButtonDynamic.checked) {
                        appTextSanity.text = qsTr("Partially Insane");
                    } else {
                        if (radioButtonNewtonian.checked)
                            appTextSanity.text = qsTr("Sane");
                        else
                            appTextSanity.text = qsTr("Check Universe");
                    }
                }
            }
            /* **********************************************************
             * RadioButton
             */
            RadioButton {
                id: radioButtonGodless
                text: qsTr("I do not believe in God")
                leftPadding: 6
                padding: 0
                indicator.width: 16
                indicator.height: 16
                onClicked: {
                    if (radioButtonOther.checked || radioButtonDynamic.checked && ! radioButtonNewtonian.checked) {
                        appTextSanity.text = qsTr("Insane");
                    } else {
                        appTextSanity.text = qsTr("Partially Insane");
                    }
                }
            }
        } // end Column
    } // end GroupBox

    Text {
        id: appTextSanity
        x: 6
        y: 253
        text: qsTr("Check Boxes that Apply to you.")
        color: Style.textColor
    }

} // end Page

/* ***************************** End of File ******************************* */

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
