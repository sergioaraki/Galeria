import bb.cascades 1.0

Container {
    property bool active: false
    property int index
    layout: DockLayout {
    }
    ImageView {
        imageSource: "img/circle_off.png"
        maxHeight: 35
        maxWidth: 35
    }
    ImageView {
        imageSource: "img/circle_on.png"
        maxHeight: 35
        maxWidth: 35
        visible: active
    }
}
