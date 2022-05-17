import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
    id: bubbleID
    border.color: "#111"
    color: "#22dd22"
    radius: 4
    implicitHeight: 60
    implicitWidth: 60

    readonly property int trianglePosLeft: 0        //三角形位于那个方向
    readonly property int trianglePosRight: 1
    readonly property int trianglePosTop: 2
    readonly property int trianglePosBottom: 3

    property int trangleWidth: 16
    property int trianglePos: trianglePosLeft
    property int triangleOffset: 10                  //三角形相对矩形框的偏移量

    property int triangleX: width / 2
    property int triangleY: height / 2

    Rectangle {
        id: triangleLeftRight
        visible: trianglePos === trianglePosLeft || trianglePos === trianglePosRight
        width: trangleWidth
        height: width
        rotation: 45
        y: triangleOffset- trangleWidth/2/*triangleY - trangleWidth / 2 + triangleOffset  //居中*/
        x: (trianglePos === trianglePosLeft) ? -width / 2 + 2: bubbleID.width - width / 2 - 2
        color: parent.color
        border.color: parent.border.color

    }
    Rectangle {
        visible: trianglePos === trianglePosLeft || trianglePos === trianglePosRight
        width: triangleLeftRight.width
        height: triangleLeftRight.height * 1.5
        y: triangleLeftRight.y-5
        x: (trianglePos === trianglePosLeft) ? 1 : bubbleID.width - width - 1
        color: parent.color
    }

    Rectangle {
        id: triangleTopBottom
        visible: trianglePos === trianglePosTop || trianglePos === trianglePosBottom
        width: trangleWidth
        height: width
        rotation: 45
        x: triangleOffset- trangleWidth/2/*triangleX - trangleWidth / 2 + triangleOffset*/
        y: (trianglePos === trianglePosTop) ? -height / 2 + 2 : bubbleID.height - height / 2 - 2
        color: parent.color
        border.color: parent.border.color
    }
    Rectangle {
        visible: trianglePos === trianglePosTop || trianglePos === trianglePosBottom
        width: triangleTopBottom.width * 1.5
        height: triangleTopBottom.height
        x: triangleTopBottom.x - 5
        y: (trianglePos === trianglePosTop) ? 1 : bubbleID.height - height - 1
        color: parent.color
    }

}

