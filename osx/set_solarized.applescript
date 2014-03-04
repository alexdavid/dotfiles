-- Modified version of Jay Williams iterm2-colors-solarized-toggle
-- https://github.com/jaywilliams/iterm2-colors-solarized-toggle

-- Apple script colors are specified in RGB,
-- with ranges from 0 to 65535.

on is_running(appName)
    tell application "System Events" to (name of processes) contains appName
end is_running


set colorscheme to (read file ((path to home folder as Unicode text) & ".config:colors"))
if colorscheme is "light\n" then
  -- Solarized Light Theme
  set solarized_foreground to "{21074, 26471, 28270}"
  set solarized_background to "{64842, 62778, 56626}"
  set solarized_bold to "{18134, 23373, 25098}"
  set solarized_selection to "{60138, 58339, 52171}"
  set solarized_selected_text to "{18134, 23373, 25098}"
  set solarized_cursor to "{21257, 26684, 28737}"
  set solarized_cursor_text to "{60037, 58326, 52284}"
else
  -- Solarized Dark Theme
  set solarized_foreground to "{28873, 33398, 33872}"
  set solarized_background to "{0, 7722, 9941}"
  set solarized_bold to "{33153, 37008, 37008}"
  set solarized_selection to "{0, 10280, 12593}"
  set solarized_selected_text to "{33153, 37008, 37008}"
  set solarized_cursor to "{28784, 33410, 33924}"
  set solarized_cursor_text to "{0, 10207, 12694}"
end if


-- Terminal
if is_running("Terminal")
  run script "
    tell application \"Terminal\"
      tell selected tab of front window
        set normal text color to " & solarized_foreground & "
        set background color to "  & solarized_background &"
        set bold text color to "   & solarized_bold       &"
        set cursor color to "      & solarized_cursor     &"
      end tell
    end tell
  "
end if


-- iTerm
if is_running("iTerm")
  run script "
    tell application \"iTerm\"
      tell current session of current terminal
        set foreground color to "    & solarized_foreground    & "
        set background color to "    & solarized_background    & "
        set bold color to "          & solarized_bold          & "
        set selection color to "     & solarized_selection     & "
        set selected text color to " & solarized_selected_text & "
        set cursor color to "        & solarized_cursor        & "
        set cursor_text color to "   & solarized_cursor_text   & "
      end tell
    end tell
  "
end if
