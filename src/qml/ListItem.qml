import QtQuick 2.6
import net.pezzato.sdcardcid 1.0

Item {
  property int mmcblkId: 0
  readonly property string cid: SdcardCid.getCIDString(String(mmcblkId))
  readonly property real padding: (height - textElement.implicitHeight) / 2

  height: textElement.implicitHeight * 2
  width: childrenRect.width + padding * 2

  Item {
    width: children[0].implicitWidth
    height: children[0].implicitHeight
    anchors {
      top: parent.top
      topMargin: padding
      left: parent.left
      leftMargin: padding
    }
    Text {
      id: textElement
      text: qsTr("%1: %2").arg(mmcblkId).arg(cid);
      visible: cid !== ""
    }
  }
}
