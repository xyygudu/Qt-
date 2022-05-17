#include "userlistmodel.h"
#include <QDebug>

UserListModel::UserListModel(QObject *parent)
    : QAbstractListModel(parent), m_count(0)
{
//    User *user = new User("qrc:/source/images/default_image.png", "127.0.0.1", "zhaoshikun");
    append(User("qrc:/source/images/default_image.png", "127.0.0.1", "zhaoshikun"));
    append(User("qrc:/source/images/default_image.png", "127.0.0.1", "zhaoshikun"));
    append(User("qrc:/source/images/default_image.png", "192.168.1", "wangwu"));
    append(User("qrc:/source/images/default_image.png", "192.168.1.138", "zhaoliu"));

}


int UserListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return userList.count();
}

QVariant UserListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if(index.row() >= userList.size())
        return QVariant();

    switch (role) {
    case Headimage:
        return userList.at(index.row()).getHeadImage();
    case IpAdress:
        return userList.at(index.row()).getIpAddress();
    case Name:
        return userList.at(index.row()).getName();
    }

    return QVariant();
}


//定义role的别名,这些别名是方便在qml中使用
QHash<int, QByteArray> UserListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Headimage] = "headImage";
    roles[IpAdress] = "ipAddress";
    roles[Name] = "name";
    return roles;
}


//向Model中插入一项，同时会更新listview更新显示
void UserListModel::insert(int index, const User &user)
{
    if(index < 0 || index > userList.count())
    {
        qCritical()<<"insert error, index="<<index;
        return;
    }
    //进行增删改查都需要begin/end，用来发送信号通知关联Model上的view进行更新
    beginInsertRows(QModelIndex(), index, index); //QModelIndex()得到这个Model中的虚拟rootItem
    userList.insert(index, user);
    //发送count改变信号
    emit countChanged(count());
    endInsertRows();
}

void UserListModel::remove(int index)
{
    if(index < 0 || index > userList.count())
    {
        qCritical()<<"remove error, index="<<index;
        return;
    }
    beginRemoveRows(QModelIndex(), index, index);
    userList.removeAt(index);
    //发送count改变信号
    emit countChanged(count());
    endRemoveRows();
}

void UserListModel::append(const User &user)
{
    int i = userList.size();
    beginInsertRows(QModelIndex(), i, i);
    //发送count改变信号
    emit countChanged(count());
    userList.append(user);
    endInsertRows();
}

bool UserListModel::isUserInList(User user)
{
    foreach(User u, userList)
    {
//        qDebug()<<"ipadress: "<<u.getIpAddress()<<" "<<user.getIpAddress();
        if(u.getIpAddress() == user.getIpAddress())
            return true;
    }
    return false;
}

int UserListModel::count() const
{
    return userList.count();
}

void UserListModel::setCount(int newCount)
{
    if (m_count == newCount)
        return;
    m_count = newCount;
    emit countChanged(m_count);
}
