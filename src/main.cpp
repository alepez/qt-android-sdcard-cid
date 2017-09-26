#include <QDebug>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickView>

int main(int argc, char* argv[]) {

  QGuiApplication::setApplicationName("SDCARD CID");
  QGuiApplication::setOrganizationName("Alessandro Pezzato");
  QGuiApplication::setOrganizationDomain("pezzato.net");
  QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app(argc, argv);

  QQuickStyle::setStyle("Material");

  QQmlApplicationEngine engine;
  engine.load(QUrl("qrc:/qml/App.qml"));

  if (engine.rootObjects().isEmpty()) return -1;

  return app.exec();
}
