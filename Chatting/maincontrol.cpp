#include "maincontrol.h"
#include <QDebug>

MainControl::MainControl(QObject *parent)
    : QObject{parent}
{
    m_userListModel = new UserListModel(this);
    m_server = new Server(this);

    connect(m_server, &Server::newClientComing, this, &MainControl::newClient);
}

UserListModel *MainControl::userListModel() const
{
    return m_userListModel;
}

void MainControl::newClient(User user)
{
    //如果该user不在好友列表userList中，则添加到好友列表中
    if (m_userListModel->isUserInList(user) == false){
        m_userListModel->append(user);
        m_server->sendMessage(NewClient, user.getIpAddress()); //向新来的用户反馈自己在线，以便让对方好友列表中添加本机
    }
    else{
        qDebug()<<"MainControl::newClient: 该用户已经在用户列表，其ip为： "<<user.getIpAddress();
    }
}

