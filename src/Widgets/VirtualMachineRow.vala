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
    public class VirtualMachineRow : Gtk.Box {
        private VirtualboxManager.Classes.VirtualMachine vm {get; private set;}

        private Gtk.Label label_vm_uuid;
        private Gtk.Label label_vm_name;
        
        construct {

        }
        
        public VirtualMachineRow(VirtualboxManager.Classes.VirtualMachine vm) {
            Object(orientation: Gtk.Orientation.HORIZONTAL, spacing: 5);
            this.margin = 5;
            this.margin_top = this.margin_bottom = 5;
            this.halign = Gtk.Align.FILL;

            this.vm = vm;
            build_ui();
        }

        public void build_ui () {
            label_vm_uuid = new Gtk.Label(vm.uuid);
            this.pack_start(label_vm_uuid, true, true, 0);

            label_vm_name = new Gtk.Label(vm.name);
            this.add(label_vm_name);

            this.halign = Gtk.Align.FILL;
        }            
    }
}