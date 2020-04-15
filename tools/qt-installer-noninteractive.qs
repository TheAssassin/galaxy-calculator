// Emacs mode hint: -*- mode: JavaScript -*-
// qt-opensource-linux-x64-5.5.1.run --script qt-installer-noninteractive.qs
// Next
function Controller() 
{
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() 
    {
        gui.clickButton(buttons.NextButton);
    })
}
// Next with delay Welcome Page
Controller.prototype.WelcomePageCallback = function() 
{
    // click delay here because the next button is initially disabled for ~1 second
    gui.clickButton(buttons.NextButton, 3000);
}
// Next Obligations Page 
Controller.prototype.ObligationsPageCallback = function() 
{
    var page = gui.pageWidgetByObjectName("ObligationsPage");
    page.obligationsAgreement.setChecked(true);
    page.completeChanged();
    gui.clickButton(buttons.NextButton);
}
// Next Credentials Page
Controller.prototype.CredentialsPageCallback = function() 
{
    gui.clickButton(buttons.NextButton);
}
// Next Introduction Page
Controller.prototype.IntroductionPageCallback = function() 
{
    gui.clickButton(buttons.NextButton);
}
// Next Target Directory Page
Controller.prototype.TargetDirectoryPageCallback = function()
{
    gui.currentPageWidget().TargetDirectoryLineEdit.setText(installer.value("HomeDir") + "/Qt");
    gui.clickButton(buttons.NextButton);
}
// Next Component Selection Page
Controller.prototype.ComponentSelectionPageCallback = function() 
{
    var widget = gui.currentPageWidget();

    widget.deselectAll();
    widget.selectComponent("qt.55.gcc_64");
    widget.selectComponent("qt.55.qtquickcontrols");

    // widget.deselectComponent("qt.tools.qtcreator");
    // widget.deselectComponent("qt.55.qt3d");
    // widget.deselectComponent("qt.55.qtcanvas3d");
    // widget.deselectComponent("qt.55.qtlocation");
    // widget.deselectComponent("qt.55.qtquick1");
    // widget.deselectComponent("qt.55.qtscript");
    // widget.deselectComponent("qt.55.qtwebengine");
    // widget.deselectComponent("qt.extras");
    // widget.deselectComponent("qt.tools.doc");
    // widget.deselectComponent("qt.tools.examples");

    gui.clickButton(buttons.NextButton);
}
// Next License Agreement Page
Controller.prototype.LicenseAgreementPageCallback = function() 
{
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}
// Next Start Menu Directory Page
Controller.prototype.StartMenuDirectoryPageCallback = function() 
{
    gui.clickButton(buttons.NextButton);
}
// Next Ready For Installation Page
Controller.prototype.ReadyForInstallationPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}
// Finish Page
Controller.prototype.FinishedPageCallback = function() 
{
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm;
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) 
    {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}
// ######################################### End of File ######################
