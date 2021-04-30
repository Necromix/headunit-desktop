#ifndef MEDIASCANNER_H
#define MEDIASCANNER_H

#include <QObject>
#include <QString>
#include <QThread>
#include <QDir>
#include <QDebug>
#include <QDateTime>
#include <QtSql>
#include "mediadb.h"
#include <QStorageInfo>
#include <QVariant>
#include <QQueue>
#include <taglib/taglib.h>
#include <taglib/tag.h>
#include <taglib/fileref.h>
#include <taglib/taglib_config.h>
#include <taglib/tpropertymap.h>
#include <taglib/id3v2tag.h>

class MediaScanner: public QThread
{
Q_OBJECT
public:
    explicit MediaScanner(MediaDB *mediadb, QObject *parent = nullptr);
    virtual void run() override;
    QVariantList getVolumes();
    int addLocation(MediaDB *mediadb, QString path);
    void scanLocation(MediaDB *mediadb, int location_id);
    void updateLocationsAvailability(MediaDB *mediadb);
signals:
    void scanningStarted();
    void scanningFinished();
private:
    QStringList audioFileTypes;
    QStringList videoFileTypes;
    QStringList playlistFileTypes;
    QStringList imageFileTypes;
    QStringList mediaFileTypes;
    QQueue<QMap<QString, QVariant>> pathsToScan;
    MediaDB *m_mediadb;
    QString getStorageUUID(QString device);
    bool isRunning;

    void scanForMediaFiles(MediaDB *mediadb, QString path, int folder_id);
    void scanForFolders(MediaDB *mediadb, QString path, bool is_root, int location_id, QString current_dir, qint64 last_modified);
    QString scanForThumbnail(QString path, bool tryParent, QString absPosition);
};

#endif // MEDIASCANNER_H
