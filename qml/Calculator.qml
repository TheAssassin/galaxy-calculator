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
    property alias textFieldAnswer: textFieldAnswer

    title: qsTr("Calculator")

    property int curPos:  0

    /* ************************************************************************
     * Grid
     */
    GridLayout
    {
        id: gridLayout
        x: 6
        y: 6
        width: 333
        height: 290
        rowSpacing: 1
        columnSpacing: 1
        rows: 5
        columns: 6
        /* ********************************************************************
         * answer field
         */
        //        TextEditorColor  {
        //            id: textFieldAnswer
        //            x: 6
        //            y: 1
        //            width: 321
        //            height: 33
        //            text: ""
        //            //selectionColor: "#0000ff"
        //            Layout.fillHeight: true
        //            Layout.maximumHeight: 33
        //            Layout.minimumHeight: 33
        //            Layout.preferredHeight: 33
        //            Layout.maximumWidth: 333
        //            Layout.fillWidth: true
        //            Layout.minimumWidth: 333
        //            Layout.preferredWidth: 333
        //            Layout.columnSpan: 6
        //            Layout.rowSpan: 1
        //        }
        TextField {
            id: textFieldAnswer
            color: Style.textEditColor
            x: 6
            y: 1
            width: 321
            height: 33
            text: ""
            leftPadding: 6

            background: Rectangle {
                color: textFieldAnswer.focus ? Style.textColorFocus : Style.textColorNoFocus
                radius: 2
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                implicitWidth: 100
                implicitHeight: 24
                border.color: "#333"
                border.width: 1
                onActiveFocusChanged: {
                    console.debug("onActiveFocusChanged")
                }
            }
//            Layout.fillHeight: true
            Layout.fillWidth: true
//            Layout.maximumHeight: 33
//            Layout.maximumWidth: 333
            Layout.minimumHeight: 33
            Layout.minimumWidth: 333
//            Layout.preferredHeight: 33
//            Layout.preferredWidth: 333
            Layout.columnSpan: 6
            Layout.rowSpan: 1
        }
        /* ********************************************************************
         * Row Top
         */
        Row {
            id: rowTop
            y: 38
            width: 200
            height: 400
            Layout.maximumHeight: 42
            Layout.minimumHeight: 42
            Layout.preferredHeight: 42
            Layout.preferredWidth: 333
            Layout.minimumWidth: 333
            Layout.maximumWidth: 333
            Layout.columnSpan: 6

            Text {
                id: appTextDecimals
                color: Style.textEditColor
                text: qsTr("Decimals: ")
                anchors.verticalCenter: parent.verticalCenter
            }

            TextEdit {
                id: appTextFieldDecimals
                color: Style.textEditColor
                text: "2"
                anchors.verticalCenter: parent.verticalCenter
                clip: true
            }

        }
        /* ********************************************************************
         * 7
         */
        Button {
            id: appButton7
            width: 36
            text: "7"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "7" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * 8
         */
        Button {
            id: appButton8
            width: 36
            text: "8"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "8" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * 9
         */
        Button {
            id: appButton9
            width: 36
            text: "9"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "9" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * Divide /
         */
        Button {
            id: appButtonDivide
            width: 36
            text: "/"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " / " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }
        /* ********************************************************************
         * Undo
         */
        Button {
            id: appButtonUndo
            text: "\u21a9"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 66
            Layout.minimumWidth: 66
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.preferredWidth: 66
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.length - 1);
                textFieldAnswer.cursorPosition = curPos;
            }
        }
        /* ********************************************************************
         * Clear
         */
        Button {
            id: appButtonClear
            text: "C"
            clip: true
            Layout.maximumHeight: 30
            Layout.minimumWidth: 66
            Layout.maximumWidth: 66
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.preferredWidth: 66
            onClicked: {
                textFieldAnswer.text = "";
            }
        }
        /* ********************************************************************
         * 4
         */
        Button {
            id: appButton4
            width: 36
            text: "4"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "4" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * 5
         */
        Button {
            id: appButton5
            width: 36
            text: "5"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "5" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * 6
         */
        Button {
            id: appButton6
            width: 36
            text: "6"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "6" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * Times x
         */
        Button {
            id: appButtonTimes
            width: 36
            height: 30
            text: "X"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " * " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }
        /* ********************************************************************
         * Brackets ()
         */
        Button {
            id: appButtonLeftBracket
            text: "("
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 66
            Layout.minimumWidth: 66
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.preferredWidth: 66
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " ( " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }

        Button {
            id: appButtonRightBracket
            text: ")"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 66
            Layout.minimumWidth: 66
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.preferredWidth: 66
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " ) " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }
        /* ********************************************************************
         * 1
         */
        Button {
            id: appButton1
            width: 36
            text: "1"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "1" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * 2
         */
        Button {
            id: appButton2
            width: 36
            text: "2"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "2" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * 3
         */
        Button {
            id: appButton3
            width: 36
            text: "3"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "3" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * Minus -
         */
        Button {
            id: appButtonMinus
            width: 36
            text: "-"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " - " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }
        /* ********************************************************************
         * Square
         */
        Button {
            id: appButtonSqr
            text: "x²"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 66
            Layout.minimumWidth: 66
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.preferredWidth: 66
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " ^2 " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 4;
            }
        }
        /* ********************************************************************
         *  Square Root
         */
        Button {
            id: appButtonSqRoot
            text: "\u221a"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 66
            Layout.minimumWidth: 66
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.preferredWidth: 66
            onClicked: {
                //                curPos = textFieldAnswer.cursorPosition;
                //                console.debug("curPos=" + curPos)
                //                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "9" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                //                textFieldAnswer.cursorPosition = curPos + 4;
            }
        }
        /* ********************************************************************
         * 0
         */
        Button {
            id: appButton0
            width: 36
            text: "0"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "0" + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 1;
            }
        }
        /* ********************************************************************
         * Dot .
         */
        Button {
            id: appButtonDot
            width: 36
            text: "."
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                if (textFieldAnswer.contains("."))
                {
                    textFieldAnswer.cursorPosition = textFieldAnswer.text.indexOf(".");

                } else {
                    curPos = textFieldAnswer.cursorPosition;
                    console.debug("curPos=" + curPos)
                    textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + "." + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                    textFieldAnswer.cursorPosition = curPos + 1;
                }
            }
        }
        /* ********************************************************************
         * Percent %
         */
        Button {
            id: appButtonPercent
            width: 36
            text: "%"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " % " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }
        /* ********************************************************************
         * Plus +
         */
        Button {
            id: appButtonPlus
            width: 36
            text: "+"
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 36
            Layout.preferredHeight: 30
            Layout.minimumHeight: 30
            Layout.minimumWidth: 36
            Layout.preferredWidth: 36
            onClicked: {
                curPos = textFieldAnswer.cursorPosition;
                console.debug("curPos=" + curPos)
                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " + " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }
        /* ********************************************************************
         * PI
         */
        Button {
            id: appButtonPi
            text: "\u03c0"
            clip: true
            Layout.maximumHeight: 30
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.maximumWidth: 66
            Layout.minimumWidth: 66
            Layout.preferredWidth: 66
            onClicked: {
                //                curPos = textFieldAnswer.cursorPosition;
                //                console.debug("curPos=" + curPos)
                //                var v = BigMath.parse(appTextFieldDecimals.text);
                //                BigNumberMath
                //                textFieldAnswer.text = textFieldAnswer.text.substring(0, textFieldAnswer.cursorPosition) + " " + v + " " + textFieldAnswer.text.substring(textFieldAnswer.cursorPosition, textFieldAnswer.length);
                //                textFieldAnswer.cursorPosition = curPos + 3;
            }
        }
        /* ********************************************************************
         * Equals =
         */
        Button {
            id: appButtonEqual
            text: "="
            clip: true
            Layout.maximumHeight: 30
            Layout.maximumWidth: 66
            Layout.minimumWidth: 66
            Layout.minimumHeight: 30
            Layout.preferredHeight: 30
            Layout.preferredWidth: 66
            Layout.columnSpan: 1
            onClicked: {
                // FIXME decimal places
                /*
                const result1 = BigNumber.evaluate('0.1 + 0.2');
                const scope = { x: '1.000000000000000000000001', y: 3, z: 4.5 };
                const result2 = BigNumber.evaluate('2y(4x + 1) - z', scope);
                myText.text = result1.toString() + '\n' + result2.toString();
                Evaluatejs.
                */
                var theResult = BigNumber.evaluate(textFieldAnswer.text);
                console.debug("theResult=" + theResult + " appTextFieldDecimals.text=" + appTextFieldDecimals.text)
                var theAnswer = BigNumberMath.format(theResult + "", appTextFieldDecimals.text).toString();
                console.debug("theAnswer=" + theAnswer)
                textFieldAnswer.text = theAnswer;
            }
        }
    } // end GridLayout
} // end Page
/* ***************************** End of File ******************************* */

/*##^## Designer {
    D{i:21;anchors_height:100;anchors_width:100}
}
 ##^##*/
