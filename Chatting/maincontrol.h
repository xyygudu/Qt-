#ifndef MAINCONTROL_H
#define MAINCONTROL_H
#include "userlistmodel.h"
#include "server.h"
#include "user.h"
#include <QObject>

class MainControl : public QObject
{
    Q_OBJECT
    Q_PROPERTY(UserListModel *userListModel READ userListModel CONSTANT)

public:
    explicit MainControl(QObject *parent = nullptr);

    UserListModel *userListModel() const;

private :
    UserListModel *m_userListModel;     //用于显示用户列表的listmodel,qml使用的就是这个

    Server *m_server;

public slots:
    void newClient(User user);

signals:

};

#endif // MAINCONTROL_H
