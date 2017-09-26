#include "plugin.hpp"
#include "SdcardCid.hpp"

#include <QDebug>
#include <QQmlEngine>
#include <qqml.h>

void SdcardCidPlugin::initializeEngine(QQmlEngine* engine, const char* uri) {
  Q_UNUSED(engine);
  Q_UNUSED(uri);
  // qDebug() << "initializeEngine";
}

void SdcardCidPlugin::registerTypes(const char* uri) {
  qmlRegisterSingletonType<SdcardCid>(uri, 1, 0, "SdcardCid", [](QQmlEngine*, QJSEngine*) -> QObject* {
    /*  */
    return new SdcardCid{};
  });
}

SdcardCidPlugin::~SdcardCidPlugin() {
  qDebug() << "Releasing plugin";
}
