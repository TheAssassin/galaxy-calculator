import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import TableModel 0.1
import "Common.js" as Js
import "BigNumberMath.js" as BigNumberMath
/* ****************************************************************************
 * Galaxy Calculator
 */
Page
{
    property bool isBusy: true
    property alias busyTimer: busyTimer
    property string headerBgColor: "grey"
    property string headerFgColor: "white"
    property string dataBgColor: "white"
    property string dataFgColor: "black"
    property alias myTableView: myTableView
    property alias myTableModel: myTableModel
    title: qsTr("Galaxy Calculator")
    visible: true
    /** ***********************************************************************
     * Loader:
     * show will set sourceComponent to component, loading page
     * hide will set sourceComponent to undefined, unloading page
     */
    Loader
    {
        id: loaderGalaxyCalculator
        function show(component) {
            sourceComponent = component;
        }
        function hide(){
            sourceComponent = undefined;
        }
    }
    /* ******************************************************
     * BusyIndicator
     */
    BusyIndicator
    {
        id: busyIndicator
        anchors.fill: parent
        running: isBusy
    }
    /* ************************************************************************
     * Timer
     */
    Timer
    {
        id: busyTimer
        onTriggered:
        {
            busyTimer.stop();
            // myGalaxy, mySunSize, myLivalbePlanetSize, myTrinaryEngines, myGalaxyRadius, myPrintNthTrack
            galaxyCalculor(configurationPage.xappTextEditGalaxy, configurationPage.xappTextEditSunSize, configurationPage.xappTextEditLivalbePlanetSize, configurationPage.xappTextEditTrinaryEngines, configurationPage.xappTextEditGalaxyRadius, configurationPage.xappTextEditPrintNthTrack);
        }
    }
    /* **********************************************************
     * TableView
     */
    TableView
    {
        id: myTableView
        anchors.fill: parent
        anchors.topMargin: 9
        anchors.leftMargin: 6
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        ScrollBar.horizontal: ScrollBar {}
        ScrollBar.vertical: ScrollBar {}
        //                       "Track,Trinary Engines,Max,Min,Frequency,Distance,Track Frequency"
        property var columnWidths: [99, 233,            166,133,166,      413,     263]
        columnWidthProvider: function (column) { return columnWidths[column] }

        Timer
        {
            running: true
            interval: 2000
            onTriggered:
            {
                myTableView.forceLayout();
            }
        }

        model: TableModel
        {
            id: myTableModel
        }

        delegate: Rectangle
        {
            id: myTableViewDelegate
            implicitHeight: 50
            border.color: "black"
            border.width: 2
            color: (heading) ? headerBgColor : dataBgColor

            Text
            {
                id: myTableText
                text: tabledata
                color: (heading) ? headerFgColor : dataFgColor
                anchors.right: parent.right
            } // end Text
        } // end delegate
    } // end TableView
    /* ****************************************************************************
     * Galaxy Calculor
     */
    function galaxyCalculor(myGalaxy, mySunSize, myLivalbePlanetSize, myTrinaryEngines, myGalaxyRadius, myPrintNthTrack) {
        myTableModel.newTable();
        var vStorage;
        // 1 / 137.03599913 is not more accurate
        // var trinaryMarker = ( 1/137 );
        // 0.0072992700729
        // 0.0072992700729928
        // 0.007299270072992803
        // 0.00729927007299270073
        // 0.0072992700730
        var trinaryMarker = BigNumberMath.dividedBy("1", "137", 13);
        if (Js.getIsDebugMessage())
            console.debug("trinaryMarker=" + trinaryMarker);
        /*
             * 42          3.141592653589793238462643383279502884197169
             * 100         3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679
             * 355 / 113 = 3.14159292035398230088495575221238938053263786810735899116172564465
             * 333 / 106 = 3.14150943396226415094339622641509433962752091994680949531609664223
             * 22  / 7   = 3.1428571428571428571428571428571428571411778652131110178457589478
             */
        var pIe = "3.14159265359";
        // PI: based on this version, to use a higher or lower Precession would require recalculate of baseline.
        // do not use Math.PI=3.141592653589793
        // this uses 11 bits which is what Newton used, the above uses 15
        // Constant Precession Rate: Constant in Newtons work.
        var cpRate = "324.540503";
        // Newtons Constant for Earths Atmospheric Density based on Torr
        // I Calculated from Trinary Engines to make it generic to all Planets
        var lpDensity = "73.120284";
        // Atmospheric Pressure Index acts as a Dampener for the Core Frequency causing it to expand at a known Rate based on its Size.
        // Livable Planet Ring Frequency: aP is based on Planet Earth, I do not make this an Arguments because I have no way of getting this data
        // Torr is a unit of pressure based on an absolute scale defined as 1/760
        // Newtons Constant for Earths Atmospheric Density based on Torr
        // Note: Torr came from the Torah AKA Bible
        // var aP = ( lpDensity * (1/760) );
        // 0.00131578947368421053
        // 0.001315789
        vStorage = BigNumberMath.dividedBy("1", "760", 9);
        // 55571.4358457169044580856
        // 55571.435845717
        var aP = BigNumberMath.times(lpDensity, vStorage, 9);
        // aP=( lpDensity * (1/760) )=73.120284 * 0.001315789 = 0.096210865
        if (Js.getIsDebugMessage())
            console.debug("aP=( lpDensity * (1/760) )=" + lpDensity + " * " + vStorage + " = " + aP)
        // Planets Trinary Engine Rings: First=.0001, Second=0.001, Third=.01
        var ringPlanetSecond = "0.001";
        // Used to iterate
        var currentNth = 0;
        // Used to iterate
        var printThis = 1;
        // Number of Printed lines
        var printedLines = 0;
        // Used for Track Engine Counter
        var trackEngines = 0;
        // Read in configuration
        // Our Galaxy = Milkey Way
        if (Js.getIsDebugMessage())
            console.debug("myGalaxy = " + myGalaxy)
        var galaxyName = myGalaxy;
        // in Miles in Diameter
        // Sun=864575.9
        if (Js.getIsDebugMessage())
            console.debug("mySunSize = " + mySunSize)
        var sunSize = parseFloat(mySunSize);
        // in Miles in Diameter
        // Earth = 7926.2109;
        if (Js.getIsDebugMessage())
            console.debug("myLivalbePlanetSize = " + myLivalbePlanetSize)
        var livePlanetSize = parseFloat(myLivalbePlanetSize);
        // This number is negative, Taken from Configuraton
        // Our Solar System as 333, so to test this system set this to Negative;
        if (Js.getIsDebugMessage())
            console.debug("myTrinaryEngines = " + myTrinaryEngines)
        var trinaryEngines = parseInt(myTrinaryEngines, 10) * -1;
        // in Miles in Diameter, Taken from Configuraton
        // Milkey Way = 241828072282107.5071453596951;
        if (Js.getIsDebugMessage())
            console.debug("myGalaxyRadius = " + myGalaxyRadius)
        var galaxyRadius = parseFloat(myGalaxyRadius).toPrecision(20);
        // Taken from Configuraton
        if (Js.getIsDebugMessage())
            console.debug("myPrintNthTrack = " + myPrintNthTrack)
        var printNthTrack = parseInt(myPrintNthTrack, 10);
        // Now Calculate based on Defaults from configuration
        // Liveable Planet Ring Frequency: 7926.2109 * .001 = 7.9262109 - aP = 7.830 Hz
        // var lpRingFreq=((livePlanetSize * ringPlanetSecond) - aP );
        // 7.9262109
        // 7.926
        vStorage = BigNumberMath.times(livePlanetSize, ringPlanetSecond, 3);
        var lpRingFreq = BigNumberMath.minus(vStorage, aP, 3);
        // 7926.2109 * 0.001 - 55571.435845717 = -55563.510
        if (Js.getIsDebugMessage())
            console.debug("lpRingFreq=((livePlanetSize * ringPlanetSecond) - aP ) " + livePlanetSize + " * " + ringPlanetSecond + " - " + aP + " = " + lpRingFreq)
        //console.debug("subtract lpRingFreq = " + lpRingFreq )
        //console.debug("subtract lpRingFreq - aP ~ vStorage - Ap " + vStorage + " - " + aP)


        // Precession Rate: Sun: 10,656 / 4 = 2664
        // var pRate = ( sunSize / cpRate );
        var pRate = BigNumberMath.dividedBy(sunSize, cpRate, 0);
        // 2664
        if (Js.getIsDebugMessage())
            console.debug("pRate=" + pRate)
        // Precession: you must remove the speed required to over come it.
        var maxErrorRate = pRate;
        // To print Life Track: based on Trinary Engines
        // Tracks are based on how many Trinary Engines the Solar System has
        // Do Not Skip This Track
        var doNotSkipThisTrack=(Math.abs(trinaryEngines)*2);
        // I adjusted the date as to not need this, but its still required
        // I adjusted so each track accumalates 1 unit more of this quantity
        // The Minimum Error Rate is an Accoumalation of Errors incounterd on each track
        // As such this is just a counter of errors minimized
        // This is a Calculus Error handler, so I have a Max and Min Operator
        var minErrorRate = 0;
        // Iteration Ranges
        // maxIteration: The longest an Iteration can be
        // (Diameter in miles) x 1/137 / (3 Phase) = Max Iteration in years
        //var maxIteration = (( sunSize * trinaryMarker ) / 3 );
        vStorage = BigNumberMath.times(sunSize, trinaryMarker, 0);
        var maxIteration = BigNumberMath.dividedBy(vStorage, 3, 16);
        maxIteration = Math.floor(maxIteration);
        // 2103
        //console.debug("maxIteration=" + maxIteration + " vStorage=" + vStorage)
        // aveIteration: Based on Suns Magnetic Polarity Reversals
        // Sun changes polarity 10 (0 - 9) times a Century: 100 - 9 = 91
        // var aveIteration = ( maxIteration - 91 );
        var aveIteration = BigNumberMath.minus(maxIteration, "91", 0);
        // 2012
        // minIteration: Based on Max Min of Magnetic Fields
        // I hard coded date so I did not need Error Rate: Adds down to 6
        // Note this Number 1104 was determined from long running results done by Newton
        // This number is also found in the Torah
        // var minIteration = ( maxIteration - 1104 )
        var minIteration = BigNumberMath.minus(maxIteration, "1104", 0);
        // 999
        // maxSpeed: As it begins decent into Galactic Plane
        var maxSpeed = "0.0";
        // minSpeed: At its Maximum Amplitude
        var minSpeed = "0.0";
        // Note that there are two ways to get this value; below and using the Livable Planets Properties
        // Earth for example: Orbital distance in Miles around Sun = 584,000,000 / (365 Days * 24 Hours) = 66,666.666 MPH * .0001 = 6.6666666 Hz
        // So this is a Double Verification Process; proving that this Math actually works both ways which is Magic proving God Designed this.
        // Frequency: maxSpeed * ringSunFirst = Frequency of Livable Planet
        var lpFrequency = "0.0";
        // This is based on the First Ring of the Sun
        // Sun: First=0.00001, Second=0.0001, Third=.001: One Magnitude different then Planets
        var ringSunFirst = "0.00001";
        // Orbital Distance in Miles around the Track.
        var orbitDist = 0;
        // Track Frequency Multiplier based on Galaxy Ring of Power; 13 is Masonic Number in Bible
        var trackFreqMultiplier = "0.0000000000001"; // JavaScript=1e-13
        // Track Frequency: .0000000000001 * |minSpeed|
        var trackFreq = "0.0";
        // Track Number
        // Total number of Tracks: twice trinaryEngines ~ 666 * 2 + 1 since its 0 based: 1333
        var totalTracks = 0;
        // Counter for loop
        var currentTrackNumber = 0;

        //console.debug("Js.getIsDebugMessage()=" + Js.getIsDebugMessage())
        if (Js.getIsDebugMessage()) {
            console.debug("galaxyName=" + galaxyName);
            console.debug("sunSize=" + sunSize);
            console.debug("livePlanetSize=" + livePlanetSize);
            console.debug("trinaryEngines=" + trinaryEngines);
            console.debug("galaxyRadius=" + galaxyRadius);
            console.debug("printNthTrack=" + printNthTrack);

            console.debug("totalTracks=" + totalTracks);
            console.debug("currentTrackNumber=" + currentTrackNumber);
            console.debug("trinaryMarker=" + trinaryMarker);
            console.debug("pIe=" + pIe);
            console.debug("cpRate=" + cpRate);
            console.debug("lpDensity=" + lpDensity);
            console.debug("aP=" + aP);
            console.debug("ringPlanetSecond=" + ringPlanetSecond);
            console.debug("currentNth=" + currentNth);
            console.debug("printThis=" + printThis);
            console.debug("printedLines=" + printedLines);
            console.debug("trackEngines=" + trackEngines);
            console.debug("lpRingFreq=" + lpRingFreq);
            console.debug("pRate=" + pRate);
            console.debug("doNotSkipThisTrack=" + doNotSkipThisTrack);
            console.debug("maxErrorRate=" + maxErrorRate);
            console.debug("minErrorRate=" + minErrorRate);
            console.debug("maxIteration=" + maxIteration);
            console.debug("aveIteration=" + aveIteration);
            console.debug("minIteration=" + minIteration);
            console.debug("maxSpeed=" + maxSpeed);
            console.debug("minSpeed=" + minSpeed);
            console.debug("lpFrequency=" + lpFrequency);
            console.debug("ringSunFirst=" + ringSunFirst);
            console.debug("orbitDist=" + orbitDist);
            console.debug("trackFreqMultiplier=" + trackFreqMultiplier);
            console.debug("trackFreq=" + trackFreq);
        }

        var ans;
        // Calculate or set all varibles
        trackEngines = trinaryEngines;
        // Calculate Total Tracks: absolute value * 2, then * 2, then add 1
        // Note: I do not reply on Order of Precedence in Math
        // () forces the calculation
        // People that try to Optimize Math forget what they are doing
        // I do not want to be Cleaver I want to be Clear
        totalTracks=(((Math.abs(trinaryEngines) * 2) * 2) + 1 );
        maxErrorRate = parseInt(maxErrorRate, 10);
        // for loop
        for ( currentTrackNumber = 0; currentTrackNumber < totalTracks; currentTrackNumber++ )  {
            //console.debug("Working on: " + currentTrackNumber);
            // Orbital Distance
            // ((241828072282107.5071453596951 * 666) * 2) * 3.14159265359
            // echo "$(bc <<< "scale=13;((241828072282107.5071453596951 * 666) * 2) * 3.14159265359")"
            // 1011954093357316199.999999999911810770784788
            // orbitDist = ((( Number.parseFloat(galaxyRadius).toPrecision(20) * currentTrackNumber) * 2) * Number.parseFloat(pIe).toPrecision(12) );
            vStorage = BigNumberMath.times(galaxyRadius, currentTrackNumber, 13);
            orbitDist = BigNumberMath.times(vStorage, "2", 13);
            vStorage = BigNumberMath.times(orbitDist, pIe, 13);
            // JavaScript off by 100 Miles, C++ off by 103 miles, use boost
            // orbitDist = ((( galaxyRadius * currentTrackNumber) * 2) * pIe );
            orbitDist = BigNumberMath.format(vStorage, 0);
            // maxSpeed
            if ( trackEngines <= 0 ) {
                vStorage = BigNumberMath.times(aveIteration, trackEngines, 42);
                maxSpeed = BigNumberMath.plus(vStorage, maxErrorRate, 16);
                maxSpeed = Math.floor(maxSpeed);
                //maxSpeed = (( aveIteration * trackEngines) + maxErrorRate );
            } else {
                // aveIteration * trackEngines - maxErrorRate
                vStorage = BigNumberMath.times(aveIteration, trackEngines, 42);
                maxSpeed = BigNumberMath.minus(vStorage, maxErrorRate, 0);
                maxSpeed = Math.floor(maxSpeed);
                //maxSpeed = (( aveIteration * trackEngines) - maxErrorRate );
            }
            if ( doNotSkipThisTrack === currentTrackNumber ) {
                if (Js.getIsDebugMessage()) {
                    console.debug("******************* orbitDist=" + orbitDist)
                    console.debug("galaxyRadius=" + galaxyRadius)
                    console.debug("pIe=" + pIe)
                    console.debug("orbitDist=" + orbitDist)
                    console.debug("maxSpeed=" + maxSpeed)
                }
            }
            // minSpeed
            if ( trackEngines <= 0 ) {
                vStorage = BigNumberMath.times(minIteration, trackEngines, 42);
                minSpeed = BigNumberMath.minus(vStorage, minErrorRate, 13);
                if ( doNotSkipThisTrack === currentTrackNumber ) {
                    if (Js.getIsDebugMessage())
                        console.debug("minSpeed: minIteration * trackEngines - minErrorRate=" + minIteration + " * " + trackEngines + " - " + minErrorRate + " = " + minSpeed)
                }
                minSpeed = Math.floor(minSpeed);
                //minSpeed = (( minIteration * trackEngines) - minErrorRate );
            } else {
                minSpeed = BigNumberMath.times(minIteration, trackEngines, 42);
                minSpeed = BigNumberMath.plus(minSpeed, minErrorRate, 13);
                if ( doNotSkipThisTrack === currentTrackNumber ) {
                    if (Js.getIsDebugMessage())
                       console.debug("minSpeed: minIteration * trackEngines - minErrorRate=" + minIteration + " * " + trackEngines + " + " + minErrorRate + " = " + minSpeed)
                }
                minSpeed = Math.floor(minSpeed);
                //minSpeed = (( minIteration * trackEngines) + minErrorRate );
            }
            // lpFrequency
            lpFrequency = BigNumberMath.times(maxSpeed, ringSunFirst, 4);
            lpFrequency = lpFrequency.substring(0, lpFrequency.length - 1)
            if (Js.getIsDebugMessage())
                console.debug("lpFrequency: maxSpeed * ringSunFirst = " + maxSpeed + " * " + ringSunFirst  + " = " + lpFrequency)
            // lpFrequency = ( maxSpeed * ringSunFirst );
            // trackFreq
            //console.debug("minSpeed=" + minSpeed + " abs(minSpeed)=" + abs(minSpeed))
            trackFreq = BigNumberMath.times(trackFreqMultiplier, BigNumberMath.abs(minSpeed), 16);
            // These Calculations are meaningless
            if ( trackEngines === trinaryEngines || trackEngines === 0 || trackEngines === 1 || trackEngines === -1) {
                trackFreq = 0;
            }
            // Now do the Math
            if ( trackFreq !== 0 ) {
                trackFreq = BigNumberMath.dividedBy(1, trackFreq, 16);
            }
            // Format: Round
            if ( trackEngines <= 0 ) {
                trackFreq = BigNumberMath.format(trackFreq, 0);
            } else {
                trackFreq = BigNumberMath.format(trackFreq, 0);
            }
            //
            currentNth = currentNth + 1;
            if ( printNthTrack === currentNth ) {
                currentNth = 0;
                printThis = 1;
            } else {
                printThis = 0;
            }
            // always show 666 or Life Track
            if ( doNotSkipThisTrack === currentTrackNumber ) {
                printThis = 1;
            }
            //
            if ( printThis === 1 ) {
                // 666 | 333 | 666,666 | 333,333 | 6.66666 | 1,011,954,093,357,316,200 | 30,000,030
                // 666 | 666 |
                //console.debug("trackEngines=" + trackEngines)
                trackEngines = Math.floor(trackEngines);
                //console.debug("trackEngines=" + trackEngines)
                //console.debug("before maxSpeed=" + maxSpeed + " minSpeed=" + minSpeed)
                maxSpeed = BigNumberMath.format(maxSpeed, 0);
                minSpeed = BigNumberMath.format(minSpeed, 0);
                //console.debug("maxSpeed=" + maxSpeed + " minSpeed=" + minSpeed)
                // Save to Database
                //console.debug("myTableModel.insertRecord(currentTrackNumber=" + currentTrackNumber + ", trackEngines=" + trackEngines + ",  maxSpeed=" + maxSpeed + ",  minSpeed=" + minSpeed + ",  lpFrequency=" + lpFrequency + ",  orbitDist=" + orbitDist + ",  trackFreq=" + trackFreq)
                myTableModel.insertRecord(currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq);
                // Increament printed linies
                printedLines = printedLines + 1;
            } // end if ( printThis === 1 )
            // Increment Variables
            trackEngines = trackEngines + 1;
            maxErrorRate = maxErrorRate + 1;
            minErrorRate = minErrorRate + 1;
        } // end for currentTrackNumber < totalTracks
        console.debug("########### calc finished ############################")
        isBusy = false;
    } // end galaxyCalculor
} // end Page
/* ***************************** End of File ******************************* */
