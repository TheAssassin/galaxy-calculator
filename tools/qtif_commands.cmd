if exist C:\projects\ (
    echo "Path C:\projects exist"
    xcopy /f C:\projects\%APPVEYOR_BUILD_FOLDER%-build\deploy\ %APPVEYOR_BUILD_FOLDER%\packages\com.lightwizzard.galaxycalculator\data\
    C:\Qt\QtIFW3.1.1\bin\binarycreator.exe --offline-only -c %APPVEYOR_BUILD_FOLDER%\config\config.xml -p %APPVEYOR_BUILD_FOLDER%\packages GalaxyCalculatorInstaller.exe
) else (
    echo "Path C:\projects does not exist"
)
