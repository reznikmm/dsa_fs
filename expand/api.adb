package API is
with system.system__partition_interface;
with system.system__version_control;
with system.system__unsigned_types;
with system.system__rpc;
with ada.ada__exceptions;
with interfaces;
with ada.ada__tags;
with system;
with system.system__soft_links;
with system.system__stream_attributes;
with system.system__strings.system__strings__stream_ops;
with system.system__secondary_stack;
api_E : short_integer := 0;
package api is

   pragma Remote_Call_Interface;
   pragma remote_call_interface;

   function Hello_World (Text : String) return String;
   function api__hello_world (text : string) return string;
   package api__R1s is
      subtype api__R1s__Trci_nameS is string (1 .. 3);
      api__R1s__rci_name : constant string (1 .. 3) := "API";
      apiS : system__unsigned_types__unsigned;
      $pragma import (ada, apiS, "apiS");
      [subtype api__R1s__T4s is system__version_control__version_string]
      subtype api__R1s__T4s is system__version_control__version_string;
      api__R1s__version : constant api__R1s__T4s :=
        $system__version_control__get_version_string (apiS);

   --  Call to System.Version_Control.Get_Version_String

      package api__R1s__rci_locator renames api__R1s;
      pragma unreferenced (api__R1s__version);
      package api__R1s__rci_locatorGH renames api__R1s__rci_locator;
      function api__R1s__get_rci_package_receiver return interfaces.
        interfaces__unsigned_64;
      function api__R1s__get_active_partition_id return system__rpc.
        system__rpc__partition_id;

end API;
   end api__R1s;
   package R1s is new system__partition_interface__rci_locator (
     rci_name => "API", version =>
     $system__version_control__get_version_string (apiS));

   --  Instance of System.Partition_Interface.RCI_Locator ("API", version);

   function api__hello_world (text : string) return string is
      subtype api__hello_world__S10s is string (text'first(1) .. text'
        last(1));
      P5s : constant system__rpc__partition_id :=
        $api__R1s__get_active_partition_id;

      --  Call Get_Active_Partition_ID

      null;
      subtype api__hello_world__TS6sS is
        system__rpc__params_stream_type (0);
      freeze api__hello_world__TTS6sSC [
         procedure api__hello_world__TTS6sSCFD (v : system__address) is
         begin
            B12s : declare
               system__soft_links__enter_master.all;
               _master : constant integer :=
                 system__soft_links__current_master.all;
               P11sM : integer renames _master;
               type api__hello_world__TTS6sSCFD__B12s__P11s is access
                 all system__rpc__Tparams_stream_typeC;
               for api__hello_world__TTS6sSCFD__B12s__P11s'storage_size
                 use 0;
               freeze api__hello_world__TTS6sSCFD__B12s__P11s []
               procedure api__hello_world__TTS6sSCFD__B12s___finalizer;
               freeze api__hello_world__TTS6sSCFD__B12s___finalizer []
               procedure api__hello_world__TTS6sSCFD__B12s___finalizer is
               begin
                  system__soft_links__abort_defer.all;
                  system__soft_links__complete_master.all;
                  system__soft_links__abort_undefer.all;
                  return;
               end api__hello_world__TTS6sSCFD__B12s___finalizer;
            begin
               [type api__hello_world__TTS6sSCFD__B12s__T13s is procedure (
                 v : in out system__rpc__Tparams_stream_typeC, f :
                 boolean)]
               [subtype api__hello_world__TTS6sSCFD__B12s__T14s is access
                 api__hello_world__TTS6sSCFD__B12s__T13s]
               api__hello_world__TTS6sSCFD__B12s__T14s!(
                 ada__tags__predef_prims_table_ptr!(ada__tags__addr_ptr!
                 (system__address!(system__address!(system__address!(
                 api__hello_world__TTS6sSCFD__B12s__P11s!(v).all._tag)) -
                 24)).all).all (9)).all (
                 api__hello_world__TTS6sSCFD__B12s__P11s!(v).all, true);
            end B12s;
            at end
               api__hello_world__TTS6sSCFD__B12s___finalizer;
            return;
         end api__hello_world__TTS6sSCFD;
      ]
      S6s : aliased system__rpc__params_stream_type (0);

      --  Create object of Params_Stream_Type

      $system__rpc__params_stream_typeIP (S6s, 0, P10s => 0,
        _init_level => 2);
      null;
      subtype api__hello_world__TR7sS is
        system__rpc__params_stream_type (0);
      freeze api__hello_world__TTR7sSC [
         procedure api__hello_world__TTR7sSCFD (v : system__address) is
         begin
            B16s : declare
               system__soft_links__enter_master.all;
               _master : constant integer :=
                 system__soft_links__current_master.all;
               P15sM : integer renames _master;
               type api__hello_world__TTR7sSCFD__B16s__P15s is access
                 all system__rpc__Tparams_stream_typeC;
               for api__hello_world__TTR7sSCFD__B16s__P15s'storage_size
                 use 0;
               freeze api__hello_world__TTR7sSCFD__B16s__P15s []
               procedure api__hello_world__TTR7sSCFD__B16s___finalizer;
               freeze api__hello_world__TTR7sSCFD__B16s___finalizer []
               procedure api__hello_world__TTR7sSCFD__B16s___finalizer is
               begin
                  system__soft_links__abort_defer.all;
                  system__soft_links__complete_master.all;
                  system__soft_links__abort_undefer.all;
                  return;
               end api__hello_world__TTR7sSCFD__B16s___finalizer;
            begin
               [type api__hello_world__TTR7sSCFD__B16s__T17s is procedure (
                 v : in out system__rpc__Tparams_stream_typeC, f :
                 boolean)]
               [subtype api__hello_world__TTR7sSCFD__B16s__T18s is access
                 api__hello_world__TTR7sSCFD__B16s__T17s]
               api__hello_world__TTR7sSCFD__B16s__T18s!(
                 ada__tags__predef_prims_table_ptr!(ada__tags__addr_ptr!
                 (system__address!(system__address!(system__address!(
                 api__hello_world__TTR7sSCFD__B16s__P15s!(v).all._tag)) -
                 24)).all).all (9)).all (
                 api__hello_world__TTR7sSCFD__B16s__P15s!(v).all, true);
            end B16s;
            at end
               api__hello_world__TTR7sSCFD__B16s___finalizer;
            return;
         end api__hello_world__TTR7sSCFD;
      ]
      R7s : aliased system__rpc__params_stream_type (0);

      --  Create another object of Params_Stream_Type

      $system__rpc__params_stream_typeIP (R7s, 0, P10s => 0,
        _init_level => 2);
      E8s : ada__exceptions__exception_occurrence;
      $ada__exceptions__exception_occurrenceIP (E8s);
   begin
      $system__stream_attributes__w_lu (S6s'access,
        system__unsigned_types__long_unsigned!(
        $api__R1s__get_rci_package_receiver));

      --  write get_rci_package_receiver result

      $system__stream_attributes__w_u (S6s'access, 2);

      --  write 2
      
      $system__strings__stream_ops__string_output_blk_io (S6s'access,
        text, strmL => 2);

      --  write text
      
      $system__rpc__do_rpc (P5s, S6s'access, R7s'access, paramsL =>
        2, resultL => 2);

      --  call System.RPC.Do_RPC
      
      B29s : declare
         M30s : constant system__secondary_stack__mark_id :=
           $system__secondary_stack__ss_mark;
         procedure api__hello_world__B29s___finalizer;
         freeze api__hello_world__B29s___finalizer []
         procedure api__hello_world__B29s___finalizer is
         begin
            $system__secondary_stack__ss_release (M30s);
            return;
         end api__hello_world__B29s___finalizer;
      begin
         E8s := $ada__exceptions__string_to_eo (
           $system__strings__stream_ops__string_input_blk_io (R7s'
           access, strmL => 2));
      end B29s;
      at end
         api__hello_world__B29s___finalizer;
      $ada__exceptions__reraise_occurrence (E8s);
      B31s : begin
         type api__hello_world__B31s__A36s is access all string;
         freeze api__hello_world__B31s__A36s []
         R35s : constant api__hello_world__B31s__A36s :=
           $system__strings__stream_ops__string_input_blk_io (R7s'
           access, strmL => 2)'reference;

         --  Read and return result

         return R35s.all;
      exception
         when E9s : ada__tags__tag_error =>
              $system__partition_interface__raise_program_error_unknown_tag
              (E9s);
      end B31s;
   end api__hello_world;
end api;
