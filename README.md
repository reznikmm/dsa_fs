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

## Expanded code for client side stub

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

   return String'Input (Result'Access);
end Hello_World;
```

Full expanded text of the stub: [api.adb](expand/api.adb)

## Communication layer
We implement a trivial communication layer on top of stdin/stdout streams. Here is the output of client
partition:

```
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