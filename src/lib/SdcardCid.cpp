#include "SdcardCid.hpp"
#include <QDebug>

#ifdef Q_OS_ANDROID
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#include <QtAndroid>
#endif

SdcardCid::SdcardCid(QObject* parent)
    : QObject{parent} {
}

SdcardCid::~SdcardCid() {
}

QString SdcardCid::getCIDString(QString id) {
#ifdef Q_OS_ANDROID
  auto jid = QAndroidJniObject::fromString(id);

  auto result = QAndroidJniObject::callStaticObjectMethod( //
      "net/pezzato/sdcardcid/SdcardCid", "getCIDString",   //
      "(Ljava/lang/String;)Ljava/lang/String;",            //
      jid.object<jstring>());                              //

  return result.toString();
#else
  return QString{};
#endif
}
