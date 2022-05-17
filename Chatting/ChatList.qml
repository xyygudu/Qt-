import QtQuick 2.0
import "qrc:/delegate" as Delegate

Rectangle {
//    implicitWidth: 200
//    implicitHeight: 400

    ListView{
        id: chatList
        anchors.fill: parent
        clip: true      //超出视图显示范围就裁剪
        currentIndex: -1
        model:2

        delegate: Delegate.ChatListDelegate{
            id: chatListDelegate
//            Component.onCompleted: {
//                console.log("ChatListDelegate", chatList.width)
//            }
        }



    }
}
