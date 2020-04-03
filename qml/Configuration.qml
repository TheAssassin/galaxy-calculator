import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import "." // QTBUG-34418, singletons require explicit import to load qmldir file
// import "Database.js" as Db
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
    title: qsTr("Configuration")
    visible: true
    /* **********************************************************
     * ListModel
     */
//    ListModel
//    {
//        id: listModelConfiguration
//        Component.onCompleted: {
//            if (Db.get("theme", "Light") === "Light") {
//                console.debug("Configuration ListModel theme change = Material.Light");
//                radioButtonLight.checked = true;
//                mainWindowId.doTheme(Material.Light);
//            } else {
//                console.debug("Configuration ListModel theme change = Material.Dark");
//                radioButtonDark.checked = true;
//                mainWindowId.doTheme(Material.Dark);
//            }
//        } // end Component.onCompleted
//    } // end ListModel
    /* **********************************************************
     * GridLayout
     */
    GridLayout {
        id: grid
        rowSpacing: 2
        anchors.rightMargin: 3
        anchors.bottomMargin: 3
        anchors.leftMargin: 3
        anchors.topMargin: 3
        anchors.fill: parent
        visible: true
        clip: false
        flow: GridLayout.TopToBottom
        rows: 13
        columns: 1

        /* ******************************************************
         * rowLayoutGalaxy
         */
        RowLayout {
            id: rowLayoutGalaxy
            /* **************************************************
             * Galaxy
             */
            Text {
                id: appTextGalaxy
                color: Style.textColor
                text: qsTr("Galaxy")
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit {
                id: appTextEditGalaxy
                width: 200
                text: qsTr("Milky Way")
                leftPadding: 6
                color: Style.textEditColor
            }
        } // end RowLayout
        /* ******************************************************
         * SunSize
         */
        Text {
            id: appTextSunSize
            color: Style.textColor
            text: qsTr("Sun Size in Miles in Diameter")
            wrapMode: Text.NoWrap
            visible: true
            leftPadding: 6
        }

        TextEdit {
            id: appTextEditSunSize
            width: 266
            text: "864575.9"
            leftPadding: 6
            color: Style.textEditColor
        }
        /* ******************************************************
         * LivalbePlanetSize
         */
        Text {
            id: appTextLivalbePlanetSize
            color: Style.textColor
            text: qsTr("Livable Planet Size Miles in Diameter")
            visible: true
            leftPadding: 6
            wrapMode: Text.NoWrap
        }

        TextEdit {
            id: appTextEditLivalbePlanetSize
            width: 266
            text: "7926.2109"
            leftPadding: 6
            color: Style.textEditColor
        }
        /* ******************************************************
         * TrinaryEngines
         */
        RowLayout {
            id: rowLayoutTrinaryEngines
            height: 33

            Text {
                id: appTextTrinaryEngines
                color: Style.textColor
                text: qsTr("Number of Trinary Engines")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit {
                id: appTextEditTrinaryEngines
                width: 200
                text: "333"
                leftPadding: 6
                color: Style.textEditColor
            }
        }
        /* ******************************************************
         * GalaxyRadius
         */
        Text {
            id: appTextGalaxyRadius
            color: Style.textColor
            text: qsTr("Radius of Galaxy in Miles")
            visible: true
            leftPadding: 6
            wrapMode: Text.NoWrap
        }

        TextEdit {
            id: appTextEditGalaxyRadius
            width: 293
            text: "241828072282107.5071453596951"
            leftPadding: 6
            color: Style.textEditColor
        }
        /* ******************************************************
         * PrintNthTrack
         */
        RowLayout {
            id: rowLayoutPrintNthTrack
            height: 33

            Text {
                id: appTextPrintNthTrack
                color: Style.textColor
                text: qsTr("Print Nth Track")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }

            TextEdit {
                id: appTextEditPrintNthTrack
                width: 200
                leftPadding: 6
                text: "66"
                color: Style.textEditColor
            }
        }
        /* ******************************************************
         * GalaxyWarning
         */
        RowLayout {
            id: rowLayoutGalaxyWarning
            height: 33

            Text {
                id: appTextGalaxyWarning
                color: Style.textColorWarning
                text: qsTr("Verify settings, go to Galaxy Tab and wait for Calculation to complete and page to load.")
                visible: true
                leftPadding: 6
                wrapMode: Text.NoWrap
            }
        }
        /* ******************************************************
         * Themizer
         */
//        RowLayout {
//            id: rowLayoutThemizer
//            GroupBox {
//                id: groupBox
//                width: 136
//                height: 96
//                title: qsTr("Theme")

//                Column {
//                    id: column
//                    anchors.fill: parent

//                    RadioButton {
//                        id: radioButtonLight
//                        text: qsTr("Light")
//                        onClicked: {
//                            console.debug("Material.theme = Material.Light")
//                            //Db.set("theme", "Light")
//                            //Material.theme = Material.Light;
//                            mainWindowId.doTheme(Material.Light)
//                        }
//                    }

//                    RadioButton {
//                        id: radioButtonDark
//                        text: qsTr("Dark")
//                        onClicked: {
//                            console.debug("Material.theme = Material.Dark")
//                            //Db.set("theme", "Dark")
//                            //Material.theme = Material.Dark;
//                            mainWindowId.doTheme(Material.Dark)
//                        }
//                    }
//                } // end Column
//            } // end GroupBox
//        } // end Themizer
    } // end GridLayout
} // end Page
/* ***************************** End of File ******************************* */
/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
