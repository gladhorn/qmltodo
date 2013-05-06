QT += qml quick widgets network
QT += enginio

TEMPLATE = subdirs
SUBDIRS += src

OTHER_FILES += \
    qml/*.qml

RESOURCES += \
    resources.qrc

MOC_DIR = ./.moc
OBJECTS_DIR = ./.obj
UI_DIR = ./.ui
RCC_DIR = ./.rcc
