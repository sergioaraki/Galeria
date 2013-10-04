import bb.cascades 1.0

Page {
    titleBar: TitleBar {
        title: "Acerca de"
        acceptAction: ActionItem {
            title: "Ok"
            onTriggered: {
                aboutSheet.close();
            }
        }
    }
    Container {
        
    }
}
