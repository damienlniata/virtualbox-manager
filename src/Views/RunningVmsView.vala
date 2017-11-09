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

namespace VirtualboxManager.Views {
    public class RunningVmsView : Gtk.Box {
        private Gtk.ListBox vmlist;

        construct {
        }

        public RunningVmsView () {
            Object(orientation: Gtk.Orientation.VERTICAL, spacing: 0);
            this.vexpand = true;
            this.hexpand = true;

            build_ui ();
        }

        private void build_ui () {
                    
            vmlist = new Gtk.ListBox();
            vmlist.vexpand = true;
            vmlist.hexpand = true;

            var vms = VirtualboxManager.Utils.VboxCommands.getRunningVms();
            foreach (var item in vms) {
                var item_uuid = item.uuid;
                debug(@"Adding vm row : {$item_uuid}");
                VirtualboxManager.Widgets.VirtualMachineRow row = new VirtualboxManager.Widgets.VirtualMachineRow(item);
                vmlist.add(row);
            }

            var vm_scroll = new Gtk.ScrolledWindow (null, null);
            vm_scroll.expand = true;
            vm_scroll.add (vmlist);

            this.pack_start(vm_scroll, true, true, 0);
         }
    }
}