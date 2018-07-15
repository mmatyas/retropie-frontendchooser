#pragma once

#include "Frontend.h"

#include <QObject>
#include <QString>
#include <QStringList>


class AutorunFile : public QObject {
    Q_OBJECT

public:
    explicit AutorunFile(QObject* parent = nullptr);

    Q_INVOKABLE bool isAutostarting(Frontend*) const;
    Q_INVOKABLE bool setAsDefault(Frontend*);

signals:
    void settingsChanged();

private:
    const QString m_file_path;
    QStringList m_autostarting_exes;
};
