#include "Installer.h"

#include <QFileInfo>


Installer::Installer(QObject* parent)
    : QObject(parent)
    , m_pkgman_path(QStringLiteral("/home/pi/RetroPie-Setup/retropie_packages.sh"))
    , m_task_running(false)
    , m_task_failed(false)
{
    m_process.setProcessChannelMode(QProcess::MergedChannels);
    // m_process.setWorkingDirectory(QStringLiteral("/home/pi"));
    connect(&m_process, &QProcess::readyRead, this, &Installer::onProcessReadyRead);
    connect(&m_process, &QProcess::errorOccurred, this, &Installer::onProcessError);
    connect(&m_process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            this, &Installer::onProcessFinished);
}

bool Installer::retropieAvailable() const
{
    const QFileInfo pkgman(m_pkgman_path);
    return pkgman.exists() && pkgman.isFile() && pkgman.isExecutable();
}

bool Installer::installed(const QString& package) const
{
    const QFileInfo file(QStringLiteral("/opt/retropie/supplementary/") + package);
    return file.exists() && file.isDir();
}

void Installer::startInstall(const QString& package)
{
    Q_ASSERT(m_process.state() != QProcess::Running);

    const QStringList arguments {
        package,
        QStringLiteral("install")
    };

    m_log = QStringLiteral("Launching `") + m_pkgman_path;
    for (const QString& arg : arguments)
        m_log += ' ' + arg;
    m_log += "`...\n";
    emit logChanged();

    m_task_running = true;
    m_task_failed = false;
    emit taskRunChanged();
    emit taskFailChanged();

    m_process.start(m_pkgman_path, arguments, QIODevice::ReadOnly);
}

void Installer::onProcessReadyRead()
{
    const auto prev_log_len = m_log.length();

    m_log += QString(m_process.readAllStandardOutput());

    if (prev_log_len != m_log.length())
        emit logChanged();
}

void Installer::onProcessError(QProcess::ProcessError)
{
    if (!m_log.isEmpty())
        m_log += '\n';

    m_log += m_process.errorString();
    emit logChanged();

    m_task_running = false;
    m_task_failed = true;
    emit taskRunChanged();
    emit taskFailChanged();
}

void Installer::onProcessFinished(int, QProcess::ExitStatus)
{
    m_task_running = false;
    m_task_failed = false;
    emit taskRunChanged();
    emit taskFailChanged();
}
