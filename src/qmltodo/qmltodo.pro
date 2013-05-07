TARGET = qmltodo
QT += qml quick widgets network
QT += enginio

OTHER_FILES += \
    ../../qml/*.qml

RESOURCES += \
    ../../resources.qrc

MOC_DIR = ./.moc
OBJECTS_DIR = ./.obj
UI_DIR = ./.ui
RCC_DIR = ./.rcc


SOURCES += \
           $$PWD/main.cpp \
           $$PWD/filtermodel.cpp

HEADERS += \
           $$PWD/filtermodel.h

