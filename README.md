#  Ada Distribution System Annex from scratch

This repository contains example of distributed program and a trivial
Distribution System Annex (DSA) implemetation to overview the
interface between compiler and DSA.

As an example we use "hello world" program that request remote partition
through this function call:

```ada
package API is

   pragma Remote_Call_Interface;

   function Hello_World (Text : String) return String;

end API;
```

## Code organization

We have two crates. The `dsa_fs` crates (in the root) provides DSA, while
`demo` crate contains "hello world" application. The `demo` consists of two
partitions (executables): server and client. Each partition has its own
project file and source code. ode in `demo/both` folder is shared between
client and server.

## Compilation process

To build client and server partitions run:

```sh
alr -C demo build
```

We don't use `gnatdist` here to simplify the example and describe how it works
under the hood. The compiler is invoked directly with corresponding switches:

```
-gnatzc   Distribution stub generation for caller stubs
-gnatzr   Distribution stub generation for receiver stubs
```

The client partition uses "caller stub" generated from the
`API` package specification. The stub is created by the GCC compiler invoked with 
`-gnatzc` flag. See corresponding part in `client.gpr` project file:

```
package Compiler is
   for Default_Switches ("Ada") use Demo_Config.Ada_Compiler_Switches;
   for Switches ("api.ads") use Demo_Config.Ada_Compiler_Switches & "-gnatzc";
end Compiler;
```

Note that `api.adb` is not used in the client partition, only `api.ads` is needed to
generate the stub.

On the server side both `api.ads` and `api.adb` files are used to build
the server partition. 

## DSA interface

To make `-gnatzc` and `-gnatzr` work the compiler relies on several DSA packages
that provide necessary functionality. THe first one if `System.Partition_Interface` package
where `PCS_Version` constant is defined. Value `1` means "Garlic" interface. We will use
this version in our example.

```ada
package System.Partition_Interface is
   PCS_Version : constant := 1;
```

### RPC
Another package `System.RPC` provides `Params_Stream_Type` type, inherited
from `System.Streams.Stream_Type`. It's used to marshal and unmarshal parameters/results
of remote calls. Two subprograms are defined to make RPC calls:

```ada
package System.RPC is
   type Params_Stream_Type is new System.Streams.Stream_Type with private;

   procedure Do_RPC
     (Partition  : Partition_ID;
      Params     : access Params_Stream_Type;
      Result     : access Params_Stream_Type);
   --  Synchronous call

   procedure Do_APC
     (Partition  : Partition_ID;
      Params     : access Params_Stream_Type);
   --  Asynchronous call

...
end System.RPC;
```

## Expanded code for caller side stub

The caller stub serializes parameters into `Params_Stream_Type` object and then
uses `Do_RPC` to perform synchronous remote calls. After the call returns the stub
deserializes the result from another `Params_Stream_Type` object.

The simplified version of the generated stub for `Hello_World` function looks like this:

```ada
Version : constant Unsigned :=
  System.Version_Control.Get_Version_String ("apiS");
--  Value of "apiS" version string evaluated by the compiler

package RCI_Locator is new
  System.Partition_Interface.RCI_Locator
    (RCI_Name => "API", Version => Version);

function Hello_World (Text : String) return String is
   Id : constant System.RPC.Partition_Id :=
     RCI_Locator.Get_Active_Partition_ID;

   Params : aliased System.RPC.Params_Stream_Type (0);

   Result : aliased System.RPC.Params_Stream_Type (0);
begin
   Unsigned_64'Write
    (Params'Access, RCI_Locator.Get_RCI_Package_Receiver);

   Unsigned'Write (Params'Access, 2);  --  Subprogram index?

   String'Write (Params'Access, Text);

   System.RPC.Do_RPC (Id, Params'Access, Result'Access);

   --  Read exception occurence and raise it if it's not null
   --  (skipped here for simplicity)

   return String'Input (Result'Access);
end Hello_World;
```

Full expanded text of the stub: [api.ads](expand/api.ads)

## Expanded code for receiver side stub

It's better read the receiver stub starting from the end of the file, where
the `Register_Receiving_Stub` procedure is called in the elaboration code.
Its arguments are:
- "API" - RCI name, used by the caller stub to locate the receiver stub
- `Dispatcher'Access` - address of the dispatcher procedure that will be
  called by the runtime when a remote call is received
- Version - used by the caller stub to check compatibility with the
  receiver stub
- Address and length of the table with subprogram addresses, used to
  get remote access to subprograms proxy object when a user request
  `Subprogram'Access`.

```ada
package body API is
...
begin
   System.Partition_Interface.Register_Receiving_Stub
     ("API",
      Dispatcher'Access,
      System.Version_Control.Get_Version_String ("api"),
      Table'Address,
      Table'Length);
end API;
```

The dispatcher procedure is responsible for dispatching the call
to the right handler based on the subprogram index. The simplified
version of the dispatcher looks like this:

```ada
package body API is
...
   procedure Dispatcher
     (R : System.Partition_Interface.Request_Access)
   is
      Id : System.Partition_Interface.Subprogram_Id :=
        System.Partition_Interface.Subprogram_Id'Input (R.Params);
   begin
      case Id is
         when 1 =>
            Handler_1 (R);
         when 2 =>
            Handler_2 (R);
      end case;
   end Dispatcher;  --  api__H7b

```

The handlers are responsible for deserializing parameters, calling
the user code and serializing the result. The simplified version of
the handler looks like this:

```ada
package body API is
...
   procedure Handler_2 (V : System.Partition_Interface.Request_Access) is
      Arg : String := String'Input (V.Params);
      Res : String := Hello_World (Arg);
   begin
      String'Write
        (V.Result,
         Ada.Exceptions.EO_To_String
           (Ada.Exceptions.Null_Occurrence));

      String'Write (V.Result, Res);
   exception
      when E : others =>
         String'Write
           (V.Result, Ada.Exceptions.EO_To_String (E));
   end Handler_2;  --  api__F29b
```

An auxiliary handler (number 1) is used to get remote access to subprograms
by subprogram index. This is used when the user requests `Subprogram'Access`
in the client code. The handler has the same structure as the main handler
and calls a function to get the address of the subprogram proxy object based
on the subprogram index:

```ada
package body API is
...
   function Get_Access
     (V : System.Partition_Interface.Subprogram_Id) return Unsigned_64;
   --  api__R8b

   procedure Handler_1 (V : System.Partition_Interface.Request_Access) is
      Id : System.Partition_Interface.Subprogram_Id :=
        System.Partition_Interface.Subprogram_Id'Input (V.Params);
      X : Unsigned_64 := Get_Access (Id);
   begin
      String'Write
        (V.Result,
         Ada.Exceptions.EO_To_String (Ada.Exceptions.Null_Occurrence));
      Unsigned_64'Write
        (V.Result, X);
   exception
      when E : others =>
         String'Write
           (V.Result, Ada.Exceptions.EO_To_String (E));
   end Handler_1;  --  api__F15b
```

The `Get_Access` function uses the table with subprogram addresses to return
the address of the requested subprogram proxy object:

```ada
   Table : aliased constant
     System.Partition_Interface.Rci_Subp_Info_Array (2 .. 2) :=
       (2 => Addr => A);

   function Get_Access (V : System.Partition_Interface.Subprogram_Id)
     return Unsigned_64 is
       (Table (V).Addr);  --  V must be 2
```

The corresponding types in System.Partition_Interface package are defined as:

```ada
type RCI_Subp_Info is record
   Addr : System.Address;
   --  Local address of the proxy object
end record;

type RCI_Subp_Info_Access is access all RCI_Subp_Info;
type RCI_Subp_Info_Array is array (Integer range <>) of
  aliased RCI_Subp_Info;
```

The proxy object is defined using `RAS_Proxy_Type` tagged types that has `Call` procedure. The `Call` procedure is called on dereferencing remote access to subprogram value.

```ada
type RAS_Proxy_Type is tagged limited record
   All_Calls_Remote : Boolean;
   Receiver         : System.Address;
   Subp_Id          : Subprogram_Id;
end record;

procedure Call 
  (Self : access T;
   Text : String;
   SL   : Natural) return String is
begin
   return Hello_World (Text);
end Call;

O : aliased RAS_Proxy_Type;
--  Remote-access-to-subprogram (RAS) type proxy for Hello_World function
A : constant System.Address := O'Address;
```

overall the generated code for the receiver stub looks like this:
```ada
package body API is
   function Get_Access
     (V : System.Partition_Interface.Subprogram_Id) return Unsigned_64;
   --  api__R8b

   procedure Handler_1
     (V : System.Partition_Interface.Request_Access) is ...
   --  api__F15b

   procedure Handler_2
     (V : System.Partition_Interface.Request_Access) is ...
   --  api__F29b

   package api__hello_worldP54b is
      --  package for RAS proxy type
      type api__hello_worldP54b__hello_worldP is
        tagged limited ...

      O : aliased RAS_Proxy_Type;
      --  Remote-access-to-subprogram (RAS) type proxy
      --  for Hello_World function
      A : constant System.Address := O'Address;
   end api__hello_worldP54b;

   package body api__hello_worldP54b is
      procedure Call 
        (Self : access T;
         Text : String;
         SL   : Natural) return String is ...
      --  api__hello_worldP54b___call
   end api__hello_worldP54b;

   Table : aliased constant
     System.Partition_Interface.Rci_Subp_Info_Array (2 .. 2) :=
       (2 => Addr => A);
   --  api__I9b 

   function Get_Access (V : System.Partition_Interface.Subprogram_Id)
     return Unsigned_64 is
       (Table (V).Addr);  --  V must be 2
   --  api__R8b

   procedure Dispatcher
     (R : System.Partition_Interface.Request_Access) ...
   --  api__H7b

   function Hello_World (Text : String) return String is ...;
   --  As defined in the user code

end API;
```

Full expanded text of the stub: [api.adb](expand/api.adb)

## Communication layer
We implement a trivial communication layer on top of stdin/stdout streams. Here is the output of client
partition:

```shell
$ ./demo/bin/client
Do_RPC. Partition: 7
Params: 0000000000000000020000000100000005000000576f726c64.
```

Decrypting the params stream:
```
0000_0000_0000_0000  0200_0000  0100_0000 0500_0000 576f726c64.
|_________________|  |_______|  |_______| |_______| |________|
|                    |          |         |         |
Receiver Id=0        Subprog   Text'First Text'Last Text
                     Index=2   =1         =5        "World"
```

```shell
$ ./demo/bin/client | ./demo/bin/server
Result: 0100000000000000010000000c00000048656c6c6f2c20576f726c64.
```

Decrypting the params stream:

```
0100_0000 0000_0000  0100_0000  0c00_0000 48656c6c6f2c20576f726c64.
|_________________|  |_______|  |_______| |______________________|
(1 .. 0 => <>) ""    R'First=1  R'Last=12 "Hello, World"
Empty exception name  R=Result ("Hello, World")
First = 1, Last = 0
```

Now, if you send this result back to the client, it prints the
result of the remote call (`Hello, World`).
