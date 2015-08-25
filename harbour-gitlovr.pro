# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-gitlovr

CONFIG += sailfishapp

SOURCES += src/harbour-gitlovr.cpp

OTHER_FILES += qml/harbour-gitlovr.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-gitlovr.changes.in \
    rpm/harbour-gitlovr.spec \
    rpm/harbour-gitlovr.yaml \
    translations/*.ts \
    harbour-gitlovr.desktop \
    qml/Api.js \
    qml/Helper.js \
    qml/urlParams.js \
    qml/pages/AuthPage.qml \
    qml/pages/IssueDetails.qml \
    qml/pages/IssuesPage.qml \
    qml/pages/RepoOverview.qml \
    qml/pages/StartPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-gitlovr-de.ts

