#include "Frontend.h"


Frontend::Frontend(QString name, QString desc, QString logo,
                   QString packageName, QString exePath,
                   QObject* parent)
    : QObject(parent)
    , m_name(std::move(name))
    , m_desc(std::move(desc))
    , m_logo(std::move(logo))
    , m_package_name(std::move(packageName))
    , m_exe_path(std::move(exePath))
{}
