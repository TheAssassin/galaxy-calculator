/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the FOO module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    // call default implementation to actually install GalaxyCalculator.exe!
    component.createOperations();

    if (systemInfo.productType === "windows") 
    {
        component.addOperation("CreateShortcut", "@TargetDir@/Galaxy-Calculator.exe", "@StartMenuDir@/Galaxy-Calculator.lnk",
            "workingDirectory=@TargetDir@", "iconPath=%SystemRoot%/system32/SHELL32.dll",
            "iconId=2", "description=Galaxy Calculator by the Light Wizzard");
    }
    /*
    if (installer.value("os") === "x11")
    {
	    component.addOperation( "InstallIcons", "@TargetDir@/icons" );
        component.addOperation("CreateDesktopEntry", "@TargetDir@/Galaxy-Calculator.desktop", "Version=1.0\nType=Application\nTerminal=false\nExec=@TargetDir@usr/bin/Galaxy-Calculator.AppImage\nName=Galaxy-Calculator\nIcon=@TargetDir@/Galaxy-Calculator.png\nName[en_US]=Galaxy-Calculator.desktop");
        component.addElevatedOperation("Copy", "@TargetDir@/Galaxy-Calculator.desktop", "@HomeDir@/Desktop/Galaxy-Calculator.desktop");
    } 
    */   
    // linux, darwin, winnt
    if (systemInfo.kernelType === "linux")
    {
	    component.addOperation( "InstallIcons", "@TargetDir@/icons" );
        component.addOperation("CreateDesktopEntry", "@TargetDir@/Galaxy-Calculator.desktop", "Version=1.0\nType=Application\nTerminal=false\nExec=@TargetDir@/Galaxy-Calculator.AppImage\nName=Galaxy-Calculator\nIcon=@TargetDir@/icons\nName[en_US]=Galaxy-Calculator.desktop");
        component.addElevatedOperation("Copy", "@TargetDir@/Galaxy-Calculator.desktop", "@HomeDir@/Desktop/Galaxy-Calculator.desktop");
    }

}
// End of File
