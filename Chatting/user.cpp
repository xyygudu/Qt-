#include "user.h"

User::User()
{

}

User::User(const User &user)
{
    this->headImage = user.headImage;
    this->ipAddress = user.ipAddress;
    this->name = user.name;
}

User::User(QString headImage, QString ipAddress, QString name)
    :headImage(headImage), ipAddress(ipAddress), name(name)
{

}

const QString &User::getName() const
{
    return name;
}

void User::setName(const QString &newName)
{
    name = newName;
}

const QString &User::getIpAddress() const
{
    return ipAddress;
}

void User::setIpAddress(const QString &newIpAddress)
{
    ipAddress = newIpAddress;
}

const QString &User::getHeadImage() const
{
    return headImage;
}

void User::setHeadImage(const QString &newHeadImage)
{
    headImage = newHeadImage;
}

/*
 * 重载运算符，以便QDataStream可以直接in或者out自定义的数据类型
*/
QDataStream &operator << (QDataStream& out,const User& user)
{
    out << user.headImage
        << user.ipAddress
        << user.name;
    return out;
}
QDataStream &operator >> (QDataStream& in, User& user)
{
    in >> user.headImage
       >> user.ipAddress
       >> user.name;
    return in;
}
