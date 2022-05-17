#include "sendmsgrunnable.h"
#include <QDebug>
#include <QThread>


SendMsgRunnable::SendMsgRunnable(QObject *parent)
    : QObject{parent}
{

}

SendMsgRunnable::SendMsgRunnable(QUdpSocket* udpSocket, const QString &serverAddr, quint16 serverPort, QByteArray data)
    :udpSocket(udpSocket), serverAddr(serverAddr), serverPort(serverPort), data(data)
{

}

void SendMsgRunnable::run()
{
    qDebug()<<"sendmsgrunnable.cpp.SendMsgRunnable: 子线程："<< QThread::currentThreadId();
    if (serverAddr == "")
        udpSocket->writeDatagram(data, data.length(), QHostAddress::Broadcast, serverPort);
    else
        udpSocket->writeDatagram(data, data.length(), (QHostAddress)serverAddr, serverPort);
    emit sendMsgFinish();
}

