{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flameshot = {
            enable = true;
            settings = {
                General = {
                    contrastOpacity = 188;
                    disabledTrayIcon = false;
                    drawColor = "#800000";
                    drawThickness = 7;
                    ignoreUpdateToVersion = "12.1.0";
                    savePath = "/home/${config.ethorbit.users.primary.username}/Pictures";
                    showStartupLaunchMessage = true;
                };

                Shortcuts = {
                    TYPE_ARROW = "A";
                    TYPE_CIRCLE = "C";
                    TYPE_CIRCLECOUNT = "";
                    TYPE_COMMIT_CURRENT_TOOL = "Ctrl+Return";
                    TYPE_COPY = "Ctrl+C";
                    TYPE_DELETE_CURRENT_TOOL = "Del";
                    TYPE_DRAWER = "D";
                    TYPE_EXIT = "Ctrl+Q";
                    TYPE_IMAGEUPLOADER = "Return";
                    TYPE_MARKER = "M";
                    TYPE_MOVESELECTION = "Ctrl+M";
                    TYPE_MOVE_DOWN = "Down";
                    TYPE_MOVE_LEFT = "Left";
                    TYPE_MOVE_RIGHT = "Right";
                    TYPE_MOVE_UP = "Up";
                    TYPE_OPEN_APP = "Ctrl+O";
                    TYPE_PENCIL = "P";
                    TYPE_PIN = "";
                    TYPE_PIXELATE = "B";
                    TYPE_RECTANGLE = "R";
                    TYPE_REDO = "Ctrl+Shift+Z";
                    TYPE_RESIZE_DOWN = "Shift+Down";
                    TYPE_RESIZE_LEFT = "Shift+Left";
                    TYPE_RESIZE_RIGHT = "Shift+Right";
                    TYPE_RESIZE_UP = "Shift+Up";
                    TYPE_SAVE = "Ctrl+S";
                    TYPE_SELECTION = "S";
                    TYPE_SELECTIONINDICATOR = "";
                    TYPE_SELECT_ALL = "Ctrl+A";
                    TYPE_TEXT = "T";
                    TYPE_TOGGLE_PANEL = "Space";
                    TYPE_UNDO = "Ctrl+Z";
                };
            };
        };
    };
}
