# Set An Adwaita Dark Style For GTK
mkdir -p ~/.config/gtk-3.0

echo -e '[Settings]\ngtk-application-prefer-dark-theme=1\ngtk-theme-name=Adwaita-dark\ngtk-icon-theme-name=Adwaita\ngtk-font-name=Noto Sans 10\ngtk-cursor-theme-name=Adwaita\ngtk-cursor-theme-size=0\ngtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ\ngtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR\ngtk-button-images=0\ngtk-menu-images=0\ngtk-enable-event-sounds=1\ngtk-enable-input-feedback-sounds=1\ngtk-xft-antialias=1\ngtk-xft-hinting=1\ngtk-xft-hintstyle=hintmedium\ngtk-xft-rgba=none\ngtk-modules=gail:atk-bridge' >> ~/.config/gtk-3.0/settings.ini

# Set An Adwaita Dark Style For Qt
mkdir ~/.config/qt5ct

echo -e '[Appearance]\ncolor_scheme_path=/usr/share/qt5ct/colors/airy.conf\ncustom_palette=false\nicon_theme=Adwaita\nstandard_dialogs=default\nstyle=Adwaita-Dark\n\n[Fonts]\nfixed=@Variant(\\0\\0\\0@\\0\\0\\0\\x12\\0M\\0o\\0n\\0o\\0s\\0p\\0\\x61\\0\\x63\\0\\x65@$\\0\\0\\0\\0\\0\\0\\xff\\xff\\xff\\xff\\x5\\x1\\0\\x32\\x10)\ngeneral=@Variant(\\0\\0\\0@\\0\\0\\0\\x12\\0N\\0o\\0t\\0o\\0 \\0S\\0\\x61\\0n\\0s@$\\0\\0\\0\\0\\0\\0\\xff\\xff\\xff\\xff\\x5\\x1\\0\\x32\\x10)\n\n[Interface]\nactivate_item_on_single_click=1\nbuttonbox_layout=0\ncursor_flash_time=1000\ndialog_buttons_have_icons=1\ndouble_click_interval=400\ngui_effects=@Invalid()\nkeyboard_scheme=2\nmenus_have_icons=true\nshow_shortcuts_in_context_menus=true\nstylesheets=@Invalid()\ntoolbutton_style=4\nunderline_shortcut=1\nwheel_scroll_lines=3\n\n[SettingsWindow]\ngeometry=@ByteArray(\\x1\\xd9\\xd0\\xcb\\0\\x3\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\x2\\x7f\\0\\0\\x3\\x1f\\0\\0\\0\\x1\\0\\0\\0\\x1\\0\\0\\x2~\\0\\0\\x3\\x1e\\0\\0\\0\\0\\0\\0\\0\\0\\x5\\0\\0\\0\\0\\x1\\0\\0\\0\\x1\\0\\0\\x2~\\0\\0\\x3\\x1e)\n\n[Troubleshooting]\nforce_raster_widgets=1\nignored_applications=@Invalid()' >> ~/.config/qt5ct/qt5ct.conf

echo -e "\nexport QT_QPA_PLATFORMTHEME=qt5ct" >> ~/.xinitrc