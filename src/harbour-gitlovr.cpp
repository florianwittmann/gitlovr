#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>


int main(int argc, char *argv[])
{
    QGuiApplication* app = SailfishApp::application(argc, argv);

    QScopedPointer <QQuickView> view(SailfishApp::createView());
    app->setApplicationName("harbour-gitlovr");
    app->setOrganizationDomain("harbour-gitlovr");
    app->setOrganizationName("harbour-gitlovr");

    view->setTitle("GitLovr");

    // If you compile your own version of GitLovr, you need a clientid from Github.
    // To change a auth code into a token, you can either change the code to request it directly,
    // or create some small authserver and do the code to token process there.
    view->rootContext()->setContextProperty("clientid", "");
    view->rootContext()->setContextProperty("authhash", "");
    view->rootContext()->setContextProperty("authurl", "");

    QUrl pageSource = SailfishApp::pathTo("qml/harbour-gitlovr.qml");
    view->setSource(pageSource);


    view->showFullScreen();

    return app->exec();
}

