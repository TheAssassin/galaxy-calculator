import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "." // QTBUG-34418, singletons require explicit import to load qmldir file

import "BigNumberMath.js" as BigNumberMath
import "Eval.js" as Evaluatejs

/* ****************************************************************************
 * Calculator Page
 * Thinking about using this for eval
 * https://github.com/silentmatt/expr-eval
 * https://mathjs.org/docs/datatypes/bignumbers.html
 * http://mikemcl.github.io/bignumber.js
 * https://github.com/MikeMcl/bignumber.js/issues/232
 */
Page
{
    title: qsTr("Calculator")
    property alias textFieldAnswer: textFieldAnswer
    property int myHeight: 42
    property int curPos:  0
    /* ************************************************************************
     * Rectangle
     */
    Rectangle
    {
        id: pageRectangle
        color: Style.backgroundColor
        anchors.fill: parent
        /* ************************************************************************
         * GridLayout
         */
        GridLayout
        {
            id: gridLayout
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            anchors.bottomMargin: 2
            anchors.topMargin: 2
            anchors.fill: pageRectangle
            rowSpacing: 3
            columnSpacing: 3
            rows: 6
            columns: 6
            /* ********************************************************************
             * Row 1
             * answer field
             */
            Row
            {
                id: rowAnswer
                height: 52
                Layout.rowSpan: 1
                Layout.columnSpan: 6
                Layout.fillWidth: true
                anchors.topMargin: 6
                clip: true
                Rectangle
                {
                    id: backgroundAnswer;
                    color: (textFieldAnswer.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                    radius: 5;
                    antialiasing: true;
                    height: myHeight
                    width: pageRectangle.width
                    border
                    {
                        width: 3;
                        color: (textFieldAnswer.activeFocus ? Style.borderColor : Style.backgroundColor);
                    }
                    TextField
                    {
                        id: textFieldAnswer
                        height: 42
                        width: pageRectangle.width - 6
                        color: Style.textEditColor
                        text: ""
                        topPadding: 6
                        bottomPadding: 0
                        font.family: "Courier"
                        leftPadding: 6
                        font.pixelSize: 36
                    }
                } // end Rectangle
            } // end Row
            /* ********************************************************************
             * Row 2
             * Row Top
             */
            Row
            {
                id: rowTop
                Layout.fillWidth: true
                Layout.columnSpan: 6
                Rectangle
                {
                    id: backgroundDecimals;
                    color: (appTextFieldDecimals.activeFocus ? Style.textColorFocus : Style.backgroundColor);
                    radius: 5;
                    antialiasing: true;
                    height: myHeight
                    width: pageRectangle.width
                    border
                    {
                        width: 3;
                        color: (appTextFieldDecimals.activeFocus ? Style.borderColor : Style.backgroundColor);
                    }
                    Text
                    {
                        id: appTextDecimals
                        color: Style.textEditColor
                        text: qsTr("Decimals: ")
                        anchors.verticalCenter: parent.verticalCenter
                        fontSizeMode: Text.Fit
                    }

                    TextEdit
                    {
                        id: appTextFieldDecimals
                        color: Style.textEditColor
                        text: "2"
                        anchors.left: appTextDecimals.right
                        anchors.leftMargin: 6
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                    }
                } // end Rectangle
            } // end Row
            /* ********************************************************************
             * Row 3
             * 7
             */
            PushButton
            {
                id: appButton7
                text: "7"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "7" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * 8
             */
            PushButton
            {
                id: appButton8
                text: "8"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "8" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * 9
             */
            PushButton
            {
                id: appButton9
                text: "9"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "9" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * Divide /
             */
            PushButton
            {
                id: appButtonDivide
                text: "/"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " / " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 3;
                }
            }
            /* ********************************************************************
             * Undo
             */
            PushButton
            {
                id: appButtonUndo
                text: "\u21a9"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.length - 1);
                    textFieldAnswer.cursorPosition = curPos;
                }
            }
            /* ********************************************************************
             * Clear
             */
            PushButton
            {
                id: appButtonClear
                text: "C"
                onClicked:
                {
                    textFieldAnswer.text = "";
                }
            }
            /* ********************************************************************
             * 4
             */
            PushButton
            {
                id: appButton4
                text: "4"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "4" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * 5
             */
            PushButton
            {
                id: appButton5
                text: "5"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "5" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * 6
             */
            PushButton
            {
                id: appButton6
                text: "6"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "6" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * Times x
             */
            PushButton
            {
                id: appButtonTimes
                text: "X"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " * " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 3;
                }
            }
            /* ********************************************************************
             * Brackets ()
             */
            PushButton
            {
                id: appButtonLeftBracket
                text: "("
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " ( " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 3;
                }
            }

            PushButton
            {
                id: appButtonRightBracket
                text: ")"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " ) " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 3;
                }
            }
            /* ********************************************************************
             * 1
             */
            PushButton
            {
                id: appButton1
                text: "1"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "1" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * 2
             */
            PushButton
            {
                id: appButton2
                text: "2"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "2" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * 3
             */
            PushButton
            {
                id: appButton3
                text: "3"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "3" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * Minus -
             */
            PushButton
            {
                id: appButtonMinus
                text: "-"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " - " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 3;
                }
            }
            /* ********************************************************************
             * Square
             */
            PushButton
            {
                id: appButtonSqr
                text: "x²"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " ^2 " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 4;
                }
            }
            /* ********************************************************************
             *  Square Root
             */
            PushButton
            {
                id: appButtonSqRoot
                text: "\u221a"
                enabled: false
                onClicked:
                {
                    //                curPos = textFieldAnswer.cursorPosition;
                    //                console.debug("curPos=" + curPos);
                    //                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "9" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    //                textFieldAnswer.cursorPosition = curPos + 4;
                }
            }
            /* ********************************************************************
             * 0
             */
            PushButton
            {
                id: appButton0
                text: "0"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "0" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
            /* ********************************************************************
             * Dot .
             */
            PushButton
            {
                id: appButtonDot
                text: "."
                onClicked:
                {
                    if (textFieldAnswer.text.indexOf(".") !== -1)
                    {
                        curPos = textFieldAnswer.cursorPosition;
                        console.debug("Before appButtonDot curPos=" + curPos);
                        console.debug("Before appButtonDot indexOf('.')=" + textFieldAnswer.text.indexOf("."));
                        textFieldAnswer.cursorPosition = textFieldAnswer.text.indexOf(".");
                        curPos = textFieldAnswer.cursorPosition;
                        console.debug("After appButtonDot curPos=" + curPos);
                    }
                    else
                    {
                        curPos = textFieldAnswer.cursorPosition;
                        console.debug("curPos=" + curPos);
                        textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "." + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                        textFieldAnswer.cursorPosition = curPos + 1;
                    }
                }
            }
            /* ********************************************************************
             * Percent %
             */
            PushButton
            {
                id: appButtonPercent
                text: "%"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " % " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 3;
                }
            }
            /* ********************************************************************
             * Plus +
             */
            PushButton
            {
                id: appButtonPlus
                text: "+"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " + " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 3;
                }
            }
            /* ********************************************************************
             * PI
             */
            PushButton
            {
                id: appButtonPi
                text: "\u03c0"
                onClicked:
                {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos);
                    /**
                      * Make a field for length of PI
                      */
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " 3.1415926535897 " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 17 + 1;
                }
            }
            /* ********************************************************************
             * Equals =
             */
            PushButton
            {
                id: appButtonEqual
                text: "="
                Layout.columnSpan: 1
                onClicked:
                {
                    // FIXME decimal places
                    /*
                    const result1 = BigNumber.evaluate('0.1 + 0.2');
                    const scope = { x: '1.000000000000000000000001', y: 3, z: 4.5 };
                    const result2 = BigNumber.evaluate('2y(4x + 1) - z', scope);
                    myText.text = result1.toString() + '\n' + result2.toString();
                    Evaluatejs.
                    */
                    var theResult = BigNumber.evaluate(textFieldAnswer.text);
                    console.debug("theResult=" + theResult + " appTextFieldDecimals.text=" + appTextFieldDecimals.text);
                    var theAnswer = BigNumberMath.format(theResult + "", appTextFieldDecimals.text).toString();
                    console.debug("theAnswer=" + theAnswer);
                    textFieldAnswer.text = theAnswer;
                }
            }
        }
    } // end GridLayout
} // end Page
/* ***************************** End of File ******************************* */

/*##^##
Designer {
    D{i:21;anchors_height:100;anchors_width:100}D{i:22;anchors_height:100;anchors_width:100}
D{i:23;anchors_height:100;anchors_width:100}D{i:2;anchors_x:6;anchors_y:6}D{i:1;anchors_height:200;anchors_width:200;anchors_x:6;anchors_y:6}
}
##^##*/
