#ifndef USERLISTMODEL_H
#define USERLISTMODEL_H
#include "user.h"

#include <QAbstractListModel>

class UserListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count WRITE setCount NOTIFY countChanged)  //qml可以根据count获取用户数量

public:
    enum{
        Headimage = Qt::UserRole,
        IpAdress,
        Name
    };

public:

    explicit UserListModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    //根据角色的不同返回不同的值
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    //为用户的信息设置别名，这样qml就可以直接通过model.name来获得user的name属性
    virtual QHash<int, QByteArray> roleNames() const override;

    //以下3个函数可以在qml中调用，对userList进行增删
    Q_INVOKABLE void insert(int index, const User &user);
    Q_INVOKABLE void remove(int index);
    Q_INVOKABLE void append(const User &user);

    //判断用户是否在列表中
    bool isUserInList(User user);

    int count() const;
public slots:
    void setCount(int newCount);

signals:
    void countChanged(int count);

private:
    QList<User> userList;
    int m_count;            //记录用户的数目，

};

#endif // USERLISTMODEL_H
