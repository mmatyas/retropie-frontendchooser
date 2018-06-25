#include "Installer.h"

#include <QDir>
#include <QFileInfo>


Installer::Installer(QObject* parent)
    : QObject(parent)
    , m_pkgman_path(QDir::homePath() + QStringLiteral("/RetroPie-Setup/retropie_packages.sh"))
{}

bool Installer::retropieAvailable() const
{
    const QFileInfo pkgman(m_pkgman_path);
    return pkgman.exists() && pkgman.isFile() && pkgman.isExecutable();
}

bool Installer::installed(const QString& package)
{
    const QFileInfo file(QStringLiteral("/opt/retropie/supplementary/") + package);
    return file.exists() && file.isDir();
}
