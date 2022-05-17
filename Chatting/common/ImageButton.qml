import QtQuick 2.0


Item {
    id: imgbthID
    implicitWidth: 30  //没有设置宽度时默认就是这个值
    implicitHeight: 30
    property int radius: 0
    property string source: "qrc:/source/images/default_image.png"
    property string hoverSource: "qrc:/source/images/default_hover_image.png"
    property string color: "#fff"
    property string hoverColor: "#eee"
    signal imageClicked()

    Rectangle{
        anchors.fill: parent
        border.width: 0
        radius: imgbthID.radius
        color: imgbthID.color

        Image {
            id: image
            anchors.fill: parent
            source: imgbthID.source
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                image.source = imgbthID.hoverSource
                parent.color = imgbthID.hoverColor
            }

            onExited: {
                image.source = imgbthID.source
                parent.color = imgbthID.color
            }

            onClicked: imgbthID.imageClicked()  //发出图像点击信号
        }

    }

}


