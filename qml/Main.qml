import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
//import "Database.js" as Db
import "." // QTBUG-34418, singletons require explicit import to load qmldir file

/* ****************************************************************************
 * ApplicationWindow
 */
ApplicationWindow
{
    id: mainWindowId
    property var isThemeLight: true
    visible: true
    width: 1496
    height: 1196
    title: qsTr("Trinary Galaxy Calculator")
    /* ****************************************************************************
     * onCompleted
     * Check theme on start up
     */
    Component.onCompleted:
    {
        var myTheme = Material.Light; // Light or Dark Db.get("theme", "Light");
        switch(myTheme) {
          case "Dark":
              doTheme(Material.Dark);
            break;
          case "Light":
          default:
              doTheme(Material.Light);
        } // end switch
    } // end onCompleted
    /* ****************************************************************************
     * doTheme
     */
    function doTheme(myTheme) {
        switch(myTheme) {
            case Material.Dark:
                isThemeLight = false;
                Material.theme = myTheme;
                Material.accent = Material.Blue;
                Style.textColor = "lightskyblue";
                Style.textEditColor = "white";
                Style.textColorFocus = "lightgrey";
                Style.textColorNoFocus = "darkgrey";
                Style.textColorError = "red";
                Style.textColorWarning = "purple";
                Style.textColorCaution = "yellow";
                console.debug("Main doTheme theme change = Material.Dark");
                break;
            case Material.Light:
            default:
                isThemeLight = true;
                Material.theme = myTheme;
                Material.accent = Material.Purple;
                Style.textColor = "blue";
                Style.textEditColor = "black";
                Style.textColorFocus = "lightgoldenrodyellow";
                Style.textColorNoFocus = "lightskyblue";
                Style.textColorError = "red";
                Style.textColorWarning = "purple";
                Style.textColorCaution = "yellow";
                console.debug("Main doTheme theme change = Material.Light");
        } // end switch
    } // end doTheme
    /* ****************************************************************************
     * SwipeView
     */
    SwipeView
    {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Configuration { id: configurationPage }

        GalaxyCalculator { id: galaxyCalculatorPage }

        EnergyCalculator { id: energyCalculatorPage }

        MadnessMeter { id: madnessMeterPage }

        WorldCalculator { id: worldCalcalculatorPage }

        Calculator { id: calculatorPage }

        //Help { id: helpWindow }

        onCurrentIndexChanged:
        {
            if (currentIndex == 1) {
                // myGalaxy, mySunSize, myLivalbePlanetSize, myTrinaryEngines, myGalaxyRadius, myPrintNthTrack
                galaxyCalculatorPage.calc(configurationPage.xappTextEditGalaxy, configurationPage.xappTextEditSunSize, configurationPage.xappTextEditLivalbePlanetSize, configurationPage.xappTextEditTrinaryEngines, configurationPage.xappTextEditGalaxyRadius, configurationPage.xappTextEditPrintNthTrack);
            }
        } // end onCurrentIndexChanged
    } // end SwipeView
    /* ****************************************************************************
     * TabBar
     */
    footer: TabBar
    {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton
        {
            text: qsTr("Config")
            height: 32
        }
        TabButton
        {
            text: qsTr("Galaxy")
            height: 32
        }
        TabButton
        {
            text: qsTr("E")
            height: 32
        }
        TabButton
        {
            text: qsTr("Madness")
            height: 32
        }
        TabButton
        {
            text: qsTr("World")
            height: 32
        }
        TabButton
        {
            text: qsTr("Calc")
            height: 32
        }
//        TabButton {
//            text: qsTr("Help")
//            height: 32
//            onClicked: {
//                if (helpWindow.visible) { helpWindow.visible = false } else { helpWindow.visible = true }
//            } // end onClicked
//        } // end TabButton
    } // end TabBar
} // end ApplicationWindow
/* ***************************** End of File ******************************* */

