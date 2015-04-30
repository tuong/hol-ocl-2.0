(*****************************************************************************
 * Featherweight-OCL --- A Formal Semantics for UML-OCL Version OCL 2.5
 *                       for the OMG Standard.
 *                       http://www.brucker.ch/projects/hol-testgen/
 *
 * OCL_compiler_floor1_ctxt.thy ---
 * This file is part of HOL-TestGen.
 *
 * Copyright (c) 2013-2015 Université Paris-Sud, France
 *               2013-2015 IRT SystemX, France
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
 (let Ty_par = Ty_apply_paren \<open>(\<close> \<open>)\<close> (* because of potential ambiguities *)
    ; l_enum = List.map_filter (\<lambda> OclAstEnum e \<Rightarrow> Some e | _ \<Rightarrow> None) (D_ocl_env ocl)
    ; l_syn = List.map_filter (\<lambda> OclAstClassSynonym c \<Rightarrow> Some c | _ \<Rightarrow> None) (D_ocl_env ocl) in
  map_prod (map_prod id (rev o List_map Thy_ty_synonym)) (rev o List_map Thy_consts_class)
    (List.fold
      (\<lambda> Ctxt_inv _ \<Rightarrow> id
       | Ctxt_pp ctxt \<Rightarrow>
          let attr_n = Ctxt_fun_name ctxt in
          List.fold
            (\<lambda>(var_at_when_hol, var_at_when_ocl, f_update_ocl) ((ocl, l_isab_ty), l_isab_const).
              let name = print_ctxt_const_name attr_n var_at_when_hol
                ; (l_name, l) =
                    List.fold
                      (\<lambda> ty (l_name, l, l_isab_ty).
                        let ty = map_enum_syn l_enum l_syn ty
                          ; (n, isab_ty) = print_infra_type_synonym_class_rec_aux ty in
                        ( Ty_par (print_access_dot_consts_ty ty) # l_name
                        , if is_higher_order ty & \<not> List_member l n then
                            (String_to_String\<^sub>b\<^sub>a\<^sub>s\<^sub>e n # l, Type_synonym n isab_ty # l_isab_ty)
                          else
                            (l, l_isab_ty)))
                      (List_flatten
                          [ List_map snd (Ctxt_fun_ty_arg ctxt)
                          , [ case Ctxt_fun_ty_out ctxt of None \<Rightarrow> OclTy_base_void | Some s \<Rightarrow> s ] ])
                      ([], D_higher_order_ty ocl, l_isab_ty) in
              ( map_prod
                  (let ocl = ocl \<lparr> D_accessor_rbt := f_update_ocl (\<lambda> l. String_to_String\<^sub>b\<^sub>a\<^sub>s\<^sub>e name # l) (D_accessor_rbt ocl) \<rparr> in
                   (\<lambda> D_higher_order_ty. ocl \<lparr> D_higher_order_ty := D_higher_order_ty \<rparr>))
                  id
                  l
              , Consts_raw0
                  name
                  (ty_arrow (Ty_apply (Ty_base \<open>val\<close>) [Ty_base \<open>\<AA>\<close>, Ty_base \<open>'\<alpha>\<close>] # rev l_name))
                  (mk_dot attr_n var_at_when_ocl)
                  (Some (natural_of_nat (length (Ctxt_fun_ty_arg ctxt)))) # l_isab_const))
            [ (var_at_when_hol_post, var_at_when_ocl_post, update_D_accessor_rbt_post)
            , (var_at_when_hol_pre, var_at_when_ocl_pre, update_D_accessor_rbt_pre)])
      (Ctxt_clause ctxt)
      ((ocl, []), [])))"

definition "print_ctxt = (\<lambda>ctxt. bootstrap_floor
  (\<lambda>l ocl.
    let ((ocl, l_isab_ty), l_isab) = print_ctxt_const ctxt ocl in
    (List_flatten [l_isab_ty, l_isab, l], ocl))
  [ Isab_thy_ocl_deep_embed_ast (OclAstCtxt Floor2
      (map_invariant (\<lambda>T_inv b (OclProp_ctxt n p) \<Rightarrow>
                       T_inv b (OclProp_ctxt n (T_lambdas (Ctxt_param ctxt @@@@ [var_self]) p)))
                     (map_pre_post (\<lambda>pref ctxt. T_lambdas (make_ctxt_free_var pref ctxt))
                                   ctxt))) ])"

end
