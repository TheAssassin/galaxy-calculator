/****************************************************************************
** Galaxy Calculator by the Light Wizzard in the Flesh
** Jeffrey Scott Flesher
****************************************************************************/

#include <QtCore/QUrl>
#include <QtCore/QCommandLineOption>
#include <QtCore/QCommandLineParser>
#include <QGuiApplication>
#include <QStyleHints>
#include <QScreen>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QQuickStyle>
#include <QFileInfo>
#include <QIcon>
#include "tablemodel.h"

// Workaround: As of Qt 5.4 QtQuick does not expose QUrl::fromUserInput.
class Utils : public QObject
{
    Q_OBJECT
public:
    Utils(QObject* parent = nullptr) : QObject(parent) { }
    Q_INVOKABLE static QUrl fromUserInput(const QString& userInput);
};

QUrl Utils::fromUserInput(const QString& userInput)
{
    if (userInput.isEmpty())
        return QUrl::fromUserInput("about:blank");
    const QUrl result = QUrl::fromUserInput(userInput);
    return result.isValid() ? result : QUrl::fromUserInput("about:blank");
}

#include "main.moc"

int main(int argc, char *argv[])
{
//! [0]
    QGuiApplication app(argc, argv);
    QFileInfo fi(app.applicationDirPath() + "/../share/pixmaps/Galaxy-Calculator.png");
    QGuiApplication::setWindowIcon(QIcon(fi.absoluteFilePath()));
    qmlRegisterType<TableModel>("TableModel", 0, 1, "TableModel");
//! [0]
    QGuiApplication::setApplicationDisplayName(QCoreApplication::translate("main", "Light Wizzard"));
    QCommandLineParser parser;
    QCoreApplication::setApplicationVersion(QT_VERSION_STR);
    parser.setApplicationDescription(QGuiApplication::applicationDisplayName());
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument("url", "The initial URL to open.");
    QStringList arguments = app.arguments();
    parser.process(arguments);
    const QString initialUrl = parser.positionalArguments().isEmpty() ?
        QStringLiteral("http://LightWizzard.com") : parser.positionalArguments().first();
    /*
     * https://doc.qt.io/qt-5/qquickstyle.html
     * QQuickStyle::setStyle(":/mystyle");
     * QQuickStyle::setFallbackStyle("Material");
     */
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty(QStringLiteral("utils"), new Utils(&engine));
    context->setContextProperty(QStringLiteral("initialUrl"), Utils::fromUserInput(initialUrl));
    QRect geometry = QGuiApplication::primaryScreen()->availableGeometry();
    if (!QGuiApplication::styleHints()->showIsFullScreen()) {
        const QSize size = geometry.size() * 4 / 5;
        const QSize offset = (geometry.size() - size) / 2;
        const QPoint pos = geometry.topLeft() + QPoint(offset.width(), offset.height());
        geometry = QRect(pos, size);
    }
    context->setContextProperty(QStringLiteral("initialX"), geometry.x());
    context->setContextProperty(QStringLiteral("initialY"), geometry.y());
    context->setContextProperty(QStringLiteral("initialWidth"), geometry.width());
    context->setContextProperty(QStringLiteral("initialHeight"), geometry.height());

    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));
    if (engine.rootObjects().isEmpty()) return -1;

    return app.exec();
}
/* ***************************** End of File ******************************* */
