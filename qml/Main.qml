import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
import "." // QTBUG-34418, singletons require explicit import to load qmldir file

/* ****************************************************************************
 * ApplicationWindow
 */
ApplicationWindow
{
    id: mainWindowId
    property int myTheme: 1; // Light = 1 or Dark = 0
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
        switch(myTheme) {
          case 0: // "Dark"
              doTheme(Material.Dark);
            break;
          case 1: // "Light"
          default:
              doTheme(Material.Light);
        } // end switch
    } // end onCompleted
    /* ****************************************************************************
     * doTheme
     */
    function doTheme(myTheme) {
        switch(myTheme) {
            case 0: // Material.Dark
                Material.theme = Material.Dark
                Material.accent = Material.Blue;
                Style.textColor = "lightskyblue";
                Style.textEditColor = "white";
                Style.textColorFocus = "lightgrey";
                Style.textColorNoFocus = "darkgrey";
                Style.textColorError = "red";
                Style.textColorWarning = "purple";
                Style.textColorCaution = "yellow";
                galaxyCalculatorPage.headerBgColor = "grey";
                galaxyCalculatorPage.headerFgColor = "white";
                galaxyCalculatorPage.dataBgColor = "silver";
                galaxyCalculatorPage.dataFgColor  = "white";
                console.debug("Main doTheme theme change = Material.Dark");
                break;
            case 1: // Material.Light
            default:
                Material.theme = Material.Light
                Material.accent = Material.Purple;
                Style.textColor = "blue";
                Style.textEditColor = "black";
                Style.textColorFocus = "lightgoldenrodyellow";
                Style.textColorNoFocus = "lightskyblue";
                Style.textColorError = "red";
                Style.textColorWarning = "purple";
                Style.textColorCaution = "yellow";
                galaxyCalculatorPage.headerBgColor = "silver";
                galaxyCalculatorPage.headerFgColor = "white";
                galaxyCalculatorPage.dataBgColor = "white";
                galaxyCalculatorPage.dataFgColor  = "black";
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

        onCurrentIndexChanged:
        {
            if (currentIndex == 1) {
                galaxyCalculatorPage.busyTimer.start();
            }
        } // end onCurrentIndexChanged
    } // end SwipeView
    /* ************************************************************************
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
    } // end TabBar
} // end ApplicationWindow
/* ***************************** End of File ******************************* */

