import QtQuick 2.15
import "qrc:/common" as Common

Component{
    id: txtComponentID
    Common.BasicText{
        //不设置宽高，那么该组件的宽高默认是文本的宽高，而且contentWidth = width
        id: txtMsgID
        text: index + " aafsa46465465465464654654654564564655465466544646df"
        wrapMode: Text.WrapAnywhere  //超过设定宽度后自动换行
    }
}
