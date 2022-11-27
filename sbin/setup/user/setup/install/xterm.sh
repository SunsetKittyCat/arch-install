# Enable 256 Color Support, Force UTF-8, Fix Backspace Key, Save 4096 Lines, Enable Copy/Paste Behavior Through Ctrl+Shift+C/Ctrl+Shift+V, Enable Enabling Secure Keyboard Mode Through Ctrl+Alt+S, Set The Foreground Text Color To White And The Background Color To Black
echo -e '*.termName: xterm-256color\n\n*.vt100.locale: false\n*.vt100.utf8: true\n\n*.vt100.backarrowKey: false\n*.ttyModes: erase ^?\n\n*.vt100.saveLines: 4096\n\nXTerm.vt100.translations: #override \\n\\\nCtrl Shift <Key>C: copy-selection(CLIPBOARD) \\n\\\nCtrl Shift <Key>V: insert-selection(CLIPBOARD) \\n\\\nCtrl Alt <Key>S: secure()\n\n*.vt100.foreground: white\n*.vt100.background: black' > ~/.Xresources

# Update Xresources
xrdb -merge ~/.Xresources