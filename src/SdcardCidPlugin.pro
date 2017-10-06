TEMPLATE = lib
QT += qml quick concurrent
RESOURCES += plugin.qrc
CONFIG += c++11

SOURCES += lib/SdcardCid.cpp
SOURCES += lib/plugin.cpp

HEADERS += lib/SdcardCid.hpp
HEADERS += lib/plugin.hpp

android: {
  QT += androidextras
  LIBS += -L/opt/crystax/sources/crystax/libs/$$(APP_ABI)
}
