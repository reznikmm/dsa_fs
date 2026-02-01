package body API is

   function Hello_World (Text : String) return String is
   begin
      return "Hello, " & Text;
   end Hello_World;

end API;
