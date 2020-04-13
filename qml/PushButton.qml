import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import "." // QTBUG-34418, singletons require explicit import to load qmldir file

Rectangle
{
    id: root
    Layout.fillHeight: true
    Layout.fillWidth: true
    clip: true

// public
    property string text: "text"

    signal clicked(); // onClicked: print('onClicked')

// private
    //width: 500;  height: 100 // default size
    border.color: text ? Style.borderColor : 'transparent'; // Keyboard
    border.width: 0.01 * root.height
    radius:       0.3  * root.height
    opacity:      enabled  &&  !mouseArea.pressed ? 1 : 0.3; // disabled/pressed state

    gradient: Gradient
    {
        GradientStop { position: 0.0; color: "lightsteelblue" }
        GradientStop { position: 1.0; color: "blue" }
    }

    Text
    {
        text: root.text
        font.pixelSize: 0.5 * root.height;
        anchors.centerIn: parent
    }

    MouseArea
    {
        id: mouseArea

        anchors.fill: parent

        onClicked:  root.clicked(); // emit
    }
}
