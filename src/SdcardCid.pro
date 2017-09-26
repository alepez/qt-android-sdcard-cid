TEMPLATE = app
QT += qml quick quickcontrols2
RESOURCES += app.qrc
CONFIG += c++11

SOURCES += main.cpp

android: {
  # QT += androidextras

  ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../android

  # Note: No one knows, but plugins must be first installed in Qt SDK qml directory.
  ANDROID_EXTRA_LIBS += /opt/Qt/5.8/android_armv7/qml/net/pezzato/sdcardcid/libSdcardCidPlugin.so

  DISTFILES += ../android/AndroidManifest.xml
  DISTFILES += ../android/gradle/wrapper/gradle-wrapper.jar
  DISTFILES += ../android/gradlew
  DISTFILES += ../android/res/values/libs.xml
  DISTFILES += ../android/build.gradle
  DISTFILES += ../android/gradle/wrapper/gradle-wrapper.properties
  DISTFILES += ../android/gradlew.bat
}
