TARGET = widgettodo
QT += widgets network
QT += enginio

RESOURCES += \
    ../../resources.qrc

MOC_DIR = ./.moc
OBJECTS_DIR = ./.obj
UI_DIR = ./.ui
RCC_DIR = ./.rcc


SOURCES += \
    $$PWD/main.cpp \
    $$PWD/todowindow.cpp

HEADERS += \
    $$PWD/todowindow.h

