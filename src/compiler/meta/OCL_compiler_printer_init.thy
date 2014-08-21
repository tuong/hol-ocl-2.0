(*****************************************************************************
 * Featherweight-OCL --- A Formal Semantics for UML-OCL Version OCL 2.4
 *                       for the OMG Standard.
 *                       http://www.brucker.ch/projects/hol-testgen/
 *
 * OCL_compiler_printer_init.thy ---
 * This file is part of HOL-TestGen.
 *
 * Copyright (c) 2013-2014 Universite Paris-Sud, France
 *               2013-2014 IRT SystemX, France
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *
 *     * Neither the name of the copyright holders nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************)
(* $Id:$ *)

header{* Part ... *}

theory  OCL_compiler_printer_init
imports "~~/src/HOL/Library/Code_Char"
        "../OCL_compiler_init"
  keywords (* hol syntax *)
           "lazy_code_printing" "apply_code_printing" "apply_code_printing_reflect"
           :: thy_decl
begin

section{* Generation to Deep Form: OCaml *}

subsection{* beginning (lazy code printing) *}

ML{*
structure Code_printing = struct
datatype code_printing = Code_printing of (string * (bstring * Code_Printer.const_syntax option) list, string * (bstring * Code_Printer.tyco_syntax option) list,
              string * (bstring * string option) list, (string * string) * (bstring * unit option) list, (string * string) * (bstring * unit option) list,
              bstring * (bstring * (string * string list) option) list)
              Code_Symbol.attr
              list

structure Data_code = Theory_Data
  (type T = code_printing list Symtab.table
   val empty = Symtab.empty
   val extend = I
   val merge = Symtab.merge (K true))

val code_empty = ""

local
val parse_classrel_ident = Parse.class --| @{keyword "<"} -- Parse.class
val parse_inst_ident = Parse.xname --| @{keyword "::"} -- Parse.class

(* *)
fun parse_single_symbol_pragma parse_keyword parse_isa parse_target =
  parse_keyword |-- Parse.!!! (parse_isa --| (@{keyword "\<rightharpoonup>"} || @{keyword "=>"})
    -- Parse.and_list1 (@{keyword "("} |-- (Parse.name --| @{keyword ")"} -- Scan.option parse_target)))

fun parse_symbol_pragma parse_const parse_tyco parse_class parse_classrel parse_inst parse_module =
  parse_single_symbol_pragma @{keyword "constant"} Parse.term parse_const
    >> Code_Symbol.Constant
  || parse_single_symbol_pragma @{keyword "type_constructor"} Parse.type_const parse_tyco
    >> Code_Symbol.Type_Constructor
  || parse_single_symbol_pragma @{keyword "type_class"} Parse.class parse_class
    >> Code_Symbol.Type_Class
  || parse_single_symbol_pragma @{keyword "class_relation"} parse_classrel_ident parse_classrel
    >> Code_Symbol.Class_Relation
  || parse_single_symbol_pragma @{keyword "class_instance"} parse_inst_ident parse_inst
    >> Code_Symbol.Class_Instance
  || parse_single_symbol_pragma @{keyword "code_module"} Parse.name parse_module
    >> Code_Symbol.Module

fun parse_symbol_pragmas parse_const parse_tyco parse_class parse_classrel parse_inst parse_module =
  Parse.enum1 "|" (Parse.group (fn () => "code symbol pragma")
    (parse_symbol_pragma parse_const parse_tyco parse_class parse_classrel parse_inst parse_module))

in
val () =
  Outer_Syntax.command @{command_spec "lazy_code_printing"} "declare dedicated printing for code symbols"
    (parse_symbol_pragmas (Code_Printer.parse_const_syntax) (Code_Printer.parse_tyco_syntax)
      Parse.string (Parse.minus >> K ()) (Parse.minus >> K ())
      (Parse.text -- Scan.optional (@{keyword "attach"} |-- Scan.repeat1 Parse.term) [])
      >> (fn code =>
            Toplevel.theory (Data_code.map (Symtab.map_default (code_empty, []) (fn l => Code_printing code :: l)))))
end

fun apply_code_printing thy =
    (case Symtab.lookup (Data_code.get thy) code_empty of SOME l => rev l | _ => [])
 |> (fn l => fold (fn Code_printing l => fold Code_Target.set_printings l) l thy)

val () =
  Outer_Syntax.command @{command_spec "apply_code_printing"} "apply dedicated printing for code symbols"
    (Parse.$$$ "(" -- Parse.$$$ ")" >> K (Toplevel.theory apply_code_printing))

fun reflect_ml txt thy =
  case ML_Context.exec (fn () => ML_Context.eval_text false Position.none txt) (Context.Theory thy) of
    Context.Theory thy => thy

fun apply_code_printing_reflect thy =
    (case Symtab.lookup (Data_code.get thy) code_empty of SOME l => rev l | _ => [])
 |> (fn l => fold (fn Code_printing l =>
      fold (fn Code_Symbol.Module (_, l) =>
                 fold (fn ("SML", SOME (txt, _)) => reflect_ml txt
                        | _ => I) l
             | _ => I) l) l thy)

val () =
  Outer_Syntax.command @{command_spec "apply_code_printing_reflect"} "apply dedicated printing for code symbols"
    (Parse.ML_source >> (fn (txt, _) => Toplevel.theory (apply_code_printing_reflect o reflect_ml txt)))

end
*}

subsection{* beginning *}

  (* We put in 'CodeConst' functions using characters
     not allowed in a Isabelle 'code_const' expr
     (e.g. '_', '"', ...) *)

lazy_code_printing code_module "CodeType" \<rightharpoonup> (Haskell) {*
  type MlInt = Integer
; type MlMonad a = IO a
*} | code_module "CodeConst" \<rightharpoonup> (Haskell) {*
  import System.Directory
; import System.IO
; import qualified CodeConst.Printf

; outFile1 f file = (do
  fileExists <- doesFileExist file
  if fileExists then error ("File exists " ++ file ++ "\n") else do
    h <- openFile file WriteMode
    f (\pat -> hPutStr h . CodeConst.Printf.sprintf1 pat)
    hClose h)

; outStand1 :: ((String -> String -> IO ()) -> IO ()) -> IO ()
; outStand1 f = f (\pat -> putStr . CodeConst.Printf.sprintf1 pat)
*} | code_module "CodeConst.Monad" \<rightharpoonup> (Haskell) {*
  bind a = (>>=) a
; return :: a -> IO a
; return = Prelude.return
*} | code_module "CodeConst.Printf" \<rightharpoonup> (Haskell) {*
  import Text.Printf
; sprintf0 = id

; sprintf1 :: PrintfArg a => String -> a -> String
; sprintf1 = printf

; sprintf2 :: PrintfArg a => PrintfArg b => String -> a -> b -> String
; sprintf2 = printf

; sprintf3 :: PrintfArg a => PrintfArg b => PrintfArg c => String -> a -> b -> c -> String
; sprintf3 = printf

; sprintf4 :: PrintfArg a => PrintfArg b => PrintfArg c => PrintfArg d => String -> a -> b -> c -> d -> String
; sprintf4 = printf

; sprintf5 :: PrintfArg a => PrintfArg b => PrintfArg c => PrintfArg d => PrintfArg e => String -> a -> b -> c -> d -> e -> String
; sprintf5 = printf
*} | code_module "CodeConst.String" \<rightharpoonup> (Haskell) {*
  concat s [] = []
; concat s (x : xs) = x ++ concatMap ((++) s) xs
*} | code_module "CodeConst.Sys" \<rightharpoonup> (Haskell) {*
  import System.Directory
; isDirectory2 = doesDirectoryExist
*} | code_module "CodeConst.To" \<rightharpoonup> (Haskell) {*
  nat = id

*} | code_module "" \<rightharpoonup> (OCaml) {*
module CodeType = struct
  type mlInt = int

  type 'a mlMonad = 'a option
end

module CodeConst = struct
  let outFile1 f file =
    try
      let () = if Sys.file_exists file then Printf.eprintf "File exists \"%S\"\n" file else () in
      let oc = open_out file in
      let b = f (fun s a -> try Some (Printf.fprintf oc s a) with _ -> None) in
      let () = close_out oc in
      b
    with _ -> None

  let outStand1 f =
    f (fun s a -> try Some (Printf.fprintf stdout s a) with _ -> None)

  module Monad = struct
    let bind = function
        None -> fun _ -> None
      | Some a -> fun f -> f a
    let return a = Some a
  end

  module Printf = struct
    include Printf
    let sprintf0 = sprintf
    let sprintf1 = sprintf
    let sprintf2 = sprintf
    let sprintf3 = sprintf
    let sprintf4 = sprintf
    let sprintf5 = sprintf
  end

  module String = String

  module Sys = struct open Sys
    let isDirectory2 s = try Some (is_directory s) with _ -> None
  end

  module To = struct
    let nat big_int x = Big_int.int_of_big_int (big_int x)
  end
end

*} | code_module "" \<rightharpoonup> (Scala) {*
object CodeType {
  type mlMonad [A] = Option [A]
  type mlInt = Int
}

object CodeConst {
  def outFile1 [A] (f : (String => A => Option [Unit]) => Option [Unit], file0 : String) : Option [Unit] = {
    val file = new java.io.File (file0)
    if (file .isFile) {
      None
    } else {
      val writer = new java.io.PrintWriter (file)
      f ((fmt : String) => (s : A) => Some (writer .write (fmt .format (s))))
      Some (writer .close ())
    }
  }

  def outStand1 [A] (f : (String => A => Option [Unit]) => Option [Unit]) : Option[Unit] = {
    f ((fmt : String) => (s : A) => Some (print (fmt .format (s))))
  }

  object Monad {
    def bind [A, B] (x : Option [A], f : A => Option [B]) : Option [B] = x match {
      case None => None
      case Some (a) => f (a)
    }
    def Return [A] (a : A) = Some (a)
  }
  object Printf {
    def sprintf0 (x0 : String) = x0
    def sprintf1 [A1] (fmt : String, x1 : A1) = fmt .format (x1)
    def sprintf2 [A1, A2] (fmt : String, x1 : A1, x2 : A2) = fmt .format (x1, x2)
    def sprintf3 [A1, A2, A3] (fmt : String, x1 : A1, x2 : A2, x3 : A3) = fmt .format (x1, x2, x3)
    def sprintf4 [A1, A2, A3, A4] (fmt : String, x1 : A1, x2 : A2, x3 : A3, x4 : A4) = fmt .format (x1, x2, x3, x4)
    def sprintf5 [A1, A2, A3, A4, A5] (fmt : String, x1 : A1, x2 : A2, x3 : A3, x4 : A4, x5 : A5) = fmt .format (x1, x2, x3, x4, x5)
  }
  object String {
    def concat (s : String, l : List [String]) = l filter (_ .nonEmpty) mkString s
  }
  object Sys {
    def isDirectory2 (s : String) = Some (new java.io.File (s) .isDirectory)
  }
  object To {
    def nat [A] (f : A => BigInt, x : A) = f (x) .intValue ()
  }
}

*} | code_module "" \<rightharpoonup> (SML) {*
structure CodeType = struct
  type mlInt = string
  type 'a mlMonad = 'a option
end

structure CodeConst = struct
  structure Monad = struct
    val bind = fn
        NONE => (fn _ => NONE)
      | SOME a => fn f => f a
    val return = SOME
  end

  structure Printf = struct
    local
      fun sprintf s l =
        case String.fields (fn #"%" => true | _ => false) s of
          [] => ""
        | [x] => x
        | x :: xs =>
            let fun aux acc l_pat l_s =
              case l_pat of
                [] => rev acc
              | x :: xs => aux (String.extract (x, 1, NONE) :: hd l_s :: acc) xs (tl l_s) in
            String.concat (x :: aux [] xs l)
      end
    in
      fun sprintf0 s_pat = s_pat
      fun sprintf1 s_pat s1 = sprintf s_pat [s1]
      fun sprintf2 s_pat s1 s2 = sprintf s_pat [s1, s2]
      fun sprintf3 s_pat s1 s2 s3 = sprintf s_pat [s1, s2, s3]
      fun sprintf4 s_pat s1 s2 s3 s4 = sprintf s_pat [s1, s2, s3, s4]
      fun sprintf5 s_pat s1 s2 s3 s4 s5 = sprintf s_pat [s1, s2, s3, s4, s5]
    end
  end

  structure String = struct
    val concat = String.concatWith
  end

  structure Sys = struct
    val isDirectory2 = SOME o File.is_dir o Path.explode handle ERROR _ => K NONE
  end

  structure To = struct
    fun nat f = Int.toString o f
  end

  fun outFile1 f file =
    let
      val pfile = Path.explode file
      val () = if File.exists pfile then error ("File exists \"" ^ file ^ "\"\n") else ()
      val oc = Unsynchronized.ref []
      val _ = f (fn a => fn b => SOME (oc := Printf.sprintf1 a b :: (Unsynchronized.! oc))) in
      SOME (File.write_list pfile (rev (Unsynchronized.! oc))) handle _ => NONE
    end

  fun outStand1 f = outFile1 f (Unsynchronized.! stdout_file)
end

*}

subsection{* ML type *}

datatype ml_int = ML_int
code_printing type_constructor ml_int \<rightharpoonup> (Haskell) "CodeType.MlInt" (* syntax! *)
            | type_constructor ml_int \<rightharpoonup> (OCaml) "CodeType.mlInt"
            | type_constructor ml_int \<rightharpoonup> (Scala) "CodeType.mlInt"
            | type_constructor ml_int \<rightharpoonup> (SML) "CodeType.mlInt"

datatype 'a ml_monad = ML_monad 'a
code_printing type_constructor ml_monad \<rightharpoonup> (Haskell) "CodeType.MlMonad _" (* syntax! *)
            | type_constructor ml_monad \<rightharpoonup> (OCaml) "_ CodeType.mlMonad"
            | type_constructor ml_monad \<rightharpoonup> (Scala) "CodeType.mlMonad [_]"
            | type_constructor ml_monad \<rightharpoonup> (SML) "_ CodeType.mlMonad"

(* *)

type_synonym ml_string = String.literal

subsection{* ML code const *}

text{* ... *}

consts out_file1 :: "((ml_string \<Rightarrow> '\<alpha>1 \<Rightarrow> unit ml_monad) (* fprintf *) \<Rightarrow> unit ml_monad) \<Rightarrow> ml_string \<Rightarrow> unit ml_monad"
code_printing constant out_file1 \<rightharpoonup> (Haskell) "CodeConst.outFile1"
            | constant out_file1 \<rightharpoonup> (OCaml) "CodeConst.outFile1"
            | constant out_file1 \<rightharpoonup> (Scala) "CodeConst.outFile1"
            | constant out_file1 \<rightharpoonup> (SML) "CodeConst.outFile1"

consts out_stand1 :: "((ml_string \<Rightarrow> '\<alpha>1 \<Rightarrow> unit ml_monad) (* fprintf *) \<Rightarrow> unit ml_monad) \<Rightarrow> unit ml_monad"
code_printing constant out_stand1 \<rightharpoonup> (Haskell) "CodeConst.outStand1"
            | constant out_stand1 \<rightharpoonup> (OCaml) "CodeConst.outStand1"
            | constant out_stand1 \<rightharpoonup> (Scala) "CodeConst.outStand1"
            | constant out_stand1 \<rightharpoonup> (SML) "CodeConst.outStand1"

text{* module Monad *}

consts bind :: "'a ml_monad \<Rightarrow> ('a \<Rightarrow> 'b ml_monad) \<Rightarrow> 'b ml_monad"
code_printing constant bind \<rightharpoonup> (Haskell) "CodeConst.Monad.bind"
            | constant bind \<rightharpoonup> (OCaml) "CodeConst.Monad.bind"
            | constant bind \<rightharpoonup> (Scala) "CodeConst.Monad.bind"
            | constant bind \<rightharpoonup> (SML) "CodeConst.Monad.bind"

consts return :: "'a \<Rightarrow> 'a ml_monad"
code_printing constant return \<rightharpoonup> (Haskell) "CodeConst.Monad.return"
            | constant return \<rightharpoonup> (OCaml) "CodeConst.Monad.return"
            | constant return \<rightharpoonup> (Scala) "CodeConst.Monad.Return" (* syntax! *)
            | constant return \<rightharpoonup> (SML) "CodeConst.Monad.return"

text{* module Printf *}

consts sprintf0 :: "ml_string \<Rightarrow> ml_string"
code_printing constant sprintf0 \<rightharpoonup> (Haskell) "CodeConst.Printf.sprintf0"
            | constant sprintf0 \<rightharpoonup> (OCaml) "CodeConst.Printf.sprintf0"
            | constant sprintf0 \<rightharpoonup> (Scala) "CodeConst.Printf.sprintf0"
            | constant sprintf0 \<rightharpoonup> (SML) "CodeConst.Printf.sprintf0"

consts sprintf1 :: "ml_string \<Rightarrow> '\<alpha>1 \<Rightarrow> ml_string"
code_printing constant sprintf1 \<rightharpoonup> (Haskell) "CodeConst.Printf.sprintf1"
            | constant sprintf1 \<rightharpoonup> (OCaml) "CodeConst.Printf.sprintf1"
            | constant sprintf1 \<rightharpoonup> (Scala) "CodeConst.Printf.sprintf1"
            | constant sprintf1 \<rightharpoonup> (SML) "CodeConst.Printf.sprintf1"

consts sprintf2 :: "ml_string \<Rightarrow> '\<alpha>1 \<Rightarrow> '\<alpha>2 \<Rightarrow> ml_string"
code_printing constant sprintf2 \<rightharpoonup> (Haskell) "CodeConst.Printf.sprintf2"
            | constant sprintf2 \<rightharpoonup> (OCaml) "CodeConst.Printf.sprintf2"
            | constant sprintf2 \<rightharpoonup> (Scala) "CodeConst.Printf.sprintf2"
            | constant sprintf2 \<rightharpoonup> (SML) "CodeConst.Printf.sprintf2"

consts sprintf3 :: "ml_string \<Rightarrow> '\<alpha>1 \<Rightarrow> '\<alpha>2 \<Rightarrow> '\<alpha>3 \<Rightarrow> ml_string"
code_printing constant sprintf3 \<rightharpoonup> (Haskell) "CodeConst.Printf.sprintf3"
            | constant sprintf3 \<rightharpoonup> (OCaml) "CodeConst.Printf.sprintf3"
            | constant sprintf3 \<rightharpoonup> (Scala) "CodeConst.Printf.sprintf3"
            | constant sprintf3 \<rightharpoonup> (SML) "CodeConst.Printf.sprintf3"

consts sprintf4 :: "ml_string \<Rightarrow> '\<alpha>1 \<Rightarrow> '\<alpha>2 \<Rightarrow> '\<alpha>3 \<Rightarrow> '\<alpha>4 \<Rightarrow> ml_string"
code_printing constant sprintf4 \<rightharpoonup> (Haskell) "CodeConst.Printf.sprintf4"
            | constant sprintf4 \<rightharpoonup> (OCaml) "CodeConst.Printf.sprintf4"
            | constant sprintf4 \<rightharpoonup> (Scala) "CodeConst.Printf.sprintf4"
            | constant sprintf4 \<rightharpoonup> (SML) "CodeConst.Printf.sprintf4"

consts sprintf5 :: "ml_string \<Rightarrow> '\<alpha>1 \<Rightarrow> '\<alpha>2 \<Rightarrow> '\<alpha>3 \<Rightarrow> '\<alpha>4 \<Rightarrow> '\<alpha>5 \<Rightarrow> ml_string"
code_printing constant sprintf5 \<rightharpoonup> (Haskell) "CodeConst.Printf.sprintf5"
            | constant sprintf5 \<rightharpoonup> (OCaml) "CodeConst.Printf.sprintf5"
            | constant sprintf5 \<rightharpoonup> (Scala) "CodeConst.Printf.sprintf5"
            | constant sprintf5 \<rightharpoonup> (SML) "CodeConst.Printf.sprintf5"

text{* module String *}

consts String_concat :: "ml_string \<Rightarrow> ml_string list \<Rightarrow> ml_string"
code_printing constant String_concat \<rightharpoonup> (Haskell) "CodeConst.String.concat"
            | constant String_concat \<rightharpoonup> (OCaml) "CodeConst.String.concat"
            | constant String_concat \<rightharpoonup> (Scala) "CodeConst.String.concat"
            | constant String_concat \<rightharpoonup> (SML) "CodeConst.String.concat"

text{* module Sys *}

consts Sys_is_directory2 :: "ml_string \<Rightarrow> bool ml_monad"
code_printing constant Sys_is_directory2 \<rightharpoonup> (Haskell) "CodeConst.Sys.isDirectory2"
            | constant Sys_is_directory2 \<rightharpoonup> (OCaml) "CodeConst.Sys.isDirectory2"
            | constant Sys_is_directory2 \<rightharpoonup> (Scala) "CodeConst.Sys.isDirectory2"
            | constant Sys_is_directory2 \<rightharpoonup> (SML) "CodeConst.Sys.isDirectory2"

text{* module To *}

consts ToNat :: "(nat \<Rightarrow> integer) \<Rightarrow> nat \<Rightarrow> ml_int"
code_printing constant ToNat \<rightharpoonup> (Haskell) "CodeConst.To.nat"
            | constant ToNat \<rightharpoonup> (OCaml) "CodeConst.To.nat"
            | constant ToNat \<rightharpoonup> (Scala) "CodeConst.To.nat"
            | constant ToNat \<rightharpoonup> (SML) "CodeConst.To.nat"

subsection{* ... *}

locale s_of =
  fixes To_string :: "string \<Rightarrow> ml_string"
  fixes To_nat :: "nat \<Rightarrow> ml_int"

end