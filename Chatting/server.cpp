#include "server.h"
#include <QHostAddress>
#include <QHostInfo>
#include <QDateTime>
#include <QDebug>
#include <QNetworkInterface>
#include <QTime>
#include <QDataStream>
#include <QProcess>
#include <QThread>
#include "sendmsgrunnable.h"
Server::Server(QObject *parent)
    : QObject{parent}
{
    threadPool = QThreadPool::globalInstance();
    threadPool->setMaxThreadCount(QThread::idealThreadCount());
    initSocket();
}

void Server::initSocket()
{
    udpSocket = new QUdpSocket(this);
    port = 4545;

    udpSocket->bind(port, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint); //将udp套接字绑定到指定ip和端口,只能用这种方式，免得对面有多个网络适配器导致收不到消息
    connect(udpSocket, &QUdpSocket::readyRead, this, &Server::readPendingDatagrams);
    sendMessage(NewClient); //将新用户上线的消息发送给其他主机
}

void Server::newClient(QString userName, QString address, QString headImage)
{

}

void Server::sendMessage(MessageType type, QString serverAddress)
{
    QByteArray data;
    QDataStream out(&data, QIODevice::WriteOnly);
    QString myAddress = getIP();  //获取本地ip
    QString myName = getUserName();
    QString headImage = "qrc:/source/images/default_image.png";
    User myself(headImage, myAddress, myName);
    out<<type; //将type，data
    switch (type)
    {
    case Message:
    {
        //显示消息
    }
        break;
    case NewClient:
    {
        out<<myself;  //把自己的信息都写入data，以便发送给对方
//        QThread::sleep(5);
        SendMsgRunnable *sendMsgRunnable = new SendMsgRunnable(new QUdpSocket(this), "", port, data);
        connect(sendMsgRunnable, &SendMsgRunnable::sendMsgFinish, this, [=]{
            qDebug()<<"线程发送数据成功";
        });
        sendMsgRunnable->setAutoDelete(true);
        threadPool->start(sendMsgRunnable);
    }
        break;
    case ClientLeft:
        break;
    case FileName:
    {

    }
        break;
    case Refuse:
        break;
    }
    //UDP把消息广播给局域网其他地址
//    if (serverAddress == "")
//        udpSocket->writeDatagram(data, data.length(), QHostAddress::Broadcast, port);
//    else
//        udpSocket->writeDatagram(data, data.length(), (QHostAddress)serverAddress, port);
}

QString Server::getIP()
{
    QList<QHostAddress> list = QNetworkInterface::allAddresses();
    foreach(QHostAddress address, list)
    {
        if(address.protocol() == QAbstractSocket::IPv4Protocol)
            return address.toString();
    }
    return 0;
}

QString Server::getUserName()
{
    QStringList envVariables;
    envVariables<<"USERNAME.*"<<"USER.*"<<"USERDOMAIN.*"<<"HOSTNAME. *"<<"DOMAINNAME.*";
    QStringList environment = QProcess::systemEnvironment();
    foreach(QString string, envVariables){
        int index = environment.indexOf(QRegExp(string));
        if(index!=-1){
            QStringList stringList = environment.at(index).split('=');
            if(stringList.size() == 2){
                return stringList.at(1);
                break;
            }
        }
    }
    return "";
}

//QUdpSocket::readyRead槽函数，处理套接字的数据可读
void Server::readPendingDatagrams()
{
    while(udpSocket->hasPendingDatagrams()){ //循环读取数据报
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        //将接受的数据存入datagram变量中
        QHostAddress *peerAddress = new QHostAddress();
        udpSocket->readDatagram(datagram.data(), datagram.size(), peerAddress);
//        udpSocket->readDatagram(buf,sizeof(buf),&address,&port)
        QDataStream in(&datagram,QIODevice::ReadOnly);
        int messageType;
        in>>messageType; //从datagram中读取MessageType
        QString time = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
        switch (messageType) {
        case Message:
        {
            //取出变量的顺序要和发送时一致 out<<type<<getUserName()<<localHoistName<<address<<getMessage();
        }
            break;
        case NewClient:
        {
            User recvUser;  //用于接受对方发送的用户信息
            in>>recvUser;
            emit newClientComing(recvUser); //发出信号，绑定是在maincontrol中完成
        }
            break;
        case ClientLeft:
        {

        }
            break;
        case FileName:
        {

        }
            break;
        case Refuse:
        {

        }
            break;

        }
    }
}
