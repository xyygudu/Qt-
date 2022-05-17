import QtQuick 2.0
import UserListModel 1.0
import "qrc:/delegate" as Delegate

Rectangle {
    implicitWidth: 200
    implicitHeight: 400
    color: "#eef"
    property int itemHeight: 60  //代理的每一个item的高度
//    property ListModel userListModel: userListModel

    ListView{
        id: userList
        anchors.fill: parent
        clip: true      //超出视图显示范围就裁剪
        currentIndex: -1
        property int lastClickedIndex: -1  //记录上一次点击时的index
//        model: UserListModel{id: userListModel}
        model: MainControl.userListModel

        delegate: Delegate.UserListDelegate{
            id: userListDelegateID
            height: itemHeight
        }


    }
}
