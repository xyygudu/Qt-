import QtQuick 2.0
import "qrc:/script/BubbleNormal.js" as BubbleNormal



Item {
    id: container
    property string msgText: ""
    property bool isSend: true
    property int iconHeight: 40
    property int maxWidth: 100

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            BubbleNormal.drawBubble(getContext('2d'));
        }
    }

    Text {
        id: text
        text: msgText
        font.pixelSize: 17
        font.family: "Microsoft Yahei"
        wrapMode: Text.WrapAnywhere

        horizontalAlignment:  Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent
    }

    Component.onCompleted: {
        BubbleNormal.initText();
        BubbleNormal.reUpdateSize();
        canvas.requestPaint();
    }

}
