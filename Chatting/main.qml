import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.13
import "qrc:/"
import "qrc:/common" as Common

Window {
    id: root
    visible: true
    width: 850
    height: 590
    title: qsTr("Hello World")
    color: "#00000000"  //设置窗口透明
    flags: Qt.FramelessWindowHint | Qt.Window

    Common.GlobalConfig{
        id: gConfigID   //在父组件中声明的id，其所有子组件都可以访问，放在main.qml中相当于全局属性
    }



    //阴影也要占地方，所以需要在主窗口套一个Rectangle，四周空出来绘制阴影
    Rectangle{
        id: mainRect
        anchors.fill: parent
        anchors.margins: root.visibility === Window.FullScreen ? 0 : 10  //设置四周空出来的宽度，这段宽度用于绘制阴影
        radius: 4

        //如果其他控件有MouseArea中的事件，则其他控件要放在这个MouseArea后面，否则其他控件的MouseArea会被这里的MouseArea覆盖
        MouseArea{
            id: mouse
            anchors.fill: parent
            property int pressX
            property int pressY
            onPressed: {
                pressX = mouseX  //mouseX是QML提供的
                pressY = mouseY
            }
            onPositionChanged: {
                root.x += mouseX - pressX
                root.y += mouseY - pressY
            }
            onDoubleClicked: {
                root.visibility = root.visibility === Window.FullScreen ? Window.AutomaticVisibility : Window.FullScreen
            }
        }
/****************************************
主面板控件放在下面
****************************************/
        Row{ //整个主窗口装在Row布局中，最左边是LeftBar，中间是UserList, 最右边是聊天界面
            width: parent.width
            height: parent.height

            LeftBar{  //自定义的qml
                id: leftBarID
                height: parent.height
                width: 70

            }
            UserList{
                id: userListID
                height: parent.height
                width: 200
            }

            Column{
                width: root.width-20 - leftBarID.width - userListID.width  //root.width换成parent.width，否则ListView的第一个item宽度为负
                height: parent.height
                TitleBar{
                    id: titleBarID
                    height: 30
                    width: parent.width
                }

                ChatList{
                    id: chatListID
                    width: titleBarID.width
                    height: parent.height - titleBarID.height - sendMsgID.height
                }

                SendMessage{
                    id: sendMsgID
                    width: titleBarID.width
//                    height: 120
                }


            }
        }



    }
    //绘制边框阴影
    DropShadow{
        anchors.fill: mainRect
        horizontalOffset: 0
        verticalOffset: 0
        radius: mouse.pressed ? 10 : 8  //阴影的半径，越大阴影越明显
        samples: 15
        source: mainRect
        color: "#666"
        Behavior on radius {
            PropertyAnimation{duration: 100}
        }
    }


}
