/* ****************************************************************************
 * Written by Jeffrey Scott Flesher
 * Last Update: 31 March 2020
 * https://felgo.com/doc/felgo-fileutils/
 * https://doc.qt.io/qt-5/qtqml-javascript-functionlist.html
 * https://doc.qt.io/qt-5/qml-qtqml-number.html
 * https://doc.qt.io/qt-5/qtqml-javascript-expressions.html
 * https://doc.qt.io/qt-5/qtqml-javascript-hostenvironment.html
 * https://doc.qt.io/qt-5/qtqml-typesystem-basictypes.html
 *
 *
 *
 */
/* ****************************************************************************
 * Theme
 * Light or Dark
 * if (Js.getTheme() == "Light") {}
 */
var Theme = "Light";
function getTheme() {
    return Theme;
}
function setTheme(theme) {
    Theme = theme;
}
/* ****************************************************************************
 * LocalCode
 * FIXME Localize
 */
var LocalCode = "en_US";
function getLocalCode() {
    return LocalCode;
}
function setLocalCode(localCode) {
    LocalCode = localCode;
}
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
 *  isEven(n)
 */
function isEven(n) {
    return n % 2 === 0;
}
/* ****************************************************************************
 *  isOdd(n)
 */
function isOdd(n) {
    return Math.abs(n % 2) === 1;
}
/* ****************************************************************************
 *  isNumber(n)
 */
function toCelsius(fahrenheit) {
    return (5/9) * (fahrenheit-32);
}
/* ****************************************************************************
 *  isNumber(n)
 */
function isNumber (n) {
    if(typeof x !== 'number') {
        return false;
    }

    return !isNaN(parseFloat(n)) && isFinite(n);
}
/* ****************************************************************************
 * humanize
 * Localize
 * number With Commas
 * 123,456 returns humanize(123456 + "")
 * will return the correct useage of commas; some countries use periods
 */
function humanize(x) {
//    if (isNumber(x)) {
//        console.debug("failed humanize(" + x + ")");
//        return x;
//    }



    //var myLocale = Qt.locale(getLocalCode());

    //console.debug("****** start humanize(" + x + ")");

    //var ans = Number(parseFloat(x)).toLocaleString(getLocalCode(), { minimumFractionDigits: 2 });
    //var ans = Number.fromLocaleString(myLocale, x);
    //var ans = x.toLocaleString(getLocalCode())
    //var ans = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    //var ans = parseFloat(x).toLocaleString().replace(/\.([0-9])$/, ".$10");
    //console.debug("******** end humanize(" + ans + ")");


    x += '';
    var ans = x.split('.');
    var x1 = ans[0];
    var x2 = ans.length > 1 ? '.' + ans[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    ans = x1 + x2;

    return ans;
}
/* ***************************** End of File ******************************* */
