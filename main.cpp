#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtQml/QQmlExtensionPlugin>
Q_IMPORT_QML_PLUGIN(TimePickerPlugin)

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TimePickerApp", "Main");

    return app.exec();
}
