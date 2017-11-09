/*-
 * Copyright (c) 2017-2017 Damien Leroy <damien.leroy@outlook.fr>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * The Noise authors hereby grant permission for non-GPL compatible
 * GStreamer plugins to be used and distributed together with GStreamer
 * and Noise. This permission is above and beyond the permissions granted
 * by the GPL license by which Noise is covered. If you modify this code
 * you may extend this exception to your version of the code, but you are not
 * obligated to do so. If you do not wish to do so, delete this exception
 * statement from your version.
 *
 * Authored by: Damien Leroy <damien.leroy@outlook.fr>
 */

namespace VirtualboxManager {
    public class MainWindow : Gtk.Window {
        VirtualboxManager.Settings settings;

        //CONTROLS
        Gtk.HeaderBar headerbar;
        Gtk.Spinner spinner;
        Gtk.SearchEntry search_entry;
        
        Gtk.StackSwitcher switcher;
        Gtk.Stack content;
        VirtualboxManager.Views.NoVboxView novbox_view;
        VirtualboxManager.Views.AllVmsView all_view;
        VirtualboxManager.Views.RunningVmsView running_view;
        
        Notification desktop_notification;

        bool send_desktop_notification = true;

        construct {
            settings = VirtualboxManager.Settings.get_default ();

        }

        public MainWindow () {
            if (settings.window_maximized) {
                this.maximize ();
                this.set_default_size (1024, 720);
            } else {
                this.set_default_size (settings.window_width, settings.window_height);
            }
            this.window_position = Gtk.WindowPosition.CENTER;
            build_ui ();

            this.configure_event.connect ((event) => {
                settings.window_width = event.width;
                settings.window_height = event.height;
                return false;
            });

            this.destroy.connect (() => {
                settings.window_maximized = this.is_maximized;
            });
        }

        public void build_ui () {
            // CONTENT
            content = new Gtk.Stack ();

            headerbar = new Gtk.HeaderBar ();
            headerbar.title = _("Virtualbox Vms Manager");
            headerbar.show_close_button = true;
            this.set_titlebar (headerbar);

            // SETTINGS MENU
            var app_menu = new Gtk.MenuButton ();
            app_menu.set_image (new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR));

            var settings_menu = new Gtk.Menu ();

            var menu_item_preferences = new Gtk.MenuItem.with_label (_("Preferences"));
            menu_item_preferences.activate.connect (() => {
                var preferences = new Dialogs.Preferences (this);
                preferences.run ();
            });

            settings_menu.append (menu_item_preferences);
            settings_menu.show_all ();

            app_menu.popup = settings_menu;
            headerbar.pack_end (app_menu);

            if (VirtualboxManager.Utils.VboxCommands.getVersion() != null) {
                // STACK SWTCIHER
                switcher = new Gtk.StackSwitcher();
                switcher.set_stack(content);
                headerbar.pack_start(switcher);

                // SEARCH ENTRY
                search_entry = new Gtk.SearchEntry ();
                search_entry.placeholder_text = _("Search vms");
                search_entry.margin_right = 5;
                search_entry.search_changed.connect (() => {
                });
                headerbar.pack_end (search_entry);

                // SPINNER
                spinner = new Gtk.Spinner ();
                headerbar.pack_end (spinner);

                all_view = new VirtualboxManager.Views.AllVmsView();
                content.add_titled (all_view, "all", _("All"));  

                running_view = new VirtualboxManager.Views.RunningVmsView();
                content.add_titled (running_view, "running", _("Running"));  

                this.add(content);
            }
            else {
                novbox_view = new VirtualboxManager.Views.NoVboxView();
                this.add (novbox_view);
            }

            this.show_all ();
        }

    }
}
