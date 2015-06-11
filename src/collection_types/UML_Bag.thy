(*****************************************************************************
 * Featherweight-OCL --- A Formal Semantics for UML-OCL Version OCL 2.5
 *                       for the OMG Standard.
 *                       http://www.brucker.ch/projects/hol-testgen/
 *
 * UML_Sequence.thy --- Library definitions.
 * This file is part of HOL-TestGen.
 *
 * Copyright (c) 2012-2015 Université Paris-Sud, France
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


theory  UML_Bag
imports "../basic_types/UML_Boolean"
        "../basic_types/UML_Integer"
begin

no_notation None ("\<bottom>")
section{* Collection Type Sequence: Operations *}

subsection{* Definition: Strict Equality \label{sec:seq-strict-equality}*}

text{* After the part of foundational operations on bags, we detail here equality on bags.
Strong equality is inherited from the OCL core, but we have to consider
the case of the strict equality. We decide to overload strict equality in the
same way we do for other value's in OCL:*}

defs(overloaded)   StrictRefEq\<^sub>B\<^sub>a\<^sub>g :
      "((x::('\<AA>,'\<alpha>::null)Bag) \<doteq> y) \<equiv> (\<lambda> \<tau>. if (\<upsilon> x) \<tau> = true \<tau> \<and> (\<upsilon> y) \<tau> = true \<tau>
                                            then (x \<triangleq> y)\<tau>
                                            else invalid \<tau>)"


text{* Property proof in terms of @{term "profile_bin\<^sub>S\<^sub>t\<^sub>r\<^sub>o\<^sub>n\<^sub>g\<^sub>E\<^sub>q_\<^sub>v_\<^sub>v"}*}
interpretation  StrictRefEq\<^sub>B\<^sub>a\<^sub>g : profile_bin\<^sub>S\<^sub>t\<^sub>r\<^sub>o\<^sub>n\<^sub>g\<^sub>E\<^sub>q_\<^sub>v_\<^sub>v "\<lambda> x y. (x::('\<AA>,'\<alpha>::null)Bag) \<doteq> y" 
                by unfold_locales (auto simp: StrictRefEq\<^sub>B\<^sub>a\<^sub>g)



subsection{* Constants: mtBag *}
definition mtBag ::"('\<AA>,'\<alpha>::null) Bag"  ("Bag{}")
where     "Bag{} \<equiv> (\<lambda> \<tau>.  Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor>\<lambda>_. 0::nat\<rfloor>\<rfloor> )"


lemma mtSequence_defined[simp,code_unfold]:"\<delta>(Bag{}) = true"
apply(rule ext, auto simp: mtBag_def defined_def null_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def
                           bot_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_fun_def null_fun_def)
by(simp_all add: Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inject bot_option_def null_option_def)

lemma mtSequence_valid[simp,code_unfold]:"\<upsilon>(Bag{}) = true"
apply(rule ext,auto simp: mtBag_def valid_def null_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def
                          bot_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_fun_def null_fun_def)
by(simp_all add: Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inject bot_option_def null_option_def)

lemma mtSequence_rep_set: "\<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e (Bag{} \<tau>)\<rceil>\<rceil> = (\<lambda> _. 0)"
 apply(simp add: mtBag_def, subst Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse)
by(simp add: bot_option_def)+

text_raw{* \isatagafp *}

lemma [simp,code_unfold]: "const Bag{}"
by(simp add: const_def mtBag_def)

text{* Note that the collection types in OCL allow for null to be included;
  however, there is the null-collection into which inclusion yields invalid. *}

text_raw{* \endisatagafp *}


subsection{* Definition: Including *}

definition OclIncluding   :: "[('\<AA>,'\<alpha>::null) Bag,('\<AA>,'\<alpha>) val] \<Rightarrow> ('\<AA>,'\<alpha>) Bag"
where     "OclIncluding x y = (\<lambda> \<tau>. if (\<delta> x) \<tau> = true \<tau> \<and> (\<upsilon> y) \<tau> = true \<tau>
                                    then Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor> \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x \<tau>)\<rceil>\<rceil> 
                                                      ((y \<tau>):=\<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x \<tau>)\<rceil>\<rceil>(y \<tau>)+1) 
                                                    \<rfloor>\<rfloor>
                                    else invalid \<tau> )"
notation   OclIncluding   ("_->including\<^sub>B\<^sub>a\<^sub>g'(_')")

interpretation OclIncluding : 
               profile_bin\<^sub>d_\<^sub>v OclIncluding "\<lambda>x y. Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor> \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x)\<rceil>\<rceil> 
                                                      ((y):=\<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x)\<rceil>\<rceil>(y )+1) 
                                                    \<rfloor>\<rfloor>"
proof -  
   let ?X = "\<lambda>x y. \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x)\<rceil>\<rceil> ((y):=\<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x)\<rceil>\<rceil>( y )+1)"
   show "profile_bin\<^sub>d_\<^sub>v OclIncluding (\<lambda>x y. Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor> ?X x y \<rfloor>\<rfloor>)"
         apply unfold_locales  
          apply(auto simp:OclIncluding_def bot_option_def null_option_def 
                                           bot_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def null_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def)
          proof - fix x y show "Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor>?X x y\<rfloor>\<rfloor> = Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e None \<Longrightarrow> False"
          apply(rule contrapos_pp[where Q="Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor>?X x y\<rfloor>\<rfloor> = Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e None", simplified], simp)
          apply(subst (asm) Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inject)
            by(simp_all add:  null_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_option_def)
         apply_end(simp_all)

         fix x y show "Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor>?X x y\<rfloor>\<rfloor> = Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>None\<rfloor> \<Longrightarrow> False"
          apply(rule contrapos_pp[where Q="Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor>?X x y\<rfloor>\<rfloor> = Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>None\<rfloor>", simplified], simp)
          apply(subst (asm) Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inject)
            by(simp_all add:  null_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_option_def)
         apply_end(simp)
   qed
qed


             
syntax
  "_OclFinbag" :: "args => ('\<AA>,'a::null) Bag"    ("Bag{(_)}")
translations
  "Bag{x, xs}" == "CONST OclIncluding (Bag{xs}) x"
  "Bag{x}"     == "CONST OclIncluding (Bag{}) x "


subsection{* Definition: Excluding *}
definition OclExcluding   :: "[('\<AA>,'\<alpha>::null) Bag,('\<AA>,'\<alpha>) val] \<Rightarrow> ('\<AA>,'\<alpha>) Bag"
where     "OclExcluding x y = (\<lambda> \<tau>. if (\<delta> x) \<tau> = true \<tau> \<and> (\<upsilon> y) \<tau> = true \<tau>
                                    then Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor> \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x \<tau>)\<rceil>\<rceil> ((y \<tau>):=0::nat)  \<rfloor>\<rfloor> 
                                    else invalid \<tau> )"
notation   OclExcluding   ("_->excluding\<^sub>B\<^sub>a\<^sub>g'(_')")

interpretation OclExcluding:profile_bin\<^sub>d_\<^sub>v OclExcluding  
                                          "\<lambda>x y. Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor>\<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e(x)\<rceil>\<rceil>(y:=0::nat)\<rfloor>\<rfloor>"
proof -
    show "profile_bin\<^sub>d_\<^sub>v OclExcluding (\<lambda>x y. Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor>\<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e x\<rceil>\<rceil>(y := 0)\<rfloor>\<rfloor>)"
         apply unfold_locales  
         apply(auto simp:OclExcluding_def bot_option_def null_option_def  
                         null_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def)
         apply(subst (asm) Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inject,
               simp_all add: bot_option_def null_option_def)+
   done
qed

subsection{* Definition: Union *}
definition OclUnion   :: "[('\<AA>,'\<alpha>::null) Bag,('\<AA>,'\<alpha>) Bag] \<Rightarrow> ('\<AA>,'\<alpha>) Bag"
where     "OclUnion x y = (\<lambda> \<tau>. if (\<delta> x) \<tau> = true \<tau> \<and> (\<delta> y) \<tau> = true \<tau>
                                then Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor> \<lambda> X. \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e (x \<tau>)\<rceil>\<rceil> X + 
                                                       \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e (y \<tau>)\<rceil>\<rceil> X\<rfloor>\<rfloor>
                                else invalid \<tau> )"
notation   OclUnion   ("_->union\<^sub>B\<^sub>a\<^sub>g'(_')")

interpretation OclUnion : 
               profile_bin\<^sub>d_\<^sub>d OclUnion "\<lambda>x y. Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor> \<lambda> X. \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e x\<rceil>\<rceil> X + 
                                                                \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e y\<rceil>\<rceil> X\<rfloor>\<rfloor>"
proof -  
   show "profile_bin\<^sub>d_\<^sub>d OclUnion (\<lambda>x y. Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e \<lfloor>\<lfloor> \<lambda> X. \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e x\<rceil>\<rceil> X + \<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e y\<rceil>\<rceil> X\<rfloor>\<rfloor>)"
   apply unfold_locales 
   apply(auto simp:OclUnion_def bot_option_def null_option_def 
                   null_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def bot_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def)
   by(subst (asm) Abs_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inject,
      simp_all add: bot_option_def null_option_def)+
qed

subsection{* Definition: At *}
definition OclCount   :: "[('\<AA>,'\<alpha>::null) Bag,('\<AA>,'\<alpha>) val] \<Rightarrow> ('\<AA>) Integer"
where     "OclCount x y = (\<lambda> \<tau>. if (\<delta> x) \<tau> = true \<tau> \<and> (\<delta> y) \<tau> = true \<tau>
                             then  \<lfloor>\<lfloor>int(\<lceil>\<lceil>Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e (x \<tau>)\<rceil>\<rceil> (y \<tau>))\<rfloor>\<rfloor> 
                             else invalid \<tau> )"
notation   OclCount ("_->count\<^sub>B\<^sub>a\<^sub>g'(_')")
(*TODO Locale.*)  


subsection{* Definition: Iterate *}

definition OclIterate :: "[('\<AA>,'\<alpha>::null) Sequence,('\<AA>,'\<beta>::null)val,
                           ('\<AA>,'\<alpha>)val\<Rightarrow>('\<AA>,'\<beta>)val\<Rightarrow>('\<AA>,'\<beta>)val] \<Rightarrow> ('\<AA>,'\<beta>)val"
where     "OclIterate S A F = (\<lambda> \<tau>. if (\<delta> S) \<tau> = true \<tau> \<and> (\<upsilon> A) \<tau> = true \<tau> 
                                    then (foldr (F) (map (\<lambda>a \<tau>. a) \<lceil>\<lceil>Rep_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e (S \<tau>)\<rceil>\<rceil>))(A)\<tau>
                                    else \<bottom>)"
syntax  
  "_OclIterateSeq"  :: "[('\<AA>,'\<alpha>::null) Sequence, idt, idt, '\<alpha>, '\<beta>] => ('\<AA>,'\<gamma>)val"
                        ("_ ->iterate\<^sub>S\<^sub>e\<^sub>q'(_;_=_ | _')" (*[71,100,70]50*))
translations
  "X->iterate\<^sub>S\<^sub>e\<^sub>q(a; x = A | P)" == "CONST OclIterate X A (%a. (% x. P))"

(*TODO Locale - Equivalent*)  

(* TODO Frederic : Port Rest ...
  
subsection{* Definition: Forall *}
definition OclForall     :: "[('\<AA>,'\<alpha>::null) Sequence,('\<AA>,'\<alpha>)val\<Rightarrow>('\<AA>)Boolean] \<Rightarrow> '\<AA> Boolean"
where     "OclForall S P = (S->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = true | x and (P b)))"

syntax
  "_OclForallSeq" :: "[('\<AA>,'\<alpha>::null) Sequence,id,('\<AA>)Boolean] \<Rightarrow> '\<AA> Boolean"    ("(_)->forAll\<^sub>S\<^sub>e\<^sub>q'(_|_')")
translations
  "X->forAll\<^sub>S\<^sub>e\<^sub>q(x | P)" == "CONST UML_Sequence.OclForall X (%x. P)"

subsection{* Definition: Exists *}
definition OclExists     :: "[('\<AA>,'\<alpha>::null) Sequence,('\<AA>,'\<alpha>)val\<Rightarrow>('\<AA>)Boolean] \<Rightarrow> '\<AA> Boolean"
where     "OclExists S P = (S->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = false | x or (P b)))"

syntax
  "_OclExistSeq" :: "[('\<AA>,'\<alpha>::null) Sequence,id,('\<AA>)Boolean] \<Rightarrow> '\<AA> Boolean"    ("(_)->exists\<^sub>S\<^sub>e\<^sub>q'(_|_')")
translations
  "X->exists\<^sub>S\<^sub>e\<^sub>q(x | P)" == "CONST OclExists X (%x. P)"


subsection{* Definition: Collect *}
definition OclCollect     :: "[('\<AA>,'\<alpha>::null)Sequence,('\<AA>,'\<alpha>)val\<Rightarrow>('\<AA>,'\<beta>)val]\<Rightarrow>('\<AA>,'\<beta>::null)Sequence"
where     "OclCollect S P = (S->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = Sequence{} | x->prepend\<^sub>S\<^sub>e\<^sub>q(P b)))"

syntax
  "_OclCollectSeq" :: "[('\<AA>,'\<alpha>::null) Sequence,id,('\<AA>)Boolean] \<Rightarrow> '\<AA> Boolean"    ("(_)->collect\<^sub>S\<^sub>e\<^sub>q'(_|_')")
translations
  "X->collect\<^sub>S\<^sub>e\<^sub>q(x | P)" == "CONST OclCollect X (%x. P)"


subsection{* Definition: Select *}
definition OclSelect     :: "[('\<AA>,'\<alpha>::null)Sequence,('\<AA>,'\<alpha>)val\<Rightarrow>('\<AA>)Boolean]\<Rightarrow>('\<AA>,'\<alpha>::null)Sequence"
where     "OclSelect S P = 
           (S->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = Sequence{} | if P b then x->prepend\<^sub>S\<^sub>e\<^sub>q(b) else x endif))"

syntax
  "_OclSelectSeq" :: "[('\<AA>,'\<alpha>::null) Sequence,id,('\<AA>)Boolean] \<Rightarrow> '\<AA> Boolean"  ("(_)->select\<^sub>S\<^sub>e\<^sub>q'(_|_')")
translations
  "X->select\<^sub>S\<^sub>e\<^sub>q(x | P)" == "CONST UML_Sequence.OclSelect X (%x. P)"


subsection{* Definition: Size *}
definition OclSize     :: "[('\<AA>,'\<alpha>::null)Sequence]\<Rightarrow>('\<AA>)Integer" ("(_)->size\<^sub>S\<^sub>e\<^sub>q'(')")
where     "OclSize S = (S->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = \<zero> | x +\<^sub>i\<^sub>n\<^sub>t \<one> ))"

subsection{* Definition: IsEmpty *}
definition OclIsEmpty   :: "('\<AA>,'\<alpha>::null) Sequence \<Rightarrow> '\<AA> Boolean"
where     "OclIsEmpty x =  ((\<upsilon> x and not (\<delta> x)) or ((OclSize x) \<doteq> \<zero>))"
notation   OclIsEmpty     ("_->isEmpty\<^sub>S\<^sub>e\<^sub>q'(')" (*[66]*))

subsection{* Definition: NotEmpty *}

definition OclNotEmpty   :: "('\<AA>,'\<alpha>::null) Sequence \<Rightarrow> '\<AA> Boolean"
where     "OclNotEmpty x =  not(OclIsEmpty x)"
notation   OclNotEmpty    ("_->notEmpty\<^sub>S\<^sub>e\<^sub>q'(')" (*[66]*))

subsection{* Definition: Any *}

definition "OclANY x = (\<lambda> \<tau>.
  if x \<tau> = invalid \<tau> then
    \<bottom>
  else
    case drop (drop (Rep_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e (x \<tau>))) of [] \<Rightarrow> \<bottom>
                                              | l \<Rightarrow> hd l)"
notation   OclANY   ("_->any\<^sub>S\<^sub>e\<^sub>q'(')")

subsection{* Logical Properties *}

subsection{* Execution Laws with Invalid or Null as Argument *}

text{* OclIterate *}

lemma OclIterate_invalid[simp,code_unfold]:"invalid->iterate\<^sub>S\<^sub>e\<^sub>q(a; x = A | P a x) = invalid"  
by(simp add: OclIterate_def false_def true_def, simp add: invalid_def)

lemma OclIterate_null[simp,code_unfold]:"null->iterate\<^sub>S\<^sub>e\<^sub>q(a; x = A | P a x) = invalid"  
by(simp add: OclIterate_def false_def true_def, simp add: invalid_def)

lemma OclIterate_invalid_args[simp,code_unfold]:"S->iterate\<^sub>S\<^sub>e\<^sub>q(a; x = invalid | P a x) = invalid"
by(simp add: bot_fun_def invalid_def OclIterate_def defined_def valid_def false_def true_def)

text_raw{* \isatagafp *}

subsubsection{* Context Passing *}

lemma cp_OclIncluding:
"(X->including\<^sub>S\<^sub>e\<^sub>q(x)) \<tau> = ((\<lambda> _. X \<tau>)->including\<^sub>S\<^sub>e\<^sub>q(\<lambda> _. x \<tau>)) \<tau>"
by(auto simp: OclIncluding_def StrongEq_def invalid_def
                 cp_defined[symmetric] cp_valid[symmetric])

lemma cp_OclIterate: 
     "(X->iterate\<^sub>S\<^sub>e\<^sub>q(a; x = A | P a x)) \<tau> =
                ((\<lambda> _. X \<tau>)->iterate\<^sub>S\<^sub>e\<^sub>q(a; x = A | P a x)) \<tau>"
by(simp add: OclIterate_def cp_defined[symmetric])

lemmas cp_intro''\<^sub>S\<^sub>e\<^sub>q[intro!,simp,code_unfold] = 
       cp_OclIncluding [THEN allI[THEN allI[THEN allI[THEN cpI2]], of "OclIncluding"]]

subsubsection{* Const *}

text_raw{* \endisatagafp *}

subsection{* General Algebraic Execution Rules *}
subsubsection{* Execution Rules on Iterate *}

lemma OclIterate_empty[simp,code_unfold]:"Sequence{}->iterate\<^sub>S\<^sub>e\<^sub>q(a; x = A | P a x) = A"  
apply(simp add: OclIterate_def foundation22[symmetric] foundation13, 
      rule ext, rename_tac "\<tau>")
apply(case_tac "\<tau> \<Turnstile> \<upsilon> A", simp_all add: foundation18')
apply(simp add: mtSequence_def)
apply(subst Abs_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse) by auto

text{* In particular, this does hold for A = null. *}

lemma OclIterate_including[simp,code_unfold]:
assumes strict1 : "\<And>X. P invalid X = invalid"
and     P_valid_arg: "\<And> \<tau>. (\<upsilon> A) \<tau> = (\<upsilon> (P a A)) \<tau>"
and     P_cp    : "\<And> x y \<tau>. P x y \<tau> = P (\<lambda> _. x \<tau>) y \<tau>"
and     P_cp'   : "\<And> x y \<tau>. P x y \<tau> = P x (\<lambda> _. y \<tau>) \<tau>"
shows  "(S->including\<^sub>S\<^sub>e\<^sub>q(a))->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = A | P b x) = S->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = P a A| P b x)"
 apply(rule ext)
proof -
 have A: "\<And>S b \<tau>. S \<noteq> \<bottom> \<Longrightarrow> S \<noteq> null \<Longrightarrow> b \<noteq> \<bottom>  \<Longrightarrow>
                  \<lfloor>\<lfloor>\<lceil>\<lceil>Rep_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e S\<rceil>\<rceil> @ [b]\<rfloor>\<rfloor> \<in> {X. X = bot \<or> X = null \<or> (\<forall>x\<in>set \<lceil>\<lceil>X\<rceil>\<rceil>. x \<noteq> \<bottom>)}"
          by(auto intro!:Sequence_inv_lemma[simplified OclValid_def 
                                       defined_def false_def true_def null_fun_def bot_fun_def])          
 have P: "\<And>l A A' \<tau>. A \<tau> = A' \<tau> \<Longrightarrow> foldr P l A \<tau> = foldr P l A' \<tau>"
  apply(rule list.induct, simp, simp)
 by(subst (1 2) P_cp', simp)

 fix \<tau>
 show "OclIterate (S->including\<^sub>S\<^sub>e\<^sub>q(a)) A P \<tau> = OclIterate S (P a A) P \<tau>"
  apply(subst cp_OclIterate, subst OclIncluding_def, simp split:)
  apply(intro conjI impI)

   apply(simp add: OclIterate_def)
   apply(intro conjI impI)
     apply(subst Abs_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse[OF A],
           (simp add: foundation16[simplified OclValid_def] foundation18'[simplified OclValid_def])+)
     apply(rule P, metis P_cp)
    apply (metis P_valid_arg)
   apply(simp add: P_valid_arg[symmetric])
   apply (metis (lifting, no_types) OclIncluding.def_body' OclValid_def foundation16)
  apply(simp add: OclIterate_def defined_def invalid_def bot_option_def bot_fun_def false_def true_def)
  apply(intro impI, simp add: false_def true_def P_valid_arg)
 by (metis P_cp P_valid_arg UML_Types.bot_fun_def cp_valid invalid_def strict1 true_def valid1 valid_def)
qed

lemma OclIterate_prepend[simp,code_unfold]:
assumes strict1 : "\<And>X. P invalid X = invalid"
and     strict2 : "\<And>X. P X invalid = invalid"
and     P_cp    : "\<And> x y \<tau>. P x y \<tau> = P (\<lambda> _. x \<tau>) y \<tau>"
and     P_cp'   : "\<And> x y \<tau>. P x y \<tau> = P x (\<lambda> _. y \<tau>) \<tau>"
shows  "(S->prepend\<^sub>S\<^sub>e\<^sub>q(a))->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = A | P b x) = P a (S->iterate\<^sub>S\<^sub>e\<^sub>q(b; x = A| P b x))"
 apply(rule ext)
proof -
 have B: "\<And>S a \<tau>. S \<noteq> \<bottom> \<Longrightarrow> S \<noteq> null \<Longrightarrow> a \<noteq> \<bottom>  \<Longrightarrow>
                  \<lfloor>\<lfloor>a # \<lceil>\<lceil>Rep_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e S\<rceil>\<rceil>\<rfloor>\<rfloor> \<in> {X. X = bot \<or> X = null \<or> (\<forall>x\<in>set \<lceil>\<lceil>X\<rceil>\<rceil>. x \<noteq> \<bottom>)}"
          by(auto intro!:Sequence_inv_lemma[simplified OclValid_def 
                                       defined_def false_def true_def null_fun_def bot_fun_def])          
 fix \<tau>
 show "OclIterate (S->prepend\<^sub>S\<^sub>e\<^sub>q(a)) A P \<tau> = P a (OclIterate S A P) \<tau>"
  apply(subst cp_OclIterate, subst OclPrepend_def, simp split:)
  apply(intro conjI impI)

   apply(subst P_cp')
   apply(simp add: OclIterate_def)
   apply(intro conjI impI)
     apply(subst Abs_Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse[OF B],
           (simp add: foundation16[simplified OclValid_def] foundation18'[simplified OclValid_def])+)
     apply(simp add: P_cp'[symmetric])
     apply(subst P_cp, simp add: P_cp[symmetric])
    apply (metis (no_types) OclPrepend.def_body' OclValid_def foundation16)
   apply (metis P_cp' invalid_def strict2 valid_def)

  apply(subst P_cp',
        simp add: OclIterate_def defined_def invalid_def bot_option_def bot_fun_def false_def true_def,
        intro conjI impI)
     apply (metis P_cp' invalid_def strict2 valid_def)
    apply (metis P_cp' invalid_def strict2 valid_def)
   apply (metis (no_types) P_cp invalid_def strict1 true_def valid1 valid_def)
  apply (metis P_cp' invalid_def strict2 valid_def)
 done
qed


(* < *)

subsection{* Test Statements *}
(*
Assert   "(\<tau> \<Turnstile> (Sequence{\<lambda>_. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>} \<doteq> Sequence{\<lambda>_. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>}))"
Assert   "(\<tau> \<Turnstile> (Sequence{\<lambda>_. \<lfloor>x\<rfloor>} \<doteq> Sequence{\<lambda>_. \<lfloor>x\<rfloor>}))"
*)
(* (*TODO.*)  
open problem: An executable code-generator setup for the Sequence type. Some bits and pieces
so far : 
instantiation int :: equal
begin

definition
  "HOL.equal k l \<longleftrightarrow> k = (l::int)"

instance by default (rule equal_int_def)

end

lemma equal_int_code [code]:
  "HOL.equal 0 (0::int) \<longleftrightarrow> True"
  "HOL.equal 0 (Pos l) \<longleftrightarrow> False"
  "HOL.equal 0 (Neg l) \<longleftrightarrow> False"
  "HOL.equal (Pos k) 0 \<longleftrightarrow> False"
  "HOL.equal (Pos k) (Pos l) \<longleftrightarrow> HOL.equal k l"
  "HOL.equal (Pos k) (Neg l) \<longleftrightarrow> False"
  "HOL.equal (Neg k) 0 \<longleftrightarrow> False"
  "HOL.equal (Neg k) (Pos l) \<longleftrightarrow> False"
  "HOL.equal (Neg k) (Neg l) \<longleftrightarrow> HOL.equal k l"
  by (auto simp add: equal)
*)  
  
*)
instantiation Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e  :: (equal)equal
begin
  definition "HOL.equal k l \<longleftrightarrow>  (k::('a::equal)Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e) =  l"
  instance   by default (rule equal_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_def)
end

lemma equal_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_code [code]:
  "HOL.equal k (l::('a::{equal,null})Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e) \<longleftrightarrow> Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e k = Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e l"
  by (auto simp add: equal Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e.Rep_Bag\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inject)
  
Assert   "\<tau> \<Turnstile> (Bag{} \<doteq> Bag{})" 
(* TODO Frederic ?:
Assert   "\<tau> \<Turnstile> not(Bag{\<one>,\<one>}      \<triangleq> Bag{\<one>})" 
Assert   "\<tau> \<Turnstile> (Bag{\<one>,\<two>}         \<triangleq> Bag{\<two>,\<one>}" 
Assert   "\<tau> \<Turnstile> (Bag{\<one>,null}      \<triangleq> Bag{null,\<one>}" 
Assert   "\<tau> \<Turnstile> (Bag{\<one>,invalid,\<two>} \<triangleq> invalid)"
Assert   "\<tau> \<Turnstile> (Bag{\<one>,\<two>}->including\<^sub>B\<^sub>a\<^sub>g(null) \<triangleq> Bag{\<one>,\<two>,null})"
*)

(* > *)

end