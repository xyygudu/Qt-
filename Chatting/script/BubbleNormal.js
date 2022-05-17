/****************************************************************************
**  气泡
****************************************************************************/
.import QtQuick 2.0 as QQ


var BubbleTailWitdh = 10        // 气泡尾巴
var BubbleMargin = 10           // 文本外边框
var BubbleRadius = 6
var BubbleTailHeight = 3

function drawBubble(context) {

    var bubbleTailY = container.iconHeight/2     // 尾巴高度
    // Context2D
    context.clearRect(0,0,container.width, container.height)
    context.beginPath()
    context.roundedRect(isSend ? 0 : BubbleTailWitdh, 0,
                        container.width - BubbleTailWitdh, container.height,
                        BubbleRadius, BubbleRadius);

    context.moveTo(isSend ? container.width - BubbleTailWitdh : BubbleTailWitdh, bubbleTailY - BubbleTailHeight);
    context.lineTo(isSend ? container.width : 0, bubbleTailY );
    context.lineTo(isSend ? container.width - BubbleTailWitdh : BubbleTailWitdh, bubbleTailY + BubbleTailHeight);
    context.closePath()
    context.fillStyle = isSend ?  "#A0EA6F" : "#f4f4f4"

    context.fill()
}

function initText() {


    text.font.pixelSize = 14
    text.font.family = "Microsoft Yahei"
    text.anchors.margins = BubbleMargin
    if (isSend) {
        text.color = "#0E0E0E"
        text.anchors.rightMargin = BubbleMargin + BubbleTailWitdh
    } else {
        text.color = "#0E0E0E"
        text.anchors.leftMargin = BubbleMargin + BubbleTailWitdh
    }
    var textheight =  iconHeight * 1.0
    container.width = (text.contentWidth + BubbleMargin*2 + BubbleTailWitdh) > maxWidth ? maxWidth : (text.contentWidth + BubbleMargin*2 + BubbleTailWitdh)
    container.height = text.contentHeight + BubbleMargin*2  < textheight ? textheight : text.contentHeight + BubbleMargin*2
//    console.log("init: ", container.width, container.height, text.contentWidth, text.contentHeight)
}

function reUpdateSize() {
    var textheight =  iconHeight * 1.0
    container.width = (text.contentWidth + BubbleMargin*2 + BubbleTailWitdh) > maxWidth ? maxWidth : (text.contentWidth + BubbleMargin*2 + BubbleTailWitdh)
    container.height = text.contentHeight + BubbleMargin*2  < textheight ? textheight : text.contentHeight + BubbleMargin*2
//    console.log("reUpdateSize: ", container.width, container.height, text.contentWidth, text.contentHeight)
}
