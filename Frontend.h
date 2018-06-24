#pragma once

#include <QObject>
#include <QString>


class Frontend : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name MEMBER m_name CONSTANT)
    Q_PROPERTY(QString desc MEMBER m_desc CONSTANT)
    Q_PROPERTY(QString logo MEMBER m_logo CONSTANT)

public:
    explicit Frontend(QString name, QString desc, QString logo,
                      QString packageName,
                      QObject* parent = nullptr);

private:
    const QString m_name;
    const QString m_desc;
    const QString m_logo;
    const QString m_package_name;
};
