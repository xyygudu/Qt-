import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/common" as Common


// bubble方式1
//Item {
//    id: containerID
//    width: ListView.view.width
//    height: itemLayoutID.height + 15
//    state: "myself"
//    readonly property int txt: 0           //消息的类型是否是文本
//    readonly property int flie: 1          //消息的类型是否是文件
//    readonly property int voice: 0         //消息的类型是否是语音
//    readonly property bool isSender: true  //是否是发送方
//    property int msgType: txt
//    property int bubbleMaxWidth: 0.6*containerID.width
//    property int bubbleMinHeight: 50


//    Row{
//        id: itemLayoutID
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.leftMargin: 20
//        anchors.rightMargin: 20
//        spacing: 5
//        layoutDirection : isSender ? Qt.RightToLeft : Qt.LeftToRight
//        Common.ImageButton{
//            id: headImageID
//            width: bubbleMinHeight
//            height: width
//        }

//        Common.ChatBubble {
//            id: _msg
//            msgText:  "fdsfsafsafsffsafsafsfdsafsaffdsfsafsafsfdsafsaffdsfsafsafsfdsafsaffdsfsafsafsfdsafsaf"
//            isSend: isSender
//            iconHeight: headImageID.height
//            maxWidth: bubbleMaxWidth
//        }
//    }
//}

Item {
    id: chatListItem
    width: chatList.width  //不知道为什么初始化为这个数值，第一次会出现负数
    height: itemLayoutID.height + 10

    readonly property int txt: 0           //消息的类型是否是文本
    readonly property int file: 1          //消息的类型是否是文件
    readonly property int voice: 0         //消息的类型是否是语音
    readonly property bool isSender: true  //是否是发送方
    property int msgType: file
    property int bubbleMaxWidth: 0.6*chatListItem.width
    property int bubbleMinHeight: 50
    property int bubblePadding: 8          //bubble的padding，让bubble中的内容边框和bubble的边框有一定距离
    property int initTextWidth: 0          //记录下组件创建完成前text的宽度，以便当组件宽度变化时，动态修改气泡宽度

    property string myColor: "A0EA6F"
    property string yourColor: "#f2f2f2"

    property bool finishLoadComponent: false


    onWidthChanged: { //根据窗口宽度动态修改气泡大小
        if (finishLoadComponent){
            wholeBubbleID.width = Math.min(chatListItem.bubbleMaxWidth, initTextWidth+2*bubblePadding)
            loader.item.width = wholeBubbleID.width - 2*bubblePadding
            wholeBubbleID.height = Math.max(chatListItem.bubbleMinHeight, loader.item.height+2*bubblePadding)
        }
    }



    Row{
        id: itemLayoutID
        width: chatListItem.width   //高度会自动调整
        spacing: 15
        layoutDirection: isSender ? Qt.RightToLeft : Qt.LeftToRight

        Common.ImageButton{  //头像
            id: headImageID
            width: bubbleMinHeight
            height: width
        }

        Common.Bubble{ //整个气泡
            id: wholeBubbleID
            //宽高可以随便设定，因为loader加载成功后会重新修改这个宽高
            width: bubbleMaxWidth/*Math.min(chatListItem.bubbleMaxWidth, getComponetWidth(msgType))*/
            height: bubbleMinHeight
            trianglePos: isSender ? trianglePosRight : trianglePosLeft
            triangleOffset: headImageID.height / 2
            color: isSender ? "#22dd22" : "#f9f9f9"
            Loader{
                id: loader
                anchors.centerIn: parent
                sourceComponent: chatListItem.getComonentByMsgType(chatListItem.msgType)
                onLoaded: {  //当组件加载完成
                    /*
                     *设置bubble根据文本长度自动换行步骤
                     *1. 获取文本的contentWidth,或者文本的宽（因为再没有wrap的时候，contentWidth=width）
                     *2. 比较contentWidth的宽度和bubble最大宽度之间的大小，并将bubble的宽度设置为两者最小的
                     *3. bubble长度确定后，就可以重新根据bubble的长度去设置text组件的宽度，设置后，如果text的contentWidth超过设定宽度，text会自动warp
                     *4. 文本wrap后，text的高度会发生变化，此时根据text的高度设置气泡的高度
                    */
                    //记录最初的文本宽度，便于调整窗口大小时，动态修改气泡宽度
                    initTextWidth = loader.item.width
                    //先修改wholeBubbleID宽，在根据wholeBubbleID宽修改loader.item.width，由于修改了loader.item.width，text的高度会发送变化，此时在设置wholeBubbleID.height的高
                    wholeBubbleID.width = Math.min(chatListItem.bubbleMaxWidth, loader.item.width+2*bubblePadding)
                    loader.item.width = wholeBubbleID.width - 2*bubblePadding
                    wholeBubbleID.height = Math.max(chatListItem.bubbleMinHeight, loader.item.height+2*bubblePadding)

                    finishLoadComponent = true
                }
            }
            /*****************loader要根据消息类型动态加载的组件*********************/
            Component{
                id: txtComponentID
                Common.BasicText{
                    //不设置宽高，那么该组件的宽高默认是文本的宽高，而且contentWidth = width
                    id: txtMsgID
                    text: index + " aafsa46465465465464654654654564564655465466544646df"
                    wrapMode: Text.WrapAnywhere  //超过设定宽度后自动换行
                }
            }


            Component{
                id: fileComponentID
                Rectangle{
                    id: fileMsgID
                    width: 220
                    height: 90
                    border.width: 1
                    border.color: "#eee"
                    property int margin: 4
                    Column{
                        id: fileContentID
                        anchors.fill: parent
                        anchors.margins: fileMsgID.margin
                        spacing: 4
                        Row{//显示文件图片，文件名称，保存路径
                            width: parent.width
                            height: 50
                            spacing: 8
                            Image {
                                id: fileImageID
                                width: parent.height
                                height: width
                                source: "qrc:/source/images/txt.png"
                            }
                            Column{
                                width: parent.width
                                height: parent.height
                                Item{
                                    width: parent.width
                                    height: parent.height
                                    Common.BasicText{
                                        width: parent.width - fileImageID.width - 2*fileMsgID.margin
                                        anchors.top: parent.top
                                        font.pixelSize: 17
                                        text: "文件名称.docx"
                                        wrapMode: Text.NoWrap
                                    }
                                    Common.BasicText{
                                        width: parent.width - fileImageID.width - 2*fileMsgID.margin
                                        anchors.bottom: parent.bottom
                                        text: "F:/ABC/D/FFFFFFFFFFFFFFFF"
                                        font.pixelSize: 14
                                        color: "#888"
                                        wrapMode: Text.NoWrap
                                    }
                                }
                            }
                        }

                        //进度条
                        ProgressBar {
                             id: fileProgressBarID
                             value: 0.5
                             padding: 0
                             //宽度根据background决定

                             background: Rectangle {
                                 implicitWidth: fileContentID.width
                                 implicitHeight: 4
                                 color: "#e6e6e6"
                                 radius: 2
                             }

                             contentItem: Item {
                                 implicitWidth: fileContentID.width
                                 implicitHeight: 4

                                 Rectangle {
                                     width: fileProgressBarID.visualPosition * parent.width
                                     height: parent.height
                                     radius: 2
                                     color: "#17a81a"
                                 }
                             }
                         }

                        //底部按钮


                    }

                }
            }

            Component{
                id: voiceComponentID
                Rectangle{
                    id: voiceMsgID
                }
            }


        }
    }



    function getComponetWidth(msgType){
        switch(msgType){
        case chatListItem.txt:
            return txtComponentID.contentWidth
        case chatListItem.file:
            return fileComponentID.width + bubblePadding
        case voice:
            return voiceComponentID.width + bubblePadding
        }
    }

    function getComponetHeight(msgType){
        switch(msgType){
        case chatListItem.txt:
            return txtComponentID.contentHeight + 2 * bubblePadding
        case chatListItem.file:
            return fileComponentID.height + 2 * bubblePadding
        case voice:
            return voiceComponentID.height + 2 * bubblePadding
        }
    }

    function getComonentByMsgType(msgType){
        switch(msgType){
        case chatListItem.txt:
            return txtComponentID
        case chatListItem.file:
            return fileComponentID
        case voice:
            return voiceComponentID
        }
    }
}


