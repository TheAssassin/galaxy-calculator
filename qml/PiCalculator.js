/*** **************************************************************************
  * PI Credits: https://trans4mind.com/personal_development/JavaScript/longnumPiMachin.htm
  * .import "PiCalculator.js" as PiCalc
  * PiCalc.calcPI(numDec);
  */
// split the long line up into manageable rows
var SplitOnCount = false;
// add space to split lines
var AddSpace = false;
// messages
var mess = "";
// 10^11 seems to be the maximum
// too high a figure for the base introduces errors
var Base = Math.pow(10,11);
// num digits in each array item
var cellSize = Math.floor(Math.log(Base) / Math.LN10);
//below is not used in this script
var a = Number.MAX_VALUE;
var MaxDiv = Math.floor(Math.sqrt(a));
var timeToCalcPi = "";
var aAngle = [];
var aDivK = [];
var aArctan = [];
/*** **************************************************************************
  * makeArray
  */
function makeArray(n, aX, Integer)
{
    var i = 0;
    for (i = 1; i < n; i++) aX[i] = null;
    aX[0] = Integer;
}
/*** **************************************************************************
  * isEmpty
  */
function isEmpty(aX)
{
    var empty = true;
    var i = 0;
    for (i = 0; i < aX.length; i++)
    {
        if (aX[i])
        {
            empty = false;
            break;
        }
    }
    return empty;
}
/*** **************************************************************************
  * Add junior school math
  */
function add(n, aX,aY)
{
    var carry = 0;
    var i = 0;
    for (i = n - 1; i >= 0; i--)
    {
        aX[i] += Number(aY[i]) + Number(carry);
        if (aX[i] < Base)
        {
            carry = 0;
        }
        else
        {
            carry = 1;
            aX[i] = Number(aX[i]) - Number(Base);
        }
    }
}
/*** **************************************************************************
  * subtract
  */
function sub(n, aX,aY)
{
    var i = 0;
    for (i = n - 1; i >= 0; i--)
    {
        aX[i] -= aY[i];
        if (aX[i] < 0)
        {
            if (i > 0)
            {
                aX[i] += Base;
                aX[i-1]--;
            }
        }
    }
}
/*** **************************************************************************
  * multiply big number by "small" number
  */
function mul(n, aX, iMult)
{
    var carry = 0;
    var i = 0;
    var prod = 0;
    for (i = n - 1; i >= 0; i--)
    {
        prod = (aX[i]) * iMult;
        prod += carry;
        if (prod >= Base)
        {
            carry = Math.floor(prod / Base);
            prod -= (carry * Base);
        }
        else
        {
            carry = 0;
        }
        aX[i] = prod;
    }
}
/*** **************************************************************************
  * divide big number by "small" number
  */
function div(n, aX, iDiv,aY)
{
    var carry = 0;
    var i = 0;
    var currVal = 0;
    var theDiv = 0;
    for (i = 0; i < n; i++)
    {
        // add any previous carry
        currVal = Number(aX[i]) + Number(carry * Base);
        // divide
        theDiv = Math.floor(currVal / iDiv);
        // find next carry
        carry = currVal - theDiv * iDiv;
        // put the result of division in the current slot
        aY[i] = theDiv;
    }
}
/*** **************************************************************************
  * compute arctan
  */
function arctan(iAng, n, aX)
{
    var iAng_squared = iAng * iAng;
    var k = 3; // k is the coefficient in the series 2n-1, 3,5..
    var sign = 0;
    makeArray(n, aX, 0); // aX is aArctan
    makeArray(n, aAngle, 1);
    div(n, aAngle, iAng, aAngle); // aAngle = 1/iAng, eg 1/5
    add(n, aX, aAngle); // aX = aAngle or long angle
    while (!isEmpty(aAngle))
    {
        div(n, aAngle, iAng_squared, aAngle); // aAngle = aAngle / iAng_squared, iAng_squared is iAng*iAng
        // mess += "iAng=" + iAng + "; aAngle=" + aAngle;
        div(n, aAngle, k, aDivK); /* aDivK = aAngle/k */
        if (sign) { add(n, aX, aDivK); /* aX = aX+aDivK */ }
        else { sub(n, aX, aDivK); /* aX = aX-aDivK */ }
        k += 2;
        sign = 1 - sign;
    }
    mess += "aArctan=" + aArctan;
}
/*** **************************************************************************
  * Calculate pi
  */
function calcPI(numDec)
{
    numDec = Number(numDec) + 5;
    var ans = "";
    var t1 = new Date();
    var iAng = new Array(10);
    var coeff = new Array(10);
    var arrayLength = Math.ceil(1 + numDec / cellSize);
    var aPI = new Array(arrayLength);
    aArctan = new Array(arrayLength);
    aAngle = new Array(arrayLength);
    aDivK = new Array(arrayLength);
    // Pi/4 = 4*arctan(1/5) - arctan(1/239)
    // coeff is an array of the coefficients the last item is 0!
    coeff[0] = 4;
    coeff[1] = -1;
    coeff[2] = 0;
    // iAng holds the angles, 5 for 1/5, etc
    iAng[0] = 5;
    iAng[1] = 239;
    iAng[2] = 0;
    makeArray (arrayLength, aPI, 0);
    // Machin: Pi / 4 = 4 * arctan(1/5) - arctan(1/239)
    makeArray(arrayLength, aAngle, 0);
    makeArray(arrayLength, aDivK, 0);
    var i = 0;
    for (i = 0; coeff[i] !== 0; i++)
    {
        arctan(iAng[i], arrayLength, aArctan);
        // multiply by coefficients of arctan
        mul(arrayLength, aArctan, Math.abs(coeff[i]));
        // mess += "mi=" + coeff[i];
        if (coeff[i] > 0) add(arrayLength, aPI, aArctan);
        else              sub(arrayLength, aPI, aArctan);
        // mess += "api=" + aPI;
    }
    // we have calculated pi/4, so need to finally multiply
    mul(arrayLength, aPI, 4);
    // we have now calculated PI, and need to format the answer to print it out
    var sPI = "";
    var tempPI = "";
    // put the figures in the array into the string tempPI
    for (i = 0;i < aPI.length; i++)
    {
        aPI[i] = String(aPI[i]);
        // ensure there are enough digits in each cell
        // if not, pad with leading zeros
        if (aPI[i].length < cellSize && i !== 0)
        {
            while (aPI[i].length < cellSize)
                aPI[i] = "0" + aPI[i];
        }
        tempPI += aPI[i];
    }
    var addcount = "";
    var thespace = "";
    // now put the characters into the string sPI
    for (i = 0; i <= numDec; i++)
    {
        // put the 3 on a different line, and add a decimal point
        if (i === 0)
        {
            sPI += tempPI.charAt(i);
        }
        else
        {
            // split the long line up into manageable rows
            if (SplitOnCount)
            {
                addcount = " (" + (i) + ")";
            }
            else
            {
                addcount = "";
            }
            if (AddSpace)
            {
                thespace = " ";
            }
            else
            {
                thespace = "";
            }
            if ((i) % 50 == 0 && i !== 0)
            {
                sPI += tempPI.charAt(i) + addcount;
            }
            else
            {
                if (i % 5 == 0) sPI += tempPI.charAt(i) + thespace;
                else            sPI += tempPI.charAt(i);
            }
        }//i not zero
    }
    // now put the print-out together
    // print our pi
    ans = ("PI (" + numDec + ")=" + sPI);
    // Window's calculator Pi (for confirmation);
    // ans += ("Win PI=3.1415926535897932384626433832795");
    var t2 = new Date();
    var timeTaken = (t2.getTime() - t1.getTime()) / 1000;
    // Time to calculate PI
    if (timeTaken > 60)
    {
        var minutes = Math.floor(timeTaken / 60);
        timeToCalcPi = "Time to Calculate PI: " + minutes + " minutes";
    }
    else
    {
        timeToCalcPi = "Time to Calculate PI: " + timeTaken + " seconds";
    }
    return ans;
} // end calcPI
// ################################ End of File ###############################
