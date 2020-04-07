TEMPLATE = app
TARGET = GalaxyCalculator

QT += qml quick quickcontrols2

SOURCES += main.cpp tablemodel.cpp
HEADERS += tablemodel.h

RESOURCES += qml.qrc

EXAMPLE_FILES += doc

macos:QMAKE_INFO_PLIST = macos/Info.plist
ios:QMAKE_INFO_PLIST = ios/Info.plist

CONFIG += static
QMAKE_LFLAGS += -static -static-libgcc
LFLAGS = -static -static-libgcc
# -qt-zlib -qt-pcre

# x86 32
#INCLUDEPATH += "C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0\Redist\Debug\x86"
#INCLUDEPATH += "C:\Qt\5.12.7\mingw73_32\include"
#INCLUDEPATH += "C:\Qt\5.12.7\mingw73_32\bin"
#INCLUDEPATH += "C:\Qt\Tools\mingw730_32\bin"
#LIBS += -L"C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0\Redist\Debug\x86"
#LIBS += -L"C:\Qt\5.12.7\mingw73_32\bin" -L"C:\Qt\Tools\mingw730_32\bin"
#LIBS += -L"C:\Qt\5.12.7\mingw73_32\lib"

#INCLUDEPATH += "C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0\Redist\Debug\x86"
#INCLUDEPATH += "C:\Qt\5.14.2\mingw73_32\include"
#INCLUDEPATH += "C:\Qt\5.14.2\mingw73_32\bin"
#INCLUDEPATH += "C:\Qt\Tools\mingw730_32\bin"
#LIBS += -L"C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0\Redist\Debug\x86"
#LIBS += -L"C:\Qt\5.14.2\mingw73_32\lib"
#LIBS += -L"C:\Qt\5.14.2\mingw73_32\bin"
#LIBS += -L"C:\Qt\Tools\mingw730_32\bin"

# x64
#INCLUDEPATH += "C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0\Redist\Debug\x64"
#INCLUDEPATH += "C:\Qt\5.14.2\mingw73_64\include"
#LIBS += -L"C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.UniversalCRT.Debug\10.0.18362.0\Redist\Debug\x64"
#LIBS += -L"C:\Qt\Tools\mingw730_64\bin" -L"C:\Qt\5.14.2\mingw73_64\bin"
#LIBS += -L"C:\Qt\5.14.2\mingw73_64\lib"

win32 {
    # C:\Program Files\Windows Kits\10
    # INCLUDEPATH += "C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\10.0.18362.0\Redist\Debug\x64\"
    # LIBS += -L"C:\Program Files (x86)\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\10.0.18362.0\Redist\Debug\x64\" -L"C:\Qt\Tools\mingw730_64\bin"
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
  qml/EnergyCalculator.js \
  qml/EnergyCalculator.qml \
  qml/Eval.js \
  qml/GalaxyCalculateIt.js \
  qml/GalaxyCalculator.qml \
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

# end of file
