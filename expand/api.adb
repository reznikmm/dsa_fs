
with system.system__concat_2;
with system.system__secondary_stack;
with system.system__partition_interface;
with interfaces;
with system;
with ada.ada__exceptions;
with system.system__stream_attributes;
with system.system__strings.system__strings__stream_ops;
with ada.ada__tags;
with ada.ada__strings.ada__strings__text_buffers;
with system.system__put_images;
with system.system__soft_links;
with system.system__version_control;
with system.system__unsigned_types;

package body api is
   function api__R8b (subp_id : in
     system__partition_interface__subprogram_id) return
     interfaces__unsigned_64;

   procedure api__F15b (R11b :
     system__partition_interface__request_access) is
      P12b : system__partition_interface__subprogram_id;
   begin
      [constraint_error when
        R11b.params = null
        "access check failed"]
      [constraint_error when
        R11b.params = null
        "access check failed"]
      [type system__partition_interface__Tsubprogram_idB is new integer]
      R16b : constant system__partition_interface__Tsubprogram_idB :=
        system__partition_interface__Tsubprogram_idB!(
        $system__stream_attributes__i_u (R11b.params));
      [constraint_error when
        not (R16b >= 0)
        "range check failed"]
      P12b := R16b;
      B17b : declare
         R13b : constant interfaces__unsigned_64 := api__R8b (subp_id =>
           P12b);
      begin
         B18b : declare
            M19b : constant system__secondary_stack__mark_id :=
              $system__secondary_stack__ss_mark;
            procedure api__F15b__B17b__B18b___finalizer;
            freeze api__F15b__B17b__B18b___finalizer []

            procedure api__F15b__B17b__B18b___finalizer is
            begin
               $system__secondary_stack__ss_release (M19b);
               return;
            end api__F15b__B17b__B18b___finalizer;
         begin
            $system__strings__stream_ops__string_output_blk_io (R11b.
              result, $ada__exceptions__eo_to_string (
              ada__exceptions__null_occurrence), strmL => 0);
         end B18b;
         at end
            api__F15b__B17b__B18b___finalizer;
         [constraint_error when
           R11b.result = null
           "access check failed"]
         [constraint_error when
           R11b.result = null
           "access check failed"]
         $system__stream_attributes__w_lu (R11b.result,
           system__unsigned_types__long_unsigned!(R13b));
      end B17b;
      return;
   exception
      when E14b : others =>
         B21b : declare
            M22b : constant system__secondary_stack__mark_id :=
              $system__secondary_stack__ss_mark;
            procedure api__F15b__E20b__B21b___finalizer;
            freeze api__F15b__E20b__B21b___finalizer []

            procedure api__F15b__E20b__B21b___finalizer is
            begin
               $system__secondary_stack__ss_release (M22b);
               return;
            end api__F15b__E20b__B21b___finalizer;
         begin
            $system__strings__stream_ops__string_output_blk_io (R11b.
              result, $ada__exceptions__eo_to_string (E14b), strmL =>
              0);
         end B21b;
         at end
            api__F15b__E20b__B21b___finalizer;
         return;
   end api__F15b;

   procedure api__F29b (R23b :
     system__partition_interface__request_access) is
      M53b : constant system__secondary_stack__mark_id :=
        $system__secondary_stack__ss_mark;

      function api__F29b__S26b return string is
      begin
         B30b : begin
            type api__F29b__S26b__B30b__A33b is access all string;
            freeze api__F29b__S26b__B30b__A33b []
            R32b : constant api__F29b__S26b__B30b__A33b :=
              $system__strings__stream_ops__string_input_blk_io (R23b.
              params, strmL => 0)'reference;
            return R32b.all;
         exception
            when E25b : ada__tags__tag_error =>

                 $system__partition_interface__raise_program_error_unknown_tag
                 (E25b);
         end B30b;
      end api__F29b__S26b;

      type api__F29b__A39b is access all string;
      freeze api__F29b__A39b []
      R38b : constant api__F29b__A39b := api__F29b__S26b'reference;
      B37b : constant integer := R38b.all'first(1);
      B41b : constant integer := R38b.all'last(1);
      subtype api__F29b__TP24bS is string (B37b .. B41b);
      [constraint_error when
        B41b >= B37b and then (B37b < 1)
        "range check failed"]
      P24b : api__F29b__TP24bS renames R38b.all;
      procedure api__F29b___finalizer;
      freeze api__F29b___finalizer []

      procedure api__F29b___finalizer is
      begin
         $system__secondary_stack__ss_release (M53b);
         return;
      end api__F29b___finalizer;
   begin
      B42b : declare
         M50b : constant system__secondary_stack__mark_id :=
           $system__secondary_stack__ss_mark;
         type api__F29b__B42b__A46b is access all string;
         freeze api__F29b__B42b__A46b []
         R45b : constant api__F29b__B42b__A46b := api__hello_world (
           text => P24b)'reference;
         B44b : constant integer := R45b.all'first(1);
         B48b : constant integer := R45b.all'last(1);
         subtype api__F29b__B42b__TR27bS is string (B44b .. B48b);
         [constraint_error when
           B48b >= B44b and then (B44b < 1)
           "range check failed"]
         R27b : api__F29b__B42b__TR27bS renames R45b.all;
         procedure api__F29b__B42b___finalizer;
         freeze api__F29b__B42b___finalizer []

         procedure api__F29b__B42b___finalizer is
         begin
            $system__secondary_stack__ss_release (M50b);
            return;
         end api__F29b__B42b___finalizer;
      begin
         B49b : declare
         begin
            $system__strings__stream_ops__string_output_blk_io (R23b.
              result, $ada__exceptions__eo_to_string (
              ada__exceptions__null_occurrence), strmL => 0);
         end B49b;
         $system__strings__stream_ops__string_output_blk_io (R23b.
           result, R27b, strmL => 0);
      end B42b;
      at end
         api__F29b__B42b___finalizer;
      return;
   exception
      when E28b : others =>
         B52b : declare
         begin
            $system__strings__stream_ops__string_output_blk_io (R23b.
              result, $ada__exceptions__eo_to_string (E28b), strmL =>
              0);
         end B52b;
         return;
   end api__F29b;
   at end
      api__F29b___finalizer;


   package api__hello_worldP54b is
      type api__hello_worldP54b__hello_worldP is tagged limited
        private;
      api__hello_worldP54b___callE71b : boolean := false;
      function api__hello_worldP54b___call (S : access
        api__hello_worldP54b__hello_worldP; text : string; SL : natural)
        return string;
      api__hello_worldP54b__A : constant system__address;
   private
      type api__hello_worldP54b__hello_worldP is tagged limited record
         _tag : ada__tags__tag;
         all_calls_remote : boolean := false;
         receiver : system__address := system__null_address;
         subp_id : system__partition_interface__subprogram_id;
      end record;
      function api__hello_worldP54b___size (x :
        api__hello_worldP54b__hello_worldP) return long_long_integer;
      procedure api__hello_worldP54b__hello_worldPPI (s : in out
        ada__strings__text_buffers__Troot_buffer_typeC; v :
        api__hello_worldP54b__hello_worldP);
      procedure api__hello_worldP54b__hello_worldPDF (v : in out
        api__hello_worldP54b__hello_worldP; f : boolean := true);
      freeze api__hello_worldP54b__hello_worldP [
         null;
         subtype api__hello_worldP54b__Thello_worldPTS is
           ada__tags__dispatch_table_wrapper (1);
         api__hello_worldP54b__hello_worldPT : aliased constant
           ada__tags__dispatch_table_wrapper (1);
         $pragma import (ada, api__hello_worldP54b__hello_worldPT, "api__hello_worldP54b__hello_worldPT");
         api__hello_worldP54b__hello_worldPP : static constant
           ada__tags__tag := ada__tags__tag!(
           api__hello_worldP54b__hello_worldPT.prims_ptr'address);
         api__hello_worldP54b__hello_worldPY : constant system__address :=
           api__hello_worldP54b__hello_worldPT.predef_prims'address;
         subtype api__hello_worldP54b__hello_worldPG is
           ada__tags__address_array (1 .. 1);
         type api__hello_worldP54b__hello_worldPH is access
           api__hello_worldP54b__hello_worldPG;
         freeze api__hello_worldP54b__hello_worldPH []
         freeze api__hello_worldP54b___size []
         freeze api__hello_worldP54b__hello_worldPPI []
         freeze api__hello_worldP54b__hello_worldPDF []
         procedure api__hello_worldP54b__hello_worldPIP (_init : out
           api__hello_worldP54b__hello_worldP; P57b : natural := 0;
           _init_level : natural := 0) is
         begin
            if P57b = 0 then
               _init._tag := api__hello_worldP54b__hello_worldPP;
            end if;
            if P57b /= 3 then
               _init.all_calls_remote := false;
               _init.receiver := system__null_address;
            end if;
            null;
            return;
         end api__hello_worldP54b__hello_worldPIP;
         function api__hello_worldP54b___size (x :
           api__hello_worldP54b__hello_worldP) return long_long_integer is
         begin
            return long_long_integer(x'size);
         end api__hello_worldP54b___size;
         procedure api__hello_worldP54b__hello_worldPPI (s : in out
           ada__strings__text_buffers__Troot_buffer_typeC; v :
           api__hello_worldP54b__hello_worldP) is
         begin
            $system__put_images__put_image_unknown (s,
              "API.HELLO_WORLDP54B.HELLO_WORLDP");
            return;
         end api__hello_worldP54b__hello_worldPPI;
         procedure api__hello_worldP54b__hello_worldPDF (v : in out
           api__hello_worldP54b__hello_worldP; f : boolean := true) is
         begin
            null;
            return;
         end api__hello_worldP54b__hello_worldPDF;
      ]
      freeze api__hello_worldP54b__Thello_worldPC [
         procedure api__hello_worldP54b__Thello_worldPCFD (v :
           system__address) is
         begin
            B61b : declare
               system__soft_links__enter_master.all;
               _master : constant integer :=
                 system__soft_links__current_master.all;
               P58bM : integer renames _master;
               type api__hello_worldP54b__Thello_worldPCFD__B61b__P58b
                 is access all api__hello_worldP54b__Thello_worldPC;
               for api__hello_worldP54b__Thello_worldPCFD__B61b__P58b'
                 storage_size use 0;
               freeze
                 api__hello_worldP54b__Thello_worldPCFD__B61b__P58b []
               procedure
                 api__hello_worldP54b__Thello_worldPCFD__B61b___finalizer;
               freeze
                 api__hello_worldP54b__Thello_worldPCFD__B61b___finalizer []
               procedure
                 api__hello_worldP54b__Thello_worldPCFD__B61b___finalizer is
               begin
                  system__soft_links__abort_defer.all;
                  system__soft_links__complete_master.all;
                  system__soft_links__abort_undefer.all;
                  return;
               end
                 api__hello_worldP54b__Thello_worldPCFD__B61b___finalizer;
            begin
               [subtype
               [type api__hello_worldP54b__Thello_worldPCFD__B61b__T62b is procedure (
                 v : in out api__hello_worldP54b__Thello_worldPC, f :
                 boolean)]
                 api__hello_worldP54b__Thello_worldPCFD__B61b__T63b is access
                 api__hello_worldP54b__Thello_worldPCFD__B61b__T62b]
               api__hello_worldP54b__Thello_worldPCFD__B61b__T63b!(
                 ada__tags__predef_prims_table_ptr!(ada__tags__addr_ptr!
                 (system__address!(system__address!(system__address!(
                 api__hello_worldP54b__Thello_worldPCFD__B61b__P58b!(v).all.
                 _tag)) - 24)).all).all (9)).all (
                 api__hello_worldP54b__Thello_worldPCFD__B61b__P58b!(v).all,
                 true);
            end B61b;
            at end
               api__hello_worldP54b__Thello_worldPCFD__B61b___finalizer;
            return;
         end api__hello_worldP54b__Thello_worldPCFD;
      ]
      api__hello_worldP54b__O : aliased
        api__hello_worldP54b__hello_worldP;
      api__hello_worldP54b__hello_worldPIP (api__hello_worldP54b__O,
        P57b => 0, _init_level => 0);
      api__hello_worldP54b__A : constant system__address :=
        api__hello_worldP54b__O'address;
   end api__hello_worldP54b;

   package body api__hello_worldP54b is
      freeze api__hello_worldP54b___call []

      function api__hello_worldP54b___call (S : access
        api__hello_worldP54b__hello_worldP; text : string; SL : natural)
        return string is
         [program_error when not api__hello_worldP54b___callE71b "access before elaboration"]
         A65b : natural := natural'min(3, SL);
         subtype api__hello_worldP54b___call__S66b is string (text'
           first(1) .. text'last(1));
      begin
         type api__hello_worldP54b___call__A69b is access all string;
         freeze api__hello_worldP54b___call__A69b []
         R68b : constant api__hello_worldP54b___call__A69b :=
           api__hello_world (text)'reference;
         return R68b.all;
      end api__hello_worldP54b___call;

      api__hello_worldP54b___callE71b := true;
   end api__hello_worldP54b;
   subtype api__TI9bS is
     system__partition_interface__rci_subp_info_array (2 .. 2);
   null;
   null;
   api__I9b : aliased constant
     system__partition_interface__rci_subp_info_array (2 .. 2);
   api__I9b (2) := (
      addr => api__hello_worldP54b__A);
   freeze api__R8b []

   function api__R8b (subp_id : in
     system__partition_interface__subprogram_id) return
     interfaces__unsigned_64 is
   begin
      [constraint_error when
        not (integer(integer(subp_id)) in 2 .. 2)
        "index check failed"]
      return interfaces__unsigned_64?(api__I9b (integer(subp_id)).addr);
   end api__R8b;

   procedure api__H7b (r : system__partition_interface__request_access) is
      [constraint_error when
        r.params = null
        "access check failed"]
      [constraint_error when
        r.params = null
        "access check failed"]
      R77b : constant system__partition_interface__Tsubprogram_idB :=
        system__partition_interface__Tsubprogram_idB!(
        $system__stream_attributes__i_u (r.params));
      [constraint_error when
        not (R77b >= 0)
        "range check failed"]
      P10b : system__partition_interface__subprogram_id := R77b;
   begin
      if P10b = 0 then
         [constraint_error when
           r.params = null
           "access check failed"]
         [constraint_error when
           r.params = null
           "access check failed"]
         R78b : constant
           system__partition_interface__ras_proxy_type_access :=
           system__partition_interface__ras_proxy_type_access!(
           system__address?(interfaces__unsigned_64!(
           $system__stream_attributes__i_lu (r.params))));
         [constraint_error when
           R78b = null
           "access check failed"]
         P10b := R78b.all.subp_id;
      end if;
      case P10b is
         when 1 =>
            api__F15b (r);
         when 2 =>
            api__F29b (r);
         when others =>
            null;
      end case;
      return;
   end api__H7b;

   function api__hello_world (text : string) return string is
      subtype api__hello_world__S1b is string (text'first(1) .. text'
        last(1));
   begin
      L4b : constant integer := text'length;
      L5b : constant integer := 7 + L4b;
      subtype api__hello_world__TS6bS is string (1 .. 1 {+} (L5b -
        1));
      null;
      S6b : string (1 .. 1 {+} (L5b - 1));
      $system__concat_2__str_concat_2 (S6b, "Hello, ", text);
      return S6b[storage_pool = system__secondary_stack__ss_pool]
        [procedure_to_call = system__secondary_stack__ss_allocate];
   end api__hello_world;

   [type api__hello_worldP54b__T82b is any type'Class]
   freeze api__hello_worldP54b__T82b [
      subtype api__hello_worldP54b__Thello_worldPE84bS is string (1 ..
        33);
      api__hello_worldP54b__hello_worldPE84b : static constant string (
        1 .. 33) := "API.HELLO_WORLDP54B.HELLO_WORLDP["00"]";
      api__hello_worldP54b__hello_worldPH85b : ada__tags__tag :=
        ada__tags__no_tag;
      subtype api__hello_worldP54b__Thello_worldPB88bS is
        ada__tags__type_specific_data (0);
      api__hello_worldP54b__hello_worldPB88b : static aliased constant
        ada__tags__type_specific_data (0) := (
         idepth => 0,
         access_level => 0,
         alignment => natural(api__hello_worldP54b__hello_worldP'
           alignment),
         expanded_name => ada__tags__cstring_ptr!(
           api__hello_worldP54b__hello_worldPE84b'address),
         external_tag => ada__tags__cstring_ptr!(
           api__hello_worldP54b__hello_worldPE84b'address),
         ht_link => ada__tags__tag_ptr!(
           api__hello_worldP54b__hello_worldPH85b'address),
         transportable => false,
         is_abstract => false,
         needs_finalization => false,
         size_func => ada__tags__size_ptr!(api__hello_worldP54b___size'
           unrestricted_access),
         interfaces_table => null,
         ssd => null,
         tags_table => (api__hello_worldP54b__hello_worldPP));
      subtype api__hello_worldP54b__S89b is ada__tags__address_array;
      [subtype api__hello_worldP54b__T102b is ada__tags__address_array (
        1 .. 10)]
      api__hello_worldP54b__hello_worldPR86b : static aliased constant
        api__hello_worldP54b__T102b := (api__hello_worldP54b___size'
        unrestricted_access, null, null, null, null, null, null, null,
        api__hello_worldP54b__hello_worldPDF'unrestricted_access,
        api__hello_worldP54b__hello_worldPPI'unrestricted_access);
      subtype api__hello_worldP54b__Thello_worldPT83bS is
        ada__tags__dispatch_table_wrapper (1);
      api__hello_worldP54b__hello_worldPT : static aliased constant
        ada__tags__dispatch_table_wrapper (1) := (
         num_prims => 1,
         signature => ada__tags__primary_dt,
         tag_kind => ada__tags__tk_limited_tagged,
         predef_prims => api__hello_worldP54b__hello_worldPR86b'address,
         offset_to_top => 0,
         tsd => api__hello_worldP54b__hello_worldPB88b'address,
         prims_ptr => (api__hello_worldP54b___call'unrestricted_access));
      $pragma export (ada, api__hello_worldP54b__hello_worldPT, "api__hello_worldP54b__hello_worldPT");
      $ada__tags__check_tsd (api__hello_worldP54b__hello_worldPB88b'
        unchecked_access);
      $ada__tags__register_tag (api__hello_worldP54b__hello_worldPP);
   ]
   [type api__hello_worldP54b__T111b is any type'Class]
   freeze api__hello_worldP54b__T111b [
   ]
begin
   apiS : system__unsigned_types__unsigned;
   $pragma import (ada, apiS, "apiS");
   $system__partition_interface__register_receiving_stub ("API",
     api__H7b'unrestricted_access,
     $system__version_control__get_version_string (apiS), api__I9b'
     address, 1);
   null;
end api;
