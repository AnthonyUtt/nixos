{ pkgs, ... }: {
  home.packages = [ pkgs.albert ];

  xdg.configFile."albert/albert.conf".text = ''
    [General]
    frontendId=org.albert.frontend.widgetboxmodel
    hotkey=Meta+Space
    showTray=false

    [org.albert.extension.applications]
    enabled=true

    [org.albert.extension.calculator]
    enabled=true

    [org.albert.extension.files]
    enabled=true

    [org.albert.extension.hashgenerator]
    enabled=true

    [org.albert.extension.python]
    enabled=true
    enabled_modules=arch_wiki, aur

    [org.albert.extension.system]
    enabled=true

    [org.albert.extension.terminal]
    enabled=true

    [org.albert.extension.websearch]
    enabled=true

    [org.albert.frontend.qmlboxmodel]
    alwaysOnTop=true
    clearOnHide=false
    hideOnClose=false
    hideOnFocusLoss=true
    showCentered=true
    stylePath=/usr/share/albert/org.albert.frontend.qmlboxmodel/styles/BoxModel/MainComponent.qml
    windowPosition=@Point(2209 463)

    [org.albert.frontend.widgetboxmodel]
    alwaysOnTop=true
    clearOnHide=false
    displayIcons=true
    displayScrollbar=true
    displayShadow=true
    hideOnClose=false
    hideOnFocusLoss=true
    itemCount=5
    showCentered=true
    theme=Arc Dark Blue
  '';
}
