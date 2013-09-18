import bb.cascades 1.0
import bb.data 1.0

Page {
    property int index: 0
    Container {
        topPadding: 20
        leftPadding: 20
        rightPadding: 20
        property double downX
        property double downY
        layout: StackLayout {
        }
        ImageView {
            id: image
            horizontalAlignment: HorizontalAlignment.Center
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
            }
        }
    ]
    onCreationCompleted: {
        dataSource.load();
    }
}
