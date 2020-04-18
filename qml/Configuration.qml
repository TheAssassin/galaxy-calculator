import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import "." // QTBUG-34418, singletons require explicit import to load qmldir file
import "Common.js" as Js
/* ****************************************************************************
 * Configuration Page
 */
Page
{
    property alias xappTextEditGalaxy: appTextEditGalaxy.text
    property alias xappTextEditSunSize: appTextEditSunSize.text
    property alias xappTextEditLivalbePlanetSize: appTextEditLivalbePlanetSize.text
    property alias xappTextEditTrinaryEngines: appTextEditTrinaryEngines.text
    property alias xappTextEditGalaxyRadius: appTextEditGalaxyRadius.text
    property alias xappTextEditPrintNthTrack: appTextEditPrintNthTrack.text
    property int myHeight: 42
    title: qsTr("Configuration")
    visible: true
    /* **********************************************************
     * ListModel for Themizer
     */
    ListModel
    {
        id: listModelConfiguration
        Component.onCompleted:
        {
            switch(mainWindowId.myTheme)
            {
                case 0: // "Dark"
                    //console.debug("Configuration ListModel theme change = Material.Dark");
                    radioButtonDark.checked = true;
                    mainWindowId.doTheme(0);
                    break;
                case 1: // "Light"
                default:
                    //console.debug("Configuration ListModel theme change = Material.Light");
                    radioButtonLight.checked = true;
                    mainWindowId.doTheme(1);
            } // end switch
        } // end Component.onCompleted
    } // end ListModel
    /* ************************************************************************
     * Rectangle
     */
    Rectangle
    {
        id: pageRectangle
        color: Style.backgroundColor
        anchors.fill: parent
        /* ******************************************************
         * Galaxy 1
         */
        /* **************************************************
         * Galaxy
         */
        Rectangle
        {
            id: backgroundGalaxy;
            color: (appTextEditGalaxy.activeFocus ? Style.textColorFocus : Style.backgroundColor);
            radius: 5;
            antialiasing: true;
            height: myHeight
            width: pageRectangle.width
            border
            {
                width: 3;
                color: (appTextEditGalaxy.activeFocus ? Style.borderColor : Style.backgroundColor);
            }
            Text
            {
                id: appTextGalaxy
                color: Style.textColor
                text: qsTr("Galaxy")
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit
            {
                id: appTextEditGalaxy
                text: qsTr("Milky Way")
                leftPadding: 6
                color: Style.textEditColor
                Layout.fillWidth: true
                anchors.left: appTextGalaxy.right
                //activeFocus:
            }
        } // end Rectangle
        /* ******************************************************
         * SunSize 2
         */
        Rectangle
        {
            id: backgroundSunSize;
            color: (appTextEditSunSize.activeFocus ? Style.textColorFocus : Style.backgroundColor);
            radius: 5;
            anchors.top: backgroundGalaxy.bottom
            height: myHeight
            width: pageRectangle.width
            antialiasing: true;
            border
            {
                width: 3;
                color: (appTextEditSunSize.activeFocus ? Style.borderColor : Style.backgroundColor);
            }
            Text
            {
                id: appTextSunSize
                color: Style.textColor
                text: qsTr("Sun Size in Miles in Diameter")
                wrapMode: Text.NoWrap
                visible: true
                leftPadding: 6
            }

            TextEdit
            {
                id: appTextEditSunSize
                text: "864575.9"
                anchors.left: appTextSunSize.right
                anchors.leftMargin: 6
                leftPadding: 6
                color: Style.textEditColor
                Layout.fillWidth: true
            }
        }
        /* ******************************************************
         * LivalbePlanetSize 3
         */
        Rectangle
        {
            id: backgroundLivalbePlanetSize;
            color: (appTextEditLivalbePlanetSize.activeFocus ? Style.textColorFocus : Style.backgroundColor);
            radius: 5;
            anchors.top: backgroundSunSize.bottom
            height: myHeight
            width: pageRectangle.width
            antialiasing: true;
            border
            {
                width: 3;
                color: (appTextEditLivalbePlanetSize.activeFocus ? Style.borderColor : Style.backgroundColor);
            }
            Text
            {
                id: appTextLivalbePlanetSize
                color: Style.textColor
                text: qsTr("Livable Planet Size Miles in Diameter")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit
            {
                id: appTextEditLivalbePlanetSize
                text: "7926.2109"
                anchors.left: appTextLivalbePlanetSize.right
                anchors.leftMargin: 6
                leftPadding: 6
                color: Style.textEditColor
                Layout.fillWidth: true
            }
        }
        /* ******************************************************
         * TrinaryEngines 4
         */
        Rectangle
        {
            id: backgroundTrinaryEngines;
            color: (appTextEditTrinaryEngines.activeFocus ? Style.textColorFocus : Style.backgroundColor);
            radius: 5;
            anchors.top: backgroundLivalbePlanetSize.bottom
            height: myHeight
            width: pageRectangle.width
            antialiasing: true;
            border
            {
                width: 3;
                color: (appTextEditTrinaryEngines.activeFocus ? Style.borderColor : Style.backgroundColor);
            }

            Text
            {
                id: appTextTrinaryEngines
                color: Style.textColor
                text: qsTr("Number of Trinary Engines")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit
            {
                id: appTextEditTrinaryEngines
                text: "333"
                anchors.left: appTextTrinaryEngines.right
                anchors.leftMargin: 6
                leftPadding: 6
                color: Style.textEditColor
                Layout.fillWidth: true
            }
        }
        /* ******************************************************
         * GalaxyRadius 5
         */
        Rectangle
        {
            id: backgroundGalaxyRadius;
            color: (appTextEditGalaxyRadius.activeFocus ? Style.textColorFocus : Style.backgroundColor);
            radius: 5;
            anchors.top: backgroundTrinaryEngines.bottom
            height: myHeight
            width: pageRectangle.width
            antialiasing: true;
            border
            {
                width: 3;
                color: (appTextEditGalaxyRadius.activeFocus ? Style.borderColor : Style.backgroundColor);
            }

            Text
            {
                id: appTextGalaxyRadius
                color: Style.textColor
                text: qsTr("Radius of Galaxy in Miles")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit
            {
                id: appTextEditGalaxyRadius
                text: "241828072282107.5071453596951"
                anchors.left: appTextGalaxyRadius.right
                anchors.leftMargin: 6
                leftPadding: 6
                color: Style.textEditColor
                Layout.fillWidth: true
            }
        }
        /* ******************************************************
         * PrintNthTrack 6
         */
        Rectangle
        {
            id: backgroundPrintNthTrack;
            color: (appTextEditPrintNthTrack.activeFocus ? Style.textColorFocus : Style.backgroundColor);
            radius: 5;
            anchors.top: backgroundGalaxyRadius.bottom
            height: myHeight
            width: pageRectangle.width
            antialiasing: true;
            border
            {
                width: 3;
                color: (appTextEditPrintNthTrack.activeFocus ? Style.borderColor : Style.backgroundColor);
            }

            Text
            {
                id: appTextPrintNthTrack
                color: Style.textColor
                text: qsTr("Print Nth Track")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit
            {
                id: appTextEditPrintNthTrack
                leftPadding: 6
                text: "66"
                anchors.left: appTextPrintNthTrack.right
                anchors.leftMargin: 6
                color: Style.textEditColor
                Layout.fillWidth: true
            }
        }
        /* ******************************************************
         * GalaxyWarning 7
         */
        Rectangle
        {
            id: rowLayoutGalaxyWarning
            anchors.top: backgroundPrintNthTrack.bottom
            height: myHeight
            width: pageRectangle.width

            Text
            {
                id: appTextGalaxyWarning
                color: Style.textColorWarning
                text: qsTr("Verify settings, go to Galaxy Tab and wait for Calculation to complete and page to load.")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }
        } // end Rectangle
        /* ******************************************************
         * Themizer 8
         */
        Rectangle
        {
            id: rowLayoutThemizer
            anchors.top: rowLayoutGalaxyWarning.bottom
            anchors.topMargin: 6
            GroupBox
            {
                id: groupBox
                title: qsTr("Theme")

                Column
                {
                    id: column
                    anchors.fill: parent

                    RadioButton
                    {
                        id: radioButtonLight
                        text: qsTr("Light")
                        onClicked:
                        {
                            //console.debug("Material.theme = Material.Light");
                            mainWindowId.myTheme = 1;
                            mainWindowId.doTheme(1);
                        }
                    }

                    RadioButton
                    {
                        id: radioButtonDark
                        text: qsTr("Dark")
                        onClicked:
                        {
                            //console.debug("Material.theme = Material.Dark");
                            mainWindowId.myTheme = 0;
                            mainWindowId.doTheme(0);
                        }
                    }
                } // end Column
            } // end GroupBox
        } // end Themizer
    } // end Rectangle
} // end Page
/* ***************************** End of File ******************************* */
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
