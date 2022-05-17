import QtQuick 2.15
import QtQuick.Controls 2.12
import "qrc:/common" as Common

Rectangle{
    width: 300
    height: topBtnsID.height+textEditID.height+sendMsgBtnID.height+1+2*margin
//    color: "#283"
    property int margin: 10
    Rectangle{//顶部横线
        width: parent.width
        height: 1
        border.width: 1
        border.color: "#EEE"
        color: "#EEE"
    }

    Row{//顶部按钮区域
        id: topBtnsID
        width: parent.width
        height: 30
        spacing: 10
        padding: 3
        Common.ImageButton{
            height: parent.height-6
            width: height
        }

        Common.ImageButton{
            height: parent.height-6
            width: height
        }

        Common.ImageButton{
            height: parent.height-6
            width: height
        }
    }

    Rectangle{
        id: textEditID
        width: parent.width
        height: 63
        anchors.top: topBtnsID.bottom
        anchors.leftMargin: margin
        anchors.rightMargin: margin
        TextEdit{
            padding: 10
            anchors.fill: parent
            wrapMode: TextEdit.WrapAnywhere
            font.family: "微软雅黑"
            font.pixelSize: 15
            textFormat: TextEdit.RichText
            clip: true
        }
    }


    Button {
         id: sendMsgBtnID
         text: qsTr("发送")
         anchors.top: textEditID.bottom
         anchors.right: parent.right
         anchors.topMargin: margin
         anchors.rightMargin: margin

         contentItem: Text {
             text: sendMsgBtnID.text
             font: sendMsgBtnID.font
             opacity: enabled ? 1.0 : 0.3
             color: sendMsgBtnID.down ? "#17a81a" : "#21be2b"
             horizontalAlignment: Text.AlignHCenter
             verticalAlignment: Text.AlignVCenter
             elide: Text.ElideRight
         }

         background: Rectangle {
             implicitWidth: 80
             implicitHeight: 30
             opacity: enabled ? 1 : 0.3
             border.color: sendMsgBtnID.down ? "#17a81a" : "#21be2b"
             border.width: 1
             radius: 2
         }

    }

}
