TEMPLATE = app
TARGET = GalaxyCalculator

QT += qml quick quickcontrols2 webview

SOURCES += main.cpp tablemodel.cpp
HEADERS += tablemodel.h

RESOURCES += qml.qrc

EXAMPLE_FILES += doc

macos:QMAKE_INFO_PLIST = macos/Info.plist
ios:QMAKE_INFO_PLIST = ios/Info.plist

target.path = /usr/local/GalaxyCalculator
INSTALLS += target

INCLUDEPATH += tmp/moc/release_shared

# QMAKE_LFLAGS += -static

DISTFILES += macos/Info.plist \
  README.md \
  qml/BigNumber.js \
  qml/BigNumberMath.js \
  qml/Calculator.qml \
  qml/Common.js \
  qml/Configuration.qml \
  qml/EnergyCalculator.js \
  qml/EnergyCalculator.qml \
  qml/Eval.js \
  qml/GalaxyCalculateIt.js \
  qml/GalaxyCalculator.qml \
  qml/LoadProgressStyle.qml \
  qml/MadnessMeter.qml \
  qml/Main.qml \
  qml/PiCalculator.js \
  qml/PushButton.qml \
  qml/Style.qml \
  qml/TextEditorBox.qml \
  qml/TextEditorColor.qml \
  qml/WorldCalculator.js \
  qml/WorldCalculator.qml \
  qml/images/left-32.png \
  qml/images/refresh-32.png \
  qml/images/right-32.png \
  qml/images/stop-32.png\
  bash/makeappendix.a.sh bash/makeappendix.a.zip

test { # the following files will be included for Unit test build
    message(Test build)

    QT += testlib #needed for QtTest
    SOURCES -= main.cpp

#    HEADERS += Test/UnitTest.h
#    SOURCES += Test/main.cpp Test/UnitTest.cpp

} else {
    message(Normal build) #we will just show this message for Debug/Release build
}
################################# End of File #################################
