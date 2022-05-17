#ifndef USER_H
#define USER_H

#include <QObject>
#include <QDataStream>

//存储和用户相关的数据
class User //不知道为什么，这个存放数据的类不能继承自QObject,否则就会出错
{

public:
    User();
    User(const User &user);
    User(QString headImage, QString ipAddress, QString name);

    const QString &getHeadImage() const;
    void setHeadImage(const QString &newHeadImage);

    const QString &getIpAddress() const;
    void setIpAddress(const QString &newIpAddress);

    const QString &getName() const;
    void setName(const QString &newName);

    User operator = (const User &user); //=必须以成员函数的形式重载
    friend QDataStream &operator << (QDataStream& out,const User& user);
    friend QDataStream &operator >> (QDataStream& in, User& user);


signals:

private:
    QString headImage;      //用户的图像
    QString ipAddress;      //ip地址
    QString name;           //昵称

};

/*
 * 参考：https://blog.csdn.net/qq_44861675/article/details/105126559
 *      http://c.biancheng.net/view/2311.html
 * 流运算符必须用全局方式重载，因为要访问类的私有变量，所以需要声明为友元
 * 重载运算符，以便QDataStream可以直接in或者out自定义的数据类型
*/

#ifndef QT_NO_DATASTREAM
QDataStream &operator << (QDataStream& out,const User& user);
QDataStream &operator >> (QDataStream& in, User& user);


#endif
#endif // USER_H
