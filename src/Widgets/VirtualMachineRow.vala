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
namespace VirtualboxManager.Widgets { 
    public class VirtualMachineRow : Gtk.ListBoxRow {
        private VirtualboxManager.Classes.VirtualMachine vm {get; private set;}

        private Gtk.Box content;
        private Gtk.Label label_vm_uuid;

        construct {

        }
        
        public VirtualMachineRow(VirtualboxManager.Classes.VirtualMachine vm) {
            Object();
            this.vm = vm;
            build_ui();
        }

        public void build_ui () {
            content = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            content.margin = 6;
            content.spacing = 6;
            content.margin_top = content.margin_bottom = 6;
            content.halign = Gtk.Align.FILL;
        
            label_vm_uuid = new Gtk.Label(vm.uuid);
            content.pack_start(label_vm_uuid, true, true, 0);

            this.halign = Gtk.Align.FILL;
        }            
    }
}