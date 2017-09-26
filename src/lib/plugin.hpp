#ifndef PLUGIN_HPP_PN3965QQ
#define PLUGIN_HPP_PN3965QQ

#include <QQmlExtensionPlugin>

class SdcardCidPlugin : public QQmlExtensionPlugin {
  Q_OBJECT
  Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
  virtual ~SdcardCidPlugin();
  void initializeEngine(QQmlEngine* engine, const char* uri);
  void registerTypes(const char* uri);
};

#endif /* end of include guard: PLUGIN_HPP_PN3965QQ */
