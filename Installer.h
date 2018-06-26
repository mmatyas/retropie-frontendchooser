#pragma once

#include "Frontend.h"

#include <QObject>
#include <QProcess>


class Installer : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool retropieAvailable READ retropieAvailable CONSTANT)
    Q_PROPERTY(QString log READ log NOTIFY logChanged)
    Q_PROPERTY(bool taskRunning READ taskRunning NOTIFY taskRunChanged)
    Q_PROPERTY(bool taskFailed READ taskFailed NOTIFY taskFailChanged)

public:
    explicit Installer(QObject* parent = nullptr);

    Q_INVOKABLE bool installed(Frontend* frontend) const;
    Q_INVOKABLE void startInstall(Frontend* frontend);

    bool retropieAvailable() const;
    bool taskRunning() const { return m_task_running; }
    bool taskFailed() const { return m_task_failed; }
    QString log() const { return m_log; }

signals:
    void logChanged();
    void taskRunChanged();
    void taskFailChanged();

private slots:
    void onProcessReadyRead();
    void onProcessError(QProcess::ProcessError);
    void onProcessFinished(int, QProcess::ExitStatus);

private:
    const QString m_pkgman_path;
    QString m_log;
    QProcess m_process;
    bool m_task_running;
    bool m_task_failed;
};
