TEMPLATE = app
TARGET = GalaxyCalculator

QT += qml quick quickcontrols2

SOURCES += main.cpp tablemodel.cpp
HEADERS += tablemodel.h

RESOURCES += qml.qrc

EXAMPLE_FILES += doc

macos:QMAKE_INFO_PLIST = macos/Info.plist
ios:QMAKE_INFO_PLIST = ios/Info.plist

win32 {
# C:\Program Files\Windows Kits\10
# C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0\Redist\Debug
    INCLUDEPATH += "C:\\Program Files (x86)\Microsoft SDKs\\Windows Kits\\10\\ExtensionSDKs\\10.0.18362.0\\Redist\\Debug\\x64\\"
    LIBS += -L"C:\\Program Files (x86)\Microsoft SDKs\\Windows Kits\\10\\ExtensionSDKs\\10.0.18362.0\\Redist\\Debug\\x64\\"
}

target.path = /usr/local/GalaxyCalculator
INSTALLS += target

INCLUDEPATH += tmp/moc/release_shared

DISTFILES += macos/Info.plist \
  README.txt \
  qml/BigMath.js \
  qml/BigNumber.js \
  qml/BigNumberMath.js \
  qml/Calculator.qml \
  qml/Common.js \
  qml/Configuration.qml \
  qml/Database.js \
  qml/EnergyCalculator.js \
  qml/EnergyCalculator.qml \
  qml/Eval.js \
  qml/GalaxyCalculateIt.js \
  qml/GalaxyCalculator.qml \
  qml/Help.qml \
  qml/LoadProgressStyle.qml \
  qml/MadnessMeter.qml \
  qml/Main.qml \
  qml/Style.qml \
  qml/TextEditorColor.qml \
  qml/Themizer.qml \
  qml/WorldCalculator.js \
  qml/WorldCalculator.qml \
  qml/images/left-32.png \
  qml/images/refresh-32.png \
  qml/images/right-32.png \
  qml/images/stop-32.png

