#ifndef NETWORKINFO_HPP_7QHCCXEP
#define NETWORKINFO_HPP_7QHCCXEP

#include <QObject>

class SdcardCid : public QObject {
  Q_OBJECT

public:
  SdcardCid(QObject* parent = nullptr);
  virtual ~SdcardCid();

  Q_INVOKABLE QString getCIDString(QString);
};

#endif /* end of include guard: NETWORKINFO_HPP_7QHCCXEP */
