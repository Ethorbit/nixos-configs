{ config, ... }:

{
    environment.variables = {
        # Bash support 
        # No duplicate entries, save & reload history after each command
        HISTCONTROL = "ignoredups:erasedups";
        PROMPT_COMMAND = "history -a; history -c; history -r; $PROMPT_COMMAND";
    };
}
