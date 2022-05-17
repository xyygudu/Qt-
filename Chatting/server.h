#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QTcpServer>
#include <QUdpSocket>
#include <QThreadPool>
#include "user.h"


//MessageType指示upd消息类型，不同的消息类型做不同处理
enum MessageType
{
    Message,        //收到消息
    NewClient,      //新用户上线
    ClientLeft,     //用户下线
    FileName,       //收到文件名：表示对方发出了发送文件到本机
    Refuse          //是接受文件还是拒接
};


class Server : public QObject
{
    Q_OBJECT
public:
    explicit Server(QObject *parent = nullptr);
private:
    //初始化套接字
    void initSocket();
    void newClient(QString userName, QString address, QString headImage);
    void clientLeft(QString userName, QString localHostName, QString time);
public:
    void sendMessage(MessageType type, QString serverAddress="");

    QString getIP();        //获取本机的IP
    QString getUserName();  //获取本机的用户名称
    QString getMessage();   //获取发送框种准备发送的消息

private slots:
    void readPendingDatagrams();  //当套接字中有数据可读就会在该槽函数进行处理

signals:
    void newClientComing(User user);

private:
    QUdpSocket *udpSocket;
    qint16 port;

    QThreadPool *threadPool;
};

#endif // SERVER_H
