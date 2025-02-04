#include "rpiplugin.h"
#include <QFileInfo>
#include <QFile>
#include <QJsonValue>

RPiPlugin::RPiPlugin(QObject *parent) : QObject (parent)
{
}
void RPiPlugin::init(){
    connect(&m_settings, &QQmlPropertyMap::valueChanged, this, &RPiPlugin::settingsChanged);
    if (m_settings.contains("brightness")) {
        applyBrightness(m_settings.value("brightness").toInt());
    } else {
        applyBrightness(255);
    }
}
// maps slider value (0-100) to (0-255)
int RPiPlugin::mapBrightness(int v) {
    return v*255/100;
}

void RPiPlugin::applyBrightness(int v) {
    if(v > 255){
        v = 255;
    }else if(v < 10){
        v = 10;
    }

    QFile file("/sys/class/backlight/rpi_backlight/brightness");
    if (file.open(QIODevice::WriteOnly | QIODevice::ExistingOnly | QIODevice::Text)) {
        QTextStream stream(&file);
        stream << mapBrightness(v);
        file.close();
    }
}

void RPiPlugin::settingsChanged(const QString &key, const QVariant &value){
    if (key == "brightness") {
        qDebug() << "settingChanged : " << value;
        applyBrightness(value.toInt());
    }
}

