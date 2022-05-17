import QtQuick 2.0
import "qrc:/common" as Common
Rectangle {
    id: leftBar
    color: "#aaaaff"
    property int spacing: 30
    property int margin: 10

    Column{ //column里面的item不要用anchor，否则column会失效
        anchors.fill: parent
        anchors.margins: leftBar.margin
        spacing: leftBar.spacing

        Common.ImageButton{
            width: parent.width
            height: width
            onImageClicked:{ //处理按钮点击事件
                console.log("LeftBar.click")
            }
        }

    }
}
