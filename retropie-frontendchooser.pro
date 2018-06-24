QT += quick
CONFIG += c++11

DEFINES += \
    QT_DEPRECATED_WARNINGS \
    QT_DISABLE_DEPRECATED_BEFORE=0x060000 \
    QT_RESTRICTED_CAST_FROM_ASCII \
    QT_NO_CAST_TO_ASCII \

SOURCES += \
    main.cpp \
    Frontend.cpp \
    Installer.cpp

RESOURCES += ui.qrc


unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Frontend.h \
    Installer.h
