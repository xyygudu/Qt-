#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "userlistmodel.h"
#include "server.h"
#include "maincontrol.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<UserListModel>("UserListModel", 1, 0, "UserListModel");
    MainControl * mainControl = new MainControl();

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("MainControl", mainControl);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
