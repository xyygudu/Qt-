#ifndef SENDMSGRUNNABLE_H
#define SENDMSGRUNNABLE_H

#include <QObject>
#include <QRunnable>
#include <QDataStream>
#include <QUdpSocket>

class SendMsgRunnable : public QObject, public QRunnable
{
    Q_OBJECT
public:
    explicit SendMsgRunnable(QObject *parent = nullptr);

    //dataStream：要发送的数据
    SendMsgRunnable(QUdpSocket* udpSocket, const QString &serverAddr, quint16 serverPort, QByteArray data);
    void run() override;

signals:
    void sendMsgFinish();


private:
    QUdpSocket *udpSocket;
    QString serverAddr;
    qint16 serverPort;
    QByteArray data;
};

#endif // SENDMSGRUNNABLE_H
