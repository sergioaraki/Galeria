import bb.cascades 1.0
import bb.data 1.0
import my.library 1.0

Page {
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                aboutSheet.open();
            }
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                configSheet.open();
            }
        }
    }
    property bool autoScroll: true
    property int index: 0
    Container {
        topPadding: 20
        leftPadding: 20
        rightPadding: 20
        property double downX
        property double downY
        layout: StackLayout {
        }
        Container {
            layout: DockLayout {
            }
	        ImageView {
	            id: image
	            horizontalAlignment: HorizontalAlignment.Center
	        }
            Container {
                id: status
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom
                bottomPadding: 5
            }
        }
        Label {
            id: label
            horizontalAlignment: HorizontalAlignment.Center
        }
        onTouch: {
            if (event.isDown()) {
                downX = event.windowX;
                downY = event.windowY;
            } else if (event.isUp()) {
                if (autoScroll) {
	                tAutoScroll.stop();
	                tAutoScroll.start();
                }
                var yDiff = downY - event.windowY;
                // take absolute value of yDiff
                if (yDiff < 0) yDiff = -1 * yDiff;
                // I check if the minimum y movement is less than 200.  Don't want to move left or right if 
                // the user is actually want to move up or down.
                if ((yDiff) < 200) {
                    if ((downX - event.windowX) > 320) {
                        if (index<dataModel.size()-1){
	                        index = index+1;
	                        var data = dataModel.value(index);
	                        image.imageSource = data.img;
	                        label.text = data.detail;
                        }
                    } else if ((event.windowX - downX) > 320) {
                        if (index>0){
	                        index = index-1;
	                        var data = dataModel.value(index);
	                        image.imageSource = data.img;
	                        label.text = data.detail;
                        }
                    }
                    for (var i=0; i<dataModel.size(); i++){
                        var control = status.at(i);
                        if (i==index)
                            control.active = true;
                        else
                            control.active = false;
                    }
                }
            }
        }
    }
    attachedObjects: [
        ArrayDataModel {
            id: dataModel
        },
        DataSource {
            id: dataSource
            source: "data.xml"
            query: "/root/item"
            type: DataSource.Xml
            onDataLoaded: {
                dataModel.append(data);  
                var dat = dataModel.value(index);
                image.imageSource = dat.img;
                label.text = dat.detail;
                if (autoScroll)
                	tAutoScroll.start();
                for (var i=0; i<dataModel.size(); i++){
                    var createdControl = circle.createObject();
                    createdControl.index = i;
                    if (i==0)
                        createdControl.active = true;
                    status.add(createdControl);
                }
            }
        },
        QTimer{
            id: tAutoScroll
            interval: 5000
            onTimeout:{
                if (index<dataModel.size()-1){
                    index = index+1;
                    var data = dataModel.value(index);
                    image.imageSource = data.img;
                    label.text = data.detail; 
                }
                else {
                    index = 0;
                    var data = dataModel.value(index);
                    image.imageSource = data.img;
                    label.text = data.detail;
                }
                for (var i=0; i<dataModel.size(); i++){
                    var control = status.at(i);
                    if (i==index)
                        control.active = true;
                    else
                        control.active = false;
                }
            }
        },
        ComponentDefinition {
            id: circle
            source: "Circle.qml"
        },
        Sheet {
            id: aboutSheet
            content: About{
            
            }
        },
        Sheet {
            id: configSheet
            content: Config{
            
            }
        }
    ]
    onCreationCompleted: {
        autoScroll = app.getAutoScroll();
        dataSource.load();
    }
}
