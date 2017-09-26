import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Qt.labs.settings 1.0

ApplicationWindow {
  id: app

  visible: true
  width: 600
  height: 338
  title: "SDCARD-CID"

  ListView {
    anchors { fill: parent; }
    orientation: Qt.Vertical
    boundsBehavior: Flickable.StopAtBounds
    model: [ 0, 1, 2, 3 ]
    delegate: ListItem {
      mmcblkId: modelData
      width: ListView.view.width;
    }
  }
}
