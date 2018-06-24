#pragma once

#include <QObject>


class Installer : public QObject {
    Q_OBJECT

    Q_PROPERTY(bool retropieAvailable READ retropieAvailable CONSTANT)

public:
    explicit Installer(QObject* parent = nullptr);

    bool retropieAvailable() const;

private:
    const QString m_pkgman_path;
};
