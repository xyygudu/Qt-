import QtQuick 2.0

Text {
    verticalAlignment: Text.AlignVCenter
//    horizontalAlignment: Text.AlignHCenter
    font.family: "微软雅黑"
    font.pixelSize: 14
    elide: Text.ElideRight      //超出部分会被显示为省略号
    wrapMode: Text.WrapAnywhere  //任意一个地方都可以换行，也就是可能出现单词被分割成上下两行
    color: "#333"
}
