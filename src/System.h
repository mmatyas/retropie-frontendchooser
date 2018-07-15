#pragma once

#include <QObject>


class System : public QObject {
    Q_OBJECT

public:
    explicit System(QObject *parent = nullptr);

    Q_INVOKABLE void reboot() const;
};
