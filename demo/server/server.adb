with API;  --  To execute elaboration code of API
pragma Unreferenced (API);

with Ada.Streams;
with Ada.Text_IO;
with Interfaces;
with System.Partition_Interface;
with System.RPC;
with System.Storage_Elements;

procedure Server is

   --  Here we execute "server task", that reads communication channel and
   --  drives DSA to execute requests. In a real system this task belongs
   --  to DSA implementation and launched vie elaboration code, while user's
   --  main subprogram works on users defined code.

   procedure Read_Stream (Stream : in out System.RPC.Params_Stream_Type);
   procedure Dump_Stream (Stream : in out System.RPC.Params_Stream_Type);

   -----------------
   -- Read_Stream --
   -----------------

   procedure Read_Stream (Stream : in out System.RPC.Params_Stream_Type) is
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
               System.RPC.Write (Stream, (1 => Item));
            end if;

            First := not First;
         end if;
      end loop;
   end Read_Stream;

   -----------------
   -- Dump_Stream --
   -----------------

   procedure Dump_Stream (Stream : in out System.RPC.Params_Stream_Type) is
      use type Ada.Streams.Stream_Element;
      use type Ada.Streams.Stream_Element_Offset;

      Image : constant array (Ada.Streams.Stream_Element range 0 .. 15)
        of Character :=
          ("0123456789abcdef");
      function Hex (Item : Ada.Streams.Stream_Element) return String is
        (Image (Item / 16) & Image (Item mod 16));

      Buffer : Ada.Streams.Stream_Element_Array (1 .. 10);
      Last   : Ada.Streams.Stream_Element_Offset;
   begin
      loop
         Stream.Read (Buffer, Last);
         exit when Last < Buffer'First;

         for Item of Buffer (1 .. Last) loop
            Ada.Text_IO.Put (Hex (Item));
         end loop;
      end loop;

      Ada.Text_IO.Put_Line (".");
   end Dump_Stream;

begin
   declare
      Ignore : String := Ada.Text_IO.Get_Line;
      --  Skip "Do_RPC. Partition: X"
      Dummy  : String := "Params: ";
      --  Skip "Params: "
   begin
      Ada.Text_IO.Get (Dummy);
   end;

   declare
      Ignore : Interfaces.Unsigned_64;
      Params : aliased System.RPC.Params_Stream_Type (0);
      Result : aliased System.RPC.Params_Stream_Type (0);
      Int    : constant Interfaces.Unsigned_64 :=
        System.Partition_Interface.Get_RCI_Package_Receiver ("API");
      Addr   : constant System.Address :=
        System.Storage_Elements.To_Address
          (System.Storage_Elements.Integer_Address (Int));

      procedure Receiver (R : System.Partition_Interface.Request_Access)
        with Import, Address => Addr;
   begin
      Read_Stream (Params);

      Interfaces.Unsigned_64'Read (Params'Access, Ignore);
      --  Read and ignore RCI_Package_Receiver address, because we use
      --  hardcoded API receiver in this demo. In a real system it should
      --  be used (to find???) as Receiver address.

      Receiver
        ((Params => Params'Unchecked_Access,
          Result => Result'Unchecked_Access));

      Ada.Text_IO.Put ("Result: ");
      Dump_Stream (Result);
   end;
end Server;
