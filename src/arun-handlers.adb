---
-- Basic GtkAda handlers for Arun
---
------------------------------------------------------------------------------
--
--  Copyright (C) 2017 R. Tyler Croy <tyler@linux.com>
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
------------------------------------------------------------------------------

with Ada.Text_IO;
with GNAT.OS_Lib;
with Gtk.Main;
with Gtk.Widget;
with Gtk.Search_Entry;
with Gtkada.Builder; use Gtkada.Builder;

with Arun.Launcher;

package body Arun.Handlers is

   procedure Quit (Object : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Object);
   begin
      Ada.Text_IO.Put_Line ("Exiting arun");
      Gtk.Main.Main_Quit;
   end Quit;

   procedure Search_Changed (Object : access Gtkada_Builder_Record'Class) is
      use Ada.Text_IO;
      use Gtk.Search_Entry;
      use Gtkada.Builder;

      Widget : Gtk_Search_Entry := Gtk_Search_Entry (Get_Object (Object, "commandEntry"));
   begin
      Put_Line ("Searching for " & Widget.Get_Text);
   end Search_Changed;


   procedure Execute_Command (Object : access Gtkada_Builder_Record'Class) is
      use Ada.Text_IO;
      use Gtk.Search_Entry;
      use Gtkada.Builder;

      Widget : Gtk_Search_Entry := Gtk_Search_Entry (Get_Object (Object, "commandEntry"));
      Command : constant String := Widget.Get_Text;

      Full_Path :  aliased constant String := Arun.Launcher.Find_Full_Path (Command);
   begin

      if Full_Path /= "" then
         Put_Line ("Should Execute: " & Command);
         Arun.Launcher.Execute (Full_Path);
      end if;

      Gtk.Main.Main_Quit;
   end Execute_Command;

end Arun.Handlers;
