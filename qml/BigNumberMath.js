.import "BigNumber.js" as BigNumberJs;

var runTest = 0;           // 0=False, 1=True
var debugBigNumber = true; // 0=false, 1=true
var debugMessage = 0;      // 0=False, 1=True
var makeDecimal = 0;       // 0=false, 1=true
/* **********************************************************
 * isInArray
 */
function isInArray(thisItem, thisArray) {
    return thisArray.indexOf(thisItem.toLowerCase()) > -1;
}
/* **********************************************************
 *
 */
function pI(sDecimalPlaces) {

}
/* **********************************************************
 * test all functions

test Started
BigNumber a + b= [1.0] + [1.0]
BigNumber a + b= [1.0] + [1.0] = 2
test Failed: parse(1 + 1, 0) = |2.0| expected: 2 or 2.0 depending on decimal places
BigNumber a * b= 1.0 * 2.0 = 2 formated: 2
test Failed: parse(1 * 2, 0) = |2.0| expected: 2 or 2.0 depending on decimal places
BigNumber a / b= 4.0 / 2.0 = 2 formated: 2
test Failed: parse(4 / 2, 0) = |2.0| expected: 2 or 2.0 depending on decimal places
BigNumber a - b= 3.0 - 1.0 = 2
test Failed: parse(3 - 1, 0) = |2.0| expected: 2 or 2.0 depending on decimal places
test Finished

*/
function test() {
    if (debugBigNumber) BigNumber.DEBUG = true;
    console.debug("test Started");
    let storageVar = "";
    let thisTestString = "1234.6789";
    storageVar = fixNumber(thisTestString);
    if (storageVar !== thisTestString) {
        console.debug("test Failed: fixNumber(" + thisTestString + ") = |" + storageVar + "|")
    }
    thisTestString = "100000.000000";
    storageVar = fixNumber(thisTestString);
    if (storageVar === thisTestString) {
        console.debug("test Failed: fixNumber(" + thisTestString + ") = |" + storageVar + "| expected: 100000.0 or 100000")
    }
    // Test Math Parser plus
    console.debug("plus****************************")
    storageVar = plus("1", "1", 0);
    console.debug("storageVar=" + storageVar)
    if (storageVar.indexOf(".") > 0) {
        if (storageVar !== "2.0") {
            console.debug("test Failed: plus(1 + 1, 0) = |" + storageVar + "| expected: 2.0")
        }
    } else {
        if (storageVar !== "2") {
            console.debug("test Failed: plus(1 + 1, 0) = |" + storageVar + "| expected: 2")
        }
    }
    // Test Math Parser minus
    storageVar = minus("3", "1", 0);
    if (storageVar.indexOf(".") > 0) {
        if (storageVar !== "2.0") {
            console.debug("test Failed: minus(3 - 1, 0) = |" + storageVar + "| expected: 2.0")
        }
    } else {
        if (storageVar !== "2") {
            console.debug("test Failed: minus(3 - 1, 0) = |" + storageVar + "| expected: 2")
        }
    }
    // Test Math Parser times
    storageVar = times("1", "2", 0);
    if (storageVar.indexOf(".") > 0) {
        if (storageVar !== "2.0") {
            console.debug("test Failed: times(1 * 2, 0) = |" + storageVar + "| expected: 2.0")
        }
    } else {
        if (storageVar !== "2") {
            console.debug("test Failed: times(1 * 2, 0) = |" + storageVar + "| expected: 2")
        }
    }
    // Test Math Parser divide
    storageVar = dividedBy("4", "2", 0);
    if (storageVar.indexOf(".") > 0) {
        if (storageVar !== "2.0") {
            console.debug("test Failed: dividedBy(4 / 2, 0) = |" + storageVar + "| expected: 2.0")
        }
    } else {
        if (storageVar !== "2") {
            console.debug("test Failed: dividedBy(4 / 2, 0) = |" + storageVar + "| expected: 2")
        }
    }


    console.debug("test Finished");
}
/* **********************************************************
 * modInverse
 */
function modInverseJs(thisNumber, thisMod) {
    let thatNumber = thisNumber % thisMod;
    let x = 0;
    for (x = 1; x < thisMod; x++) {
       if ((thatNumber * x) % thisMod === 1) {
          return x;
       }
    }
    // should never get here
    return thisNumber;
}
/* **********************************************************
 * modInverseBn
 */
function modInverse(thisNumber, thisMod) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    let thatNumber = new BigNumber(thisNumber);
    thatNumber = thatNumber.modulo(thisMod);
    let x = 0;
    for (x = 1; x < thisMod; x++) {
       if (thatNumber.times(x).modulo(thisMod).toString() === "1") {
          return x;
       }
    }
    // should never get here
    return thisNumber;
}
/* **********************************************************
 * squareRoot
 */
function squareRoot(sThis, sDecimalPlaces) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    BigNumber.config({ EXPONENTIAL_AT: 1e+9 });
    let fThis = sThis + "";
    fThis = fixNumber(fThis);
    if (fThat === "0.0") {
        console.debug("dividedByBn error (" + fThis + ", " + fThat + ", " + sDecimalPlaces + ")")
        return "0.0";
    }
    if (fThis === "0.0") {
        return "0.0";
    }
    let bnThis = new BigNumber(fThis);
    let sqrValue = 0
    try {
        sqrValue = bnThis.squareRoot();
    } catch (e) {
        if (e instanceof Error && e.message.indexOf('[BigNumber Error]') === 0) {
            console.debug("BigNumber squareRoot Error: " + e);
        }
    }
    if (debugMessage === 1)
        console.debug("BigNumber a / b= " + fThis + " / " + fThat + " = " + result.toString() + " formated: " + result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces));
    return sqrValue;
}
/* **********************************************************
 * sqrt
 */
function sqrt(sThis, sDecimalPlaces) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    BigNumber.config({ EXPONENTIAL_AT: 1e+9 });
    let fThis = sThis + "";
    fThis = fixNumber(fThis);
    if (fThat === "0.0") {
        console.debug("dividedByBn error (" + fThis + ", " + fThat + ", " + sDecimalPlaces + ")")
        return "0.0";
    }
    if (fThis === "0.0") {
        return "0.0";
    }
    let bnThis = new BigNumber(fThis);
    let sqrValue = 0
    try {
        sqrValue = bnThis.sqrt();
    } catch (e) {
        if (e instanceof Error && e.message.indexOf('[BigNumber Error]') === 0) {
            console.debug("BigNumber sqrt Error: " + e);
        }
    }
    if (debugMessage === 1)
        console.debug("BigNumber a / b= " + fThis + " / " + fThat + " = " + result.toString() + " formated: " + result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces));
    return sqrValue;
}
/* **********************************************************
 * dividedBy
 */
function dividedBy(sThis, sThat, sDecimalPlaces) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    BigNumber.config({ EXPONENTIAL_AT: 1e+9 });
    let fThis = sThis + "";
    let fThat = sThat + "";
    fThis = fixNumber(fThis);
    fThat = fixNumber(fThat);

    if (fThat === "0.0") {
        console.debug("dividedByBn error (" + fThis + ", " + fThat + ", " + sDecimalPlaces + ")")
        return "0.0";
    }
    if (fThis === "0.0") {
        return "0.0";
    }

    let bnThis = new BigNumber(fThis);
    let bnThat = new BigNumber(fThat);
    let result = 0;
    try {
        result = bnThis.dividedBy(bnThat);
    } catch (e) {
        if (e instanceof Error && e.message.indexOf('[BigNumber Error]') === 0) {
            console.debug("BigNumber dividedBy Error: " + e);
        }
    }
    if (debugMessage === 1)
        console.debug("BigNumber a / b= " + fThis + " / " + fThat + " = " + result.toString() + " formated: " + result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces));
    return result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces);
}
/* **********************************************************
 * times
 */
function times(sThis, sThat, sDecimalPlaces) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    BigNumber.config({ EXPONENTIAL_AT: 1e+9 });
    let fThis = sThis + "";
    let fThat = sThat + "";
    fThis = fixNumber(fThis);
    fThat = fixNumber(fThat);
    let bnThis = new BigNumber(fThis);
    let bnThat = new BigNumber(fThat);

    let result = 0;
    try {
        result = new BigNumber(bnThis.times(bnThat))
    } catch (e) {
        if (e instanceof Error && e.message.indexOf('[BigNumber Error]') === 0) {
            console.debug("BigNumber times Error: " + e);
        }
    }
    if (debugMessage === 1)
        console.debug("BigNumber a * b= " + fThis + " * " + fThat + " = " + result.toString() + " formated: " + result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces));
    return result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces);
}
/* **********************************************************
 * plus
 */
function plus(sThis, sThat, sDecimalPlaces) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    BigNumber.config({ EXPONENTIAL_AT: 1e+9 });
    let result = 0;
    let fThis = sThis + "";
    let fThat = sThat + "";
    fThis = fixNumber(fThis);
    fThat = fixNumber(fThat);
    if (debugMessage === 1)
        console.debug("BigNumber a + b ~ [" + fThis + "] + [" + fThat + "]");

    let bnThis = new BigNumber(fThis + "");
    let bnThat = new BigNumber(fThat + "");
    try {
        result = bnThis.plus(bnThat);
    } catch (e) {
        if (e instanceof Error && e.message.indexOf('[BigNumber Error]') === 0) {
            console.debug("BigNumber plus Error: " + e);
        }
    }
    if (debugMessage === 1)
        console.debug("BigNumber a + b= [" + fThis + "] + [" + fThat + "] = " + result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces));
    return result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces);
}
/* **********************************************************
 * minus
 */
function minus(sThis, sThat, sDecimalPlaces) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    BigNumber.config({ EXPONENTIAL_AT: 1e+9 });
    let fThis = sThis + "";
    let fThat = sThat + "";
    fThis = fixNumber(fThis);
    fThat = fixNumber(fThat);
    let bnThis = new BigNumber(fThis);
    let bnThat = new BigNumber(fThat);
    let result = 0;
    try {
        result = bnThis.minus(bnThat);
    } catch (e) {
        if (e instanceof Error && e.message.indexOf('[BigNumber Error]') === 0) {
            console.debug("BigNumber minus Error: " + e);
        }
    }
    if (debugMessage === 1)
        console.debug("BigNumber a - b= " + fThis + " - " + fThat + " = " + result.toString());
    return result.decimalPlaces(sDecimalPlaces).toFixed(sDecimalPlaces);
}
/* **********************************************************
 * fixNumber("0.00000") = "0.0"
 * 100000 = 100000
 * 1234.5678 = 1234.5678
 * 100000.000000 = 100000.0 or 100000
 *
    BigNumber a + b= [1.0] + [1.0]
    BigNumber a + b= [1.0] + [1.0]
 */
function fixNumber(sThis) {
    let fThis = sThis + "";
    // if not a float return
    if (fThis.indexOf(".") < 1) return fThis + ".0";
    let newThis = "";
    let returnThis = "";
    let isPositive = 0;
    let i = 0;
    let signThis = "";
    if (fThis.charAt(0) === '-') signThis = "-";
    // reverse the numbers to rid 0 as last decimal
    for (i = fThis.length - 1; i > -1; i--) {
        //
        if (fThis.charAt(i) !== '-' && fThis.charAt(i) !== '+') {
            if (fThis.charAt(i) !== '0') {
                isPositive = 1;
            }
            if (isPositive === 1) {
                newThis = newThis + fThis.charAt(i);
            }
        } // end if
    } // end for
    // reverse the numbers
    for (i = newThis.length - 1; i > -1; i--) {
        returnThis = returnThis + newThis.charAt(i);
    } // end for
    if (returnThis.charAt(returnThis.length - 1) === ".") {
        if (makeDecimal === 0){
            returnThis = returnThis + "0";
        } else {
            returnThis = returnThis.substring(0, returnThis.length - 1);
        }
    } // end if .
    return signThis + returnThis;
} // end fixNumber
/* **********************************************************
 * format
 */
function format(sThis, sDecimalPlaces) {
    if (debugBigNumber) BigNumber.DEBUG = true;
    BigNumber.config({ EXPONENTIAL_AT: 1e+9 });
    let fThis = sThis + "";
    fThis = fixNumber(fThis);
    if (fThis === "0.0") return "0.0";
    if (fThis === "0") return "0";
    let ndp = fThis.substring(fThis.indexOf(".") + 1, fThis.length);
    // do not give it a number like x.0, just x
    if (ndp === "0") {
        fThis = fThis.substring(0, fThis.indexOf("."));
    }
    if (debugMessage) {
        console.debug("format fThis=" + fThis + " ndp=" + ndp);
    }
    let y = new BigNumber(fThis + "");
    if (debugMessage) {
        console.debug("format y=" + y);
    }
    if (fThis.indexOf(".") > 0) {
        return y.toFormat(sDecimalPlaces);  // "1,234,567.90"
    }

    return y.toFormat();  // "1,234,567.90"
}
/* **********************************************************
 * abs
 */
function abs(sThis) {
    let fThis = sThis + "";
    fThis = fixNumber(fThis);
    if (fThis === "0.0" || fThis === "-0.0") return "0.0";
    if (fThis.charAt(0) === "-" || fThis.charAt(0) === "+") return fThis.substring(1, fThis.length);
    return fThis;
}

if (runTest === 1) test();
/* ***************************** End of File ******************************* */
