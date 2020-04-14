TEMPLATE = app
TARGET = Galaxy-Calculator

QT += qml quick quickcontrols2

SOURCES += src/main.cpp src/tablemodel.cpp
HEADERS += src/tablemodel.h

RESOURCES += resources.qrc

EXAMPLE_FILES += doc

macos:QMAKE_INFO_PLIST = macos/Info.plist
ios:QMAKE_INFO_PLIST = ios/Info.plist

target.path = /usr/local/GalaxyCalculator
INSTALLS += target

INCLUDEPATH += tmp/moc/release_shared

# QMAKE_LFLAGS += -static

DISTFILES += macos/Info.plist \
  .appveyor.yml \
  .gitignore \
  .travis.yml \
  CMakeLists.txt \
  README.md \
  config/config.xml \
  deploy/qt-installer-noninteractive.qs \
  deploy/upload.sh \
  packages/com.lightwizzard.galaxycalculator/data/README.txt \
  packages/com.lightwizzard.galaxycalculator/meta/installscript.qs \
  packages/com.lightwizzard.galaxycalculator/meta/package.xml \
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
  bash/makeappendix.a.sh bash/makeappendix.a.zip \
  usr/share/applications/Galaxy-Calculator.desktop \
  usr/share/applications/Galaxy-Calculator.ico \
  usr/share/applications/Galaxy-Calculator.png

win32{
	#enter your Windows definitions here ...
}

unix{
	macx {
		# Mac OS X definitions should be entered here ...
	}
	 else {
		# Linux definitions go here ...
	}
}

#test { # the following files will be included for Unit test build
#    message(Test build)

#    QT += testlib #needed for QtTest
#    SOURCES -= main.cpp

##    HEADERS += Test/UnitTest.h
##    SOURCES += Test/main.cpp Test/UnitTest.cpp
#}
################################# End of File #################################
