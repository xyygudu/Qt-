import QtQuick 2.0
import "qrc:/common" as Common

Rectangle{
    height: 30
    property int btnWidth: 30
    Common.ImageButton{
        id: closeWinID
        anchors.right: parent.right
        anchors.top: parent.top
        width: btnWidth
        height: btnWidth
        source: "qrc:/source/icons/close.png"
        hoverSource: "qrc:/source/icons/close_hover.png"
        hoverColor: "red"
        onImageClicked: {
            Qt.quit()
        }
    }
    Common.ImageButton{
        id: minWinID
        anchors.right: closeWinID.left
        anchors.top: parent.top
        width: btnWidth
        height: btnWidth
        source: "qrc:/source/icons/setting.png"
        hoverSource: "qrc:/source/icons/setting_hover.png"
        hoverColor: "#ddd"
    }
}
