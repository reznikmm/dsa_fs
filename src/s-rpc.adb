------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                           S Y S T E M . R P C                            --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1992-2025, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

with Ada.Text_IO;

package body System.RPC is

   procedure Dump_Stream (Stream : Params_Stream_Type);
   procedure Read_Stream (Stream : in out Params_Stream_Type);

   ------------
   -- Do_RPC --
   ------------

   procedure Do_RPC
     (Partition : Partition_ID;
      Params    : access Params_Stream_Type;
      Result    : access Params_Stream_Type)
   is
      procedure Skip (Value : Character);

      procedure Skip (Value : Character) is
         Next : Character := '#';
      begin
         while Next /= Value loop
            Ada.Text_IO.Get (Next);
         end loop;
      end Skip;
   begin
      Ada.Text_IO.Put_Line ("Do_RPC. Partition:" & Partition'Image);
      Ada.Text_IO.Put ("Params: ");
      Dump_Stream (Params.all);
      Skip (':');
      Read_Stream (Result.all);
   end Do_RPC;

   ------------
   -- Do_APC --
   ------------

   procedure Do_APC
     (Partition : Partition_ID;
      Params    : access Params_Stream_Type)
   is
   begin
      raise Program_Error;
   end Do_APC;

   -----------------
   -- Dump_Stream --
   -----------------

   procedure Dump_Stream (Stream : Params_Stream_Type) is
      use type Ada.Streams.Stream_Element;

      Image : constant array (Ada.Streams.Stream_Element range 0 .. 15)
        of Character :=
          ("0123456789abcdef");
      function Hex (Item : Ada.Streams.Stream_Element) return String is
        (Image (Item / 16) & Image (Item mod 16));

   begin
      for Item of Stream.Buffer (1 .. Stream.To) loop
         Ada.Text_IO.Put (Hex (Item));
      end loop;
      Ada.Text_IO.Put_Line (".");
   end Dump_Stream;

   ----------------------------
   -- Establish_RPC_Receiver --
   ----------------------------

   procedure Establish_RPC_Receiver
     (Partition : Partition_ID;
      Receiver  : RPC_Receiver)
   is
      pragma Unreferenced (Partition, Receiver);
   begin
      null;
   end Establish_RPC_Receiver;

   ----------
   -- Read --
   ----------

   procedure Read
     (Stream : in out Params_Stream_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      use type Ada.Streams.Stream_Element_Offset;
      Length : constant Ada.Streams.Stream_Element_Offset :=
        Ada.Streams.Stream_Element_Offset'Min
          (Item'Length,
           Stream.To - Stream.From + 1);
   begin
      Last := Item'First + Length - 1;
      Item (Item'First .. Last) :=
        Stream.Buffer (Stream.From .. Stream.From + Length - 1);
      Stream.From := Stream.From + Length;
   end Read;

   -----------------
   -- Read_Stream --
   -----------------

   procedure Read_Stream (Stream : in out Params_Stream_Type) is
      use type Ada.Streams.Stream_Element;
      Item  : Ada.Streams.Stream_Element := 0;
      Next  : Character := ' ';
      First : Boolean := True;
   begin
      while Next /= '.' loop
         Ada.Text_IO.Get (Next);
         if Next in '0' .. '9' | 'a' .. 'f' then
            Item := Item * 16 + Character'Pos (Next) +
              (if Next in '0' .. '9'
               then -Character'Pos ('0')
               else 10 - Character'Pos ('a'));

            if not First then
               Write (Stream, (1 => Item));
            end if;

            First := not First;
         end if;
      end loop;
   end Read_Stream;

   -----------
   -- Write --
   -----------

   procedure Write
     (Stream : in out Params_Stream_Type;
      Item   : Ada.Streams.Stream_Element_Array)
   is
      use type Ada.Streams.Stream_Element_Offset;
   begin
      Stream.Buffer (Stream.To + 1 .. Stream.To + Item'Length) := Item;
      Stream.To := Stream.To + Item'Length;
   end Write;

end System.RPC;
