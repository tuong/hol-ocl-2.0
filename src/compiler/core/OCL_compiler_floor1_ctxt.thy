(*****************************************************************************
 * Featherweight-OCL --- A Formal Semantics for UML-OCL Version OCL 2.4
 *                       for the OMG Standard.
 *                       http://www.brucker.ch/projects/hol-testgen/
 *
 * OCL_compiler_floor1_ctxt.thy ---
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

theory  OCL_compiler_floor1_ctxt
imports OCL_compiler_core_init
begin

section{* Translation of AST *}

subsection{* context *}

definition "print_ctxt_const ctxt ocl =
 (let attr_n = Ctxt_fun_name ctxt in
  map_pair (map_pair id (rev o List_map Thy_ty_synonym)) (rev o List_map Thy_consts_class)
    (List.fold
      (\<lambda>(var_at_when_hol, var_at_when_ocl, f_update_ocl) ((ocl, l_isab_ty), l_isab_const).
        let name = print_ctxt_const_name attr_n var_at_when_hol
          ; l_ty =
              List_map (\<lambda>n. (print_ctxt_ty n, n))
                (flatten
                  [ List_map snd (Ctxt_fun_ty_arg ctxt)
                  , [ case Ctxt_fun_ty_out ctxt of None \<Rightarrow> OclTy_base_void | Some s \<Rightarrow> s ] ]) in
        ( map_pair
            (let ocl = ocl \<lparr> D_accessor_rbt := f_update_ocl (\<lambda> l. name # l) (D_accessor_rbt ocl) \<rparr> in
             (\<lambda> D_higher_order_ty. ocl \<lparr> D_higher_order_ty := D_higher_order_ty \<rparr>))
            id
            (List.fold
              (\<lambda> (n, ty) (l, l_isab_ty).
                if is_higher_order ty & List_assoc n l = None then
                  ( (n, ty) # l
                  , let option = (\<lambda>x. Ty_apply (Ty_base ''option'') [x])
                      ; ty_set = \<lambda>b.
                          Type_synonym
                            n
                            (Ty_apply (Ty_base ''Set'')
                               [Ty_base unicode_AA, option (option (Ty_base (str_hol_of_ty (parse_ty_raw b)))) ]) in
                    (case ty of OclTy_collection Set OclTy_base_void \<Rightarrow> ty_set OclTy_base_void
                              | OclTy_collection Set OclTy_base_boolean \<Rightarrow> ty_set OclTy_base_boolean
                              | OclTy_collection Set OclTy_base_integer \<Rightarrow> ty_set OclTy_base_integer
                              | OclTy_collection Set OclTy_base_unlimitednatural \<Rightarrow> ty_set OclTy_base_unlimitednatural
                              | OclTy_collection Set OclTy_base_real \<Rightarrow> ty_set OclTy_base_real
                              | OclTy_collection Set OclTy_base_string \<Rightarrow> ty_set OclTy_base_string
                              | OclTy_collection Set (OclTy_raw t) \<Rightarrow> ty_set (OclTy_raw t)
                              (*| _ \<Rightarrow> (* FIXME generalize to higher order construction *) *)) # l_isab_ty)
                else
                  (l, l_isab_ty))
              l_ty
              (D_higher_order_ty ocl, l_isab_ty))
        , Consts_raw0
            name
            (ty_arrow (List_map Ty_base (Ctxt_ty ctxt # fst (List_split l_ty))))
            (mk_dot attr_n var_at_when_ocl)
            (Some (natural_of_nat (length (Ctxt_fun_ty_arg ctxt)))) # l_isab_const))
      [ (var_at_when_hol_post, var_at_when_ocl_post, update_D_accessor_rbt_post)
      , (var_at_when_hol_pre, var_at_when_ocl_pre, update_D_accessor_rbt_pre)]
      ((ocl, []), [])))"

definition "print_ctxt_gen_syntax_header_l l = Isab_thy (Theory_thm (Thm (List_map Thm_str l)))"
definition "print_ctxt_gen_syntax_header f_x l ocl =
 (let (l, ocl) = f_x l ocl in
  ( if D_generation_syntax_shallow ocl then
      l
    else
      Isab_thy_generation_syntax (Generation_syntax_shallow (D_design_analysis ocl))
      # Isab_thy_ml_extended (Ml_extended (Sexpr_ocl (ocl \<lparr> D_disable_thy_output := True
                                                          , D_file_out_path_dep := None
                                                          , D_output_position := (0, 0) \<rparr>) ))
      # l
  , ocl \<lparr> D_generation_syntax_shallow := True \<rparr> ))"

definition "print_ctxt_pre_post = (\<lambda>ctxt. print_ctxt_gen_syntax_header
  (\<lambda>l ocl.
    let ((ocl, l_isab_ty), l_isab) = print_ctxt_const ctxt ocl in
    (flatten [l_isab_ty, l_isab, l], ocl))
  [ Isab_thy_ocl_deep_embed_ast (Ocl2AstCtxtPrePost ctxt)
  , print_ctxt_gen_syntax_header_l [print_ctxt_pre_post_name (Ctxt_fun_name ctxt) var_at_when_hol_post] ])"

definition "print_ctxt_inv = (\<lambda>ctxt. print_ctxt_gen_syntax_header Pair
  [ Isab_thy_ocl_deep_embed_ast (Ocl2AstCtxtInv ctxt)
  , print_ctxt_gen_syntax_header_l
      (flatten (List_map (\<lambda> (tit, _).
        List_map (print_ctxt_inv_name (Ctxt_inv_ty ctxt) tit)
          [ var_at_when_hol_pre
          , var_at_when_hol_post ]) (Ctxt_inv_expr ctxt))) ])"

end