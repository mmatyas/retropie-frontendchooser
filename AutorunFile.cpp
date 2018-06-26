#include "AutorunFile.h"

#include <QFile>
#include <QTextStream>
#include <QVector>
#include <functional>


namespace {

void process_lines(const QString& file_path, const std::function<void(const QString&)>& fn)
{
    QFile file(file_path);
    if (!file.open(QIODevice::ReadOnly))
        return;

    QTextStream stream(&file);
    QString line;
    while (stream.readLineInto(&line))
        fn(line);
}

QStringList find_autostarting_exes(const QString& file_path)
{
    QStringList found_exes;
    process_lines(file_path,
        [&found_exes](const QString& line){
            if (line.contains(QStringLiteral("#auto")))
                found_exes.append(line.splitRef(' ').first().toString());
        });
    return found_exes;
}

QStringList read_regular_lines(const QString& file_path)
{
    QStringList lines;
    process_lines(file_path,
        [&lines](const QString& line){
            if (!line.contains(QStringLiteral("#auto")))
                lines.append(line);
        });
    return lines;
}
} // namespace


AutorunFile::AutorunFile(QObject*parent)
    : QObject(parent)
    , m_file_path(QStringLiteral("/opt/retropie/configs/all/autostart.sh"))
    , m_autostarting_exes(find_autostarting_exes(m_file_path))
{}

bool AutorunFile::isAutostarting(Frontend* frontend) const
{
    return m_autostarting_exes.contains(frontend->m_exe_path);
}

bool AutorunFile::setAsDefault(Frontend* frontend)
{
    QStringList lines = read_regular_lines(m_file_path);

    QFile file(m_file_path);
    if (!file.open(QIODevice::WriteOnly))
        return false;

    QTextStream stream(&file);
    for (const QString& line : qAsConst(lines))
        stream << line;
    stream << frontend->m_exe_path << " #auto\n";

    m_autostarting_exes = QStringList { frontend->m_exe_path };
    emit settingsChanged();
    return true;
}
