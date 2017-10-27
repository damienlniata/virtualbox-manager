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

 namespace VirtualboxManager.Utils { 
     public class VboxCommands {
         private const string VBOXMANAGE = "vboxmanage";
         private const string VBOXMANAGE_OPTION_VERSION = "--version";

         private const string VBOXMANAGE_COMMAND_LIST = "list";
         private const string VBOXMANAGE_COMMAND_LIST_RUNNINGVMS = "runningvms";
         
         

         public static string? getVersion() {
            string stdout;
            string stderr;
            int status;
            
            try {
                info(@"Runnning command : $VBOXMANAGE $VBOXMANAGE_OPTION_VERSION");
                Process.spawn_command_line_sync(@"$VBOXMANAGE $VBOXMANAGE_OPTION_VERSION", out stdout, out stderr, out status);
                return stdout;
            }
            catch (SpawnError e) {
                debug(e.message);
                return null;
            }
         }
        
        public static List<VirtualboxManager.Classes.VirtualMachine> getRunningVms() {
            string stdout;
            string stderr;
            int status;
            List<VirtualboxManager.Classes.VirtualMachine> retour = new List<VirtualboxManager.Classes.VirtualMachine>();

            try {
                info(@"Runnning command : $VBOXMANAGE $VBOXMANAGE_COMMAND_LIST $VBOXMANAGE_COMMAND_LIST_RUNNINGVMS");
                Process.spawn_command_line_sync(@"$VBOXMANAGE $VBOXMANAGE_COMMAND_LIST $VBOXMANAGE_COMMAND_LIST_RUNNINGVMS", out stdout, out stderr, out status);
                debug(@"Commmand stdout : $stdout");
                GLib.Regex regex = /{(.*)}/;
                GLib.MatchInfo mInfo;

                for (regex.match (stdout, 0, out mInfo) ; mInfo.matches () ; mInfo.next ()) {
                    string vm_uuid = mInfo.fetch(1);
                    info(@"Found running vm : $vm_uuid");
                    retour.append(new VirtualboxManager.Classes.VirtualMachine(vm_uuid));
                }
        
            }
            catch (Error e) {
                debug(e.message);
            }

            return retour;
        }
     }
 }