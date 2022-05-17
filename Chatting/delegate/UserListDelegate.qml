import QtQuick 2.0

Rectangle{
    width: userList.width
    height: itemHeight

    color: userList.currentIndex === index ? "#ccf" : "#00000000"
    //横向布局，用于显示用户头像、ip地址、昵称等信息，其中headImage，ipAddress，name是在userlistmodel.h的roleNames方法中给出的，可以在这里直接使用
    Row{  //使用了Row, 其子元素不能使用anchors，因为Row会自动管理布局
        id: row_container
        anchors.fill: parent
        anchors.margins: 5  //如果不fillparent，这个将无效
        spacing: 5
        //用户头像
        Rectangle{
            id: headImageID
            width: height
            height: parent.height
            radius: 10
            Image{
                anchors.fill: parent
                source: headImage  //也可使用model.headImage
            }
        }


        Column{
            height: parent.height
            width: parent.width

            Rectangle{
                id: rec
                height: parent.height


                //昵称
                Text{
                    id: userNameID
                    anchors.top: parent.top
                    anchors.left: parent.left
                    font.pixelSize: 17
                    font.family: "Microsoft Yahei"
                    font.weight: Font.DemiBold
                    text: name  //也可以使用model.ipAddress
                }

                //ip地址
                Text{
                    id: userIPID
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    color: "#BABABA"
                    font.pixelSize: 13
                    font.family: "Microsoft Yahei"
                    text: ipAddress
                }
            }
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered:  {
            if(userList.currentIndex === index)
                return
            color = "#ddf"
        }

        onExited: {
            if(userList.currentIndex === index)
                return
            color = "#00000000"
        }

        onClicked: {

            //将上次点击的item的颜色改为白色
            if(userList.lastClickedIndex !== -1){
                if(userList.itemAtIndex(userList.lastClickedIndex)){//如果存在指定index的item(itemAtIndex在qt5.13才有)
                    userList.itemAtIndex(userList.lastClickedIndex).color = "#00000000"
                }
            }
            color = "#ccf"
            userList.currentIndex = index
            userList.lastClickedIndex = index
        }

    }

//    //顶部线条
    Rectangle{
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: '#eef'
        visible: index === 0 //只有第一项才的顶部线条可见
    }
    //底部线条
    Rectangle{
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: '#eef'
    }
}
