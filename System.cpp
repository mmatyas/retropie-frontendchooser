#include "System.h"

#include <QProcess>


System::System(QObject *parent)
    : QObject(parent)
{}

void System::reboot() const
{
    QProcess::startDetached(QLatin1String("reboot"));
}
