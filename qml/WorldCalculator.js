.import "BigNumberMath.js" as BigNumberMath
/* ****************************************************************************
 * Trinary JavaScript
 * Last Update: 8 May 2019
 * Copyleft by: Jeffrey Scott Flesher
 */
/* ****************************************************************************
 * IsDebugMessage
 * true or false
 */
var IsDebugMessage = false;
function getIsDebugMessage() {
    return IsDebugMessage;
}
function setIsDebugMessage(isDebugMessage) {
    IsDebugMessage = isDebugMessage;
}
/* ****************************************************************************
 *  RotationSpeed
 */
var RotationSpeed = "0";
function getRotationSpeed() {
    return RotationSpeed;
}
function setRotationSpeed(rotationSpeed) {
    RotationSpeed = rotationSpeed;
}
/* ****************************************************************************
 * OrbitalSpeed
 */
var OrbitalSpeed = "0";
function getOrbitalSpeed() {
    return OrbitalSpeed;
}
function setOrbitalSpeed(orbitalSpeed) {
    OrbitalSpeed = orbitalSpeed;
}
/* ****************************************************************************
 * PlanetDiameter
 */
var PlanetDiameter = "0.0";
function getPlanetDiameter() {
    return PlanetDiameter;
}
function setPlanetDiameter(planetDiameter) {
    PlanetDiameter = planetDiameter;
}
/* ****************************************************************************
 * PlanetRotation
 */
var PlanetRotation = "0.0";
function getPlanetRotation() {
    return PlanetRotation;
}
function setPlanetRotation(planetRotation) {
    PlanetRotation = planetRotation;
}
/* ****************************************************************************
 * OrbitalDistance
 */
var OrbitalDistance = "0.0";
function getOrbitalDistance() {
    return OrbitalDistance;
}
function setOrbitalDistance(orbitalDistance) {
    OrbitalDistance = orbitalDistance;
}
/* ****************************************************************************
 * OrbitalPeriod
 */
var OrbitalPeriod = "0.0";
function getOrbitalPeriod() {
    return OrbitalPeriod;
}
function setOrbitalPeriod(orbitalPeriod) {
    OrbitalPeriod = orbitalPeriod;
}
/* ****************************************************************************
 *  calc Speeds
    Orbital Speeds
    Minimum: 333,333
    Maximum: 666,666
    Current: 477,354.850
    Variable: 7.826 hertz
    Minimum: 3.333
    Maximum: 6.666
    I need to write the Math Formula that uses this Variable to calculate the Speed.
    Average Speed = Distance / (Days * 24)
    Variable is Frequency and Wavelength and realates to Earths Resonant frequency of 7.826 hz currently
    If the Frequency is 7.826 hz, what is the Wavelenght,
    Frequency * Wavelenght = Speed, maximum is the Speed of Light
    calcSpeeds(cb_diameter_miles, cb_sidereal_day, cb_orbital_distance_miles, cb_orbital_period_days);
 */
/*
584000000 / (365 * 24) = 66666.666666667
584000000 / 8760 = 67,000 mph

BigNumber a * b= 7926.2109 * 3.141592653589793 = 24900.9259342433414053437 formated: 24900.9259342433414053
BigNumber a * b= 0.99726968 * 24 = 23.93447232 formated: 23.93447232
BigNumber a / b= 24900.9259342433414053 / 23.93447232 = 1040.37914859045204157231 formated: 1040.379
BigNumber a * b= 365 * 24 = 8760 formated: 8760
BigNumber a / b= 584000000 / 8760 = 66666.66666666666666666667 formated: 66666.667

7926.2109, 0.99726968, 584000000, 365
*/
function calcSpeeds(myDiameter, myRotation, myOrbitalDistance, myOrbitalPeriod) {
    /* Rotational */
    //let rotation_result = (myDiameter * Math.PI) / (myRotation * 24);
    let tempResultA = BigNumberMath.times(myDiameter.replace(',',''), Math.PI, 16);
    let tempResultB = BigNumberMath.times(myRotation.replace(',',''), 24, 8);
    let rotation_result = BigNumberMath.dividedBy(tempResultA, tempResultB, 3);

    setRotationSpeed( BigNumberMath.format(rotation_result, 3) );
    /* Orbital */
    // let obrital_result = ( myOrbitalDistance / (myOrbitalPeriod * 24) );
    tempResultB = BigNumberMath.times(myOrbitalPeriod.replace(',',''), 24, 0);
    let obrital_result = BigNumberMath.dividedBy( myOrbitalDistance.replace(',',''), tempResultB, 4 );
    obrital_result = obrital_result.substring(0, obrital_result.length - 1)
    setOrbitalSpeed( BigNumberMath.format(obrital_result, 3) );
}
/* ****************************************************************************
 * preset Combo Box: Sun, Mercury, Venus, Earth, Moon, Mars, Jupiter, Saturn, Uranus, Neptune
 * Total of 333: Show only a selected few
 * Notes: cb must not be a number, cb === 1 does not work
 * I use 365 and not 365.2, this is to keep the numbers whole,
 * in reality this an average and not the actual speed,
 * this calculation needs a Maximum, Minimum and Current,
 * set useJulianDays to 1 to change this to Julian days.
 */
function presetCB(cb) {
    if (getIsDebugMessage())
        console.debug("presetCB=" + cb)
    let tempResultA = "0";
    let useJulianDays = 0;
    let earthYearInDays = "365";
    if (useJulianDays === 1) {
        earthYearInDays = "365.256";
    }
    // alert("cb=" + cb);
    let cb_diameter_miles         = "7926.2109";
    let cb_sidereal_day           = "0.99726968";
    let cb_orbital_period_days    = earthYearInDays;  // Revolution period 365
    let cb_orbital_distance_miles = "584000000";
    /* Sun 483,000 to 514,495 miles per hour or 669,600,000.000 */
    if (cb === 0) {
        cb_diameter_miles         = "864575.9"; // 864948.7  864575.9 864938
        cb_sidereal_day           = "25.379995";

        //cb_orbital_distance_miles = (2 * 161057496139894200) * Math.PI; // 1011954093357316200
        tempResultA = BigNumberMath.times(2, "161057496139894200", 0);
        if (getIsDebugMessage())
            console.debug("tempResultA=" + tempResultA)
        cb_orbital_distance_miles = BigNumberMath.times(tempResultA, Math.PI, 0);

        //cb_orbital_period_days    = 242000000 * earthYearInDays;  // 88330000000
        cb_orbital_period_days    = BigNumberMath.times("242000000", earthYearInDays, 0);  // 88330000000
    }
    /* Mercury orbits the sun 105,947 or 105,954.682 miles */
    if (cb === 1) {
        cb_diameter_miles         = "3031.9186";
        cb_sidereal_day           = "58.646225";
        cb_orbital_distance_miles = "223700000";
        cb_orbital_period_days    = "87.97";
    }
    /* Venus orbits the sun 78,341 or 78,345.201 miles per hour */
    if (cb === 2) {
        cb_diameter_miles         = "7521.0769";
        cb_sidereal_day           = "243.0187";
        cb_orbital_distance_miles = "422500000";
        cb_orbital_period_days    = "224.7";
    }
    /* Earth orbits the sun  */
    if (cb === 3) {
        cb_diameter_miles         = "7926.2109";
        cb_sidereal_day           = "0.99726968";
        cb_orbital_distance_miles = "584000000";
        cb_orbital_period_days    = earthYearInDays;  // 365 or 365.256
        /*
        584000000 / (365 * 24) = 66666.666666667
        584000000 / 8760 = 67,000 mph

        BigNumber a * b= 7926.2109 * 3.141592653589793 = 24900.9259342433414053437 formated: 24900.926
        BigNumber a * b= 0.99726968 * 24 = 23.93447232 formated: 23.934
        BigNumber a * b= 365 * 24 = 8760 formated: 8760.000
        BigNumber a * b= 584000000 * 8760.000 = 5115840000000 formated: 5115840000000.000
        */
    }
    /* Moon orbits Earth at a speed of 2,288 or 2,286.032 miles per hour */
    if (cb === 4) {
        cb_diameter_miles         = "2159";
        cb_sidereal_day           = "27.321661";
        cb_orbital_distance_miles = "1499070"; // 477168.801082 452954.96804 1423000  1499070
        cb_orbital_period_days    = "27.323";
    }
    /* Mars orbits the sun 53,979 or 53,858.919 miles per hour */
    if (cb === 5) {
        cb_diameter_miles         = "4217.246";
        cb_sidereal_day           = "1.02595675";
        cb_orbital_distance_miles = "888000000";
        cb_orbital_period_days    = "686.98";
    }
    /* Jupiter orbits the sun 29,236 miles per hour or 29,220.354 */
    if (cb === 6) {
        cb_diameter_miles         = "88731.8063";
        cb_sidereal_day           = "0.41007";
        cb_orbital_distance_miles = "3037000000";
        cb_orbital_period_days    = "4330.6";
    }
    /* Saturn orbits the sun 21,637 miles per hour or 21,561.823 */
    if (cb === 7) {
        cb_diameter_miles         = "74974.6481";
        cb_sidereal_day           = "0.426";
        cb_orbital_distance_miles = "5565900000";
        cb_orbital_period_days    = "10755.7";
    }
    /* Uranus orbits the sun 15,290 miles per hour or 15,210.065 Equatorial rotation velocity 5791.18 mph */
    if (cb === 8) {
        cb_diameter_miles         = "31763.253";
        cb_sidereal_day           = "0.71833";
        cb_orbital_distance_miles = "11201300000";
        cb_orbital_period_days    = "30685";
    }
    /* Neptune orbits the sun 12,253 miles per hour or 12,157.543 */
    if (cb === 9) {
        cb_diameter_miles         = "30775.272";
        cb_sidereal_day           = "0.67125";
        cb_orbital_distance_miles = "17562300000";
        cb_orbital_period_days    = "60190";
    }
    setPlanetDiameter(BigNumberMath.format(cb_diameter_miles, 3));
    setPlanetRotation(cb_sidereal_day);
    setOrbitalDistance(BigNumberMath.format(cb_orbital_distance_miles, 3));
    setOrbitalPeriod(cb_orbital_period_days);
    calcSpeeds(cb_diameter_miles, cb_sidereal_day, cb_orbital_distance_miles, cb_orbital_period_days);
}
/* ************************ End of File ************************************ */
