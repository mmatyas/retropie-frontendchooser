#include "Frontend.h"
#include "Installer.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QVector>


namespace {
QList<QObject*> create_model()
{
    return {
        new Frontend(
            QStringLiteral("EmulationStation"),
            QStringLiteral("Frontend used by RetroPie for launching emulators (default)."),
            QStringLiteral("es.png"),
            QStringLiteral("emulationstation"),
            QStringLiteral("/usr/bin/emulationstation")
        ),
        new Frontend(
            QStringLiteral("AttractMode"),
            QStringLiteral("Attract-Mode is a graphical frontend for command line emulators such as MAME, MESS and Nestopia."),
            QStringLiteral("attract.png"),
            QStringLiteral("attractmode"),
            QStringLiteral("/usr/bin/attract")
        ),
        new Frontend(
            QStringLiteral("mehstation"),
            QStringLiteral("Open-source frontend launcher for your retrobox."),
            QStringLiteral("meh.png"),
            QStringLiteral("mehstation"),
            QStringLiteral("/usr/bin/mehstation")
        ),
        new Frontend(
            QStringLiteral("Pegasus"),
            QStringLiteral("A graphical frontend for browsing your game library and launching all kinds of emulators from the same place."),
            QStringLiteral("pegasus.png"),
            QStringLiteral("pegasus-fe"),
            QStringLiteral("/opt/retropie/supplementary/pegasus-fe/pegasus-fe")
        ),
    };
}

} // namespace


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    const QList<QObject*> frontendModel(create_model());
    Installer installer;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QStringLiteral("frontendModel"), QVariant::fromValue(frontendModel));
    engine.rootContext()->setContextProperty(QStringLiteral("installer"), &installer);
    engine.load(QUrl(QStringLiteral("qrc:/ui/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
