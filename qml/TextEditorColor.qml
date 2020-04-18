import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item
{
    id: root
    property alias font: textEdit.font
    property alias text: textEdit.text
    property alias cursorPosition: textEdit.cursorPosition

    Column
    {
        anchors.fill: parent
        Repeater
        {
            model: root.height / root.lineHeight
            Rectangle
            {
                color: index === textEdit.currentLine ? "lightyellow" : "whitesmoke"
                height: root.lineHeight
                width: root.width
            }
        }
    }

    TextEdit
    {
        id: textEdit

        property int currentLine: text.substring(0, cursorPosition).split(/\r\n|\r|\n/).length - 1
        // FIXME: Use proper line height (e.g. from QFontMetrics)
        property int lineHeight: font.pixelSize + 2

        anchors.fill: parent
     }

//    Rectangle {
//        color: "#808080"
//        Text {
//            text: "Hello, World"
//        }
//        width: childrenRect.width
//        height: childrenRect.height
//    }
} // end Item
/* ***************************** End of File ******************************* */
