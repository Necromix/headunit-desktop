import QtQuick 2.11
import QtQuick.Controls 2.4

import HUDTheme 1.0
import HUDVolume 1.0
import QtQuick.Layouts 1.3

Item {
    id: __root

    Item {
        id: item1
        anchors.fill: parent
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.bottomMargin: 8
        anchors.topMargin: 8

        Flickable {
            id: layout
            anchors.fill: parent
            clip: true
            flickableDirection: Flickable.VerticalFlick
            contentHeight : column.height

            ScrollBar.vertical: ThemeScrollBar { }

            Column {
                id:column
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 6
                anchors.rightMargin: 18
                Item {
                    id: outputsHeader
                    height: 30
                    width: parent.width

                    ThemeFormText {
                        text: "Outputs"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }



                    Rectangle {
                        height: 1
                        color: "#979797"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 20
                    }
                }

                Repeater {
                    model: SinkModel  {}
                    delegate: DeviceListItem {
                        x :20
                        width: parent.width - 20
                    }
                }

                Item {
                    id: voiceHeader
                    height: 30
                    width: parent.width

                    Rectangle {
                        height: 1
                        color: HUDStyle.Colors.formText
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                    }

                    ThemeFormText {
                        id: voiceLabel
                        text: "Voice"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }

                    Rectangle {
                        height: 1
                        color: "#979797"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 20
                    }
                }


                Repeater {
                    model: HUDMediaManager.VoiceVolumes.keys()
                    delegate: ModuleListItem {
                        x :20
                        width: parent.width - 20                       
                        value : HUDMediaManager.VoiceVolumes[modelData]
                        onValueChanged: {
                            HUDMediaManager.VoiceVolumes[modelData] = value
                        }
                    }
                }


                Item {
                    id: mediaHeader
                    height: 30
                    width: parent.width
                    Rectangle {
                        height: 1
                        color: HUDStyle.Colors.formText
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                    }

                    ThemeFormText {
                        id: mediaLabel
                        text: "Media"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }


                    Rectangle {
                        height: 1
                        color: "#979797"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 20
                    }
                }



                Repeater{
                    model: HUDMediaManager.MediaVolumes.keys()
                    delegate: ModuleListItem {
                        x :20
                        width: parent.width - 20
                        value : HUDMediaManager.MediaVolumes[modelData]
                        onValueChanged: {
                            HUDMediaManager.MediaVolumes[modelData] = value
                        }
                    }
                }



                Item {
                    id: inputsHeader
                    height: 30
                    width: parent.width
                    Rectangle {
                        height: 1
                        color: HUDStyle.Colors.formText
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                    }

                    ThemeFormText {
                        text: "Inputs"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }


                    Rectangle {
                        height: 1
                        color: "#979797"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 20
                    }

                }

                Repeater{
                    model: SourceModel {}
                    delegate: DeviceListItem {
                        x :20
                        width: parent.width - 20
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#c0c0c0";height:480;width:640}
}
##^##*/
