with Ada.Text_IO;

with API;

procedure Client is
   Text : constant String := API.Hello_World ("World");
begin
   Ada.Text_IO.Put_Line (Text);
end Client;
