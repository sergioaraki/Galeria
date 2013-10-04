import bb.cascades 1.0

Page {
    titleBar: TitleBar {
        title: "Configuración"
        acceptAction: ActionItem {
            title: "Ok"
            onTriggered: {
                configSheet.close();
            }
        }
    }
    Container {
        topPadding: 20
        leftPadding: 20
        rightPadding: 20
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Label {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                text: "AutoScroll"
            }
            ToggleButton {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                id: autoScroll
                onCheckedChanged: {
                    app.setAutoScroll(checked);
                    autoScroll = checked;
                    if (checked)
                        tAutoScroll.start();
                    else 
                        tAutoScroll.stop();
                }
            }
        }
    }
    onCreationCompleted: {
        autoScroll.setChecked(app.getAutoScroll());
    }
}
